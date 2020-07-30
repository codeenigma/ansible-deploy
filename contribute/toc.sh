#!/bin/sh
# shellcheck disable=SC2094
# shellcheck disable=SC2129

set -e

OWN_DIR=$(dirname "$0")
cd "$OWN_DIR" || exit 1
OWN_DIR=$(git rev-parse --show-toplevel)
cd "$OWN_DIR" || exit 1
OWN_DIR=$(pwd -P)

# @param
# $1 string filepath
cp_role_page(){
  RELATIVE=$(realpath --relative-to="$OWN_DIR" "$(dirname "$1")")
  if [ ! -d "$OWN_DIR/docs/$RELATIVE" ]; then
    mkdir -p "$OWN_DIR/docs/$RELATIVE"
  fi
  cp "$1" "$OWN_DIR/docs/$RELATIVE/index.md"
}

# @param
# $1 string folder
cp_single_page(){
  if [ ! -d "$OWN_DIR/docs/$1" ]; then
    mkdir "$OWN_DIR/docs/$1"
  fi
  cp "$OWN_DIR/$1/README.md" "$OWN_DIR/docs/$1/$1.md"
}

# @param
# $1 (string) filename
parse_role_variables(){
  TMP_MD=$(mktemp)
  WRITE=1
  # Ensure we have a trailing line.
  echo "" >> "$1"
  while read -r LINE; do
    case $LINE in
    '<!--ROLEVARS-->')
      echo "$LINE" >> "$TMP_MD"
      generate_role_variables "$1"
      WRITE=0
    ;;
    '<!--ENDROLEVARS-->')
      echo "$LINE" >> "$TMP_MD"
      WRITE=1
    ;;
    *)
    if [ $WRITE = 1 ]; then
      echo "$LINE" >> "$TMP_MD"
    fi
    ;;
    esac
  done < "$1"
  printf '%s\n' "$(cat "$TMP_MD")" > "$1"
  rm "$TMP_MD"
}

# @param
# $1 (string) filename
generate_role_variables(){
  VAR_FILE="$(dirname "$1")/defaults/main.yml"
  if [ -f "$VAR_FILE" ]; then
    echo "## Default variables"  >> "$TMP_MD"
    echo '```yaml' >> "$TMP_MD"
    cat "$VAR_FILE" >> "$TMP_MD"
    echo "" >> "$TMP_MD"
    echo '```' >> "$TMP_MD"
    echo "" >> "$TMP_MD"
  fi
}

rm -rf "$OWN_DIR/docs/roles"
ROLE_PAGES=$(find "$OWN_DIR/roles" -name "README.md")
for ROLE_PAGE in $ROLE_PAGES; do
  parse_role_variables "$ROLE_PAGE"
done
for ROLE_PAGE in $ROLE_PAGES; do
  cp_role_page "$ROLE_PAGE"
done

cp_single_page install
cp_single_page contribute
cp_single_page scripts