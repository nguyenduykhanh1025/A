PUBLISHABLES_LIBS=("keycloak" "base" "ui" "error-handling" "routing" "product")
FILES_LAST_CHANGED=$(git diff HEAD^ HEAD --name-only)
PUBLISHABLES_LIB_FOLDER=versions
ADDITIONAL_ARGS=--dry-run
echo $ADDITIONAL_ARGS;
echo "something"
echo $FILES_LAST_CHANGED;

for PUBLISHABLES_LIB in ${PUBLISHABLES_LIBS[@]}
do
  if [[ "$FILES_LAST_CHANGED" == *"$PUBLISHABLES_LIB_FOLDER/$PUBLISHABLES_LIB"* ]]; then
    echo $PUBLISHABLES_LIB
    echo "co"
  else
    echo ko
  fi
done
