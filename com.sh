PUBLISHABLES_LIBS=('versions/product-lib.json')
LIB_NAME=$(git diff HEAD^ HEAD --name-only)
echo $LIB_NAME
for PUBLISHABLES_LIB in ${PUBLISHABLES_LIBS[@]}
do
  if [[ "$LIB_NAME" == *"$PUBLISHABLES_LIB"* ]]; then
    echo "co"

    ./scripts/build-and-publish-lib.sh $PUBLISHABLES_LIB --dry-run
  fi
done
