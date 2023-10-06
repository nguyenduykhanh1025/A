PUBLISHABLES_LIBS=("product" "common-ui")

AFFECTED_LIBS=$(npx nx print-affected --type=lib --select=projects --base=$MASTER_BASE --head=HEAD --plain)

IS_LIBS_CHANGED=false

for PUBLISHABLES_LIB in ${PUBLISHABLES_LIBS[@]}
do
  if [[ "$AFFECTED_LIBS" == *"$PUBLISHABLES_LIB"* ]]; then
    echo "co"
    $IS_LIBS_CHANGED=true
  fi
done


echo $IS_LIBS_CHANGED

