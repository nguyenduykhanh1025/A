MASTER_BASE='main'
LIB_NAME='product'
AFFECTED_LIBS=$(npx nx print-affected --type=lib --select=projects --base=$MASTER_BASE --head=HEAD --plain)
GIT_BRANCH_CURRENT_REALLY=$(git rev-parse --abbrev-ref HEAD)
timestamp=$(date +%s)
GIT_BRANCH_CURRENT='main'
git checkout $GIT_BRANCH_CURRENT

echo 'pllllllllll'

if [[ "$AFFECTED_LIBS" == *"$LIB_NAME"* ]]; then
  echo "Checkout to $MASTER_BASE before creating a new branch for changing the version of $LIB_NAME"
  git checkout $MASTER_BASE

  echo "Delete old dependencies update branch..."
  git push origin --delete "feature/auto-update-$LIB_NAME-version" || true
  git branch -D "feature/auto-update-$LIB_NAME-version" || true

  echo "Create fresh update branch..."
  git checkout -q -b "feature/auto-update-$LIB_NAME-version"

  git push --set-upstream origin "feature/auto-update-$LIB_NAME-version"
  npx nx release $LIB_NAME --preRelease="$GIT_BRANCH_CURRENT_REALLY.$timestamp"

  echo "Start to publish $LIB_NAME library to npm"
  ./scripts/build-and-publish-lib.sh $LIB_NAME --dry-run
fi
echo -e "✅ Done. ✅️"
