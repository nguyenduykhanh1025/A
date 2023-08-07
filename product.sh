PUBLISHABLES_LIBS='product'
LIB_NAME=$(npx nx print-affected --type=lib --select=projects --plain)
if [[ " ${PUBLISHABLES_LIBS} " == *" $LIB_NAME "* ]]; then
  npx nx release product
  exit 1
else
  printf "ko co"
  exit 1
fi


