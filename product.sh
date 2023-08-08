PUBLISHABLES_LIBS=('product')
LIB_NAME=$(npx nx print-affected --type=lib --select=projects --plain)
for PUBLISHABLES_LIB in PUBLISHABLES_LIBS
do
  if [[ " ${PUBLISHABLES_LIBS} " == *" $LIB_NAME "* ]]; then
    echo "Delete old dependencies update branch..."
    git push origin --delete "feature/auto-update-product-version" || true
    git branch -D "feature/auto-update-product-version" || true

    echo "Create fresh update branch..."
    git checkout -q -b "feature/auto-update-product-version"

    git push --set-upstream origin "feature/auto-update-product-version"
    npx nx release product
    exit 1
  else
    printf "ko co"
    exit 1
  fi
done

