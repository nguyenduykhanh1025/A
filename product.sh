PUBLISHABLES_LIBS='product'
LIB_NAME=$(npx nx print-affected --type=lib --select=projects --plain)
if [[ " ${PUBLISHABLES_LIBS} " == *" $LIB_NAME "* ]]; then
  echo "Delete old dependencies update branch..."
  git push origin --delete "feature/auto-update-dependencies" || true
  git branch -D "feature/auto-update-dependencies" || true

  echo "Create fresh update branch..."
  git checkout -q -b "feature/auto-update-dependencies"

  npx nx release product
  exit 1
else
  printf "ko co"
  exit 1
fi


