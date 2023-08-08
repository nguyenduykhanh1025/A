PUBLISHABLES_LIBS=('product' 'common-ui')
LIB_NAME=$(npx nx print-affected --type=lib --select=projects --plain)
echo $LIB_NAME
for PUBLISHABLES_LIB in ${PUBLISHABLES_LIBS[@]}
do
  echo $PUBLISHABLES_LIB
  if [[ " ${LIB_NAME} " == *" $PUBLISHABLES_LIB "* ]]; then
    echo "Delete old dependencies update branch..."
    git push origin --delete "feature/auto-update-$PUBLISHABLES_LIB-version" || true
    git branch -D "feature/auto-update-$PUBLISHABLES_LIB-version" || true

    echo "Create fresh update branch..."
    git checkout -q -b "feature/auto-update-$PUBLISHABLES_LIB-version"

    git push --set-upstream origin "feature/auto-update-$PUBLISHABLES_LIB-version"
    npx nx release $PUBLISHABLES_LIB
  else
    printf "ko co"
  fi
done
