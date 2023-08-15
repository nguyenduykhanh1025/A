MASTER_BASE='main'
LIB_NAME='product'
AFFECTED_LIBS=$(npx nx print-affected --type=lib --select=projects --base=$MASTER_BASE --head=HEAD --plain)
timestamp=$(date +%s)
GIT_BRANCH_CURRENT_NAME=$(git rev-parse --abbrev-ref HEAD | cut -d'/' -f 2)
GIT_BRANCH_CURRENT_TYPE=$(git rev-parse --abbrev-ref HEAD | cut -d'/' -f 1)
INCREMENT_TAG=minor
GIT_BRANCH_CURRENT_TYPE_FEATURE=bugfix

if [[ "$AFFECTED_LIBS" == *"$LIB_NAME"* ]]; then
  # echo "Checkout to $MASTER_BASE before creating a new branch for changing the version of $LIB_NAME"
  # git checkout $MASTER_BASE

  echo "Delete old dependencies update branch..."
  git push origin --delete "bugfix/auto-update-$LIB_NAME-version" || true
  git branch -D "bugfix/auto-update-$LIB_NAME-version" || true

  echo "Create fresh update branch..."
  git checkout -q -b "bugfix/auto-update-$LIB_NAME-version"

  git push --set-upstream origin "bugfix/auto-update-$LIB_NAME-version"
  if [["$GIT_BRANCH_CURRENT_TYPE" == "$GIT_BRANCH_CURRENT_TYPE_FEATURE"]]
  then
    INCREMENT_TAG="minor"
  else
    INCREMENT_TAG="patch"
  fi
  # --increment=minor
  echo $INCREMENT_TAG

  npx nx release $LIB_NAME --increment=$INCREMENT_TAG --preRelease="$GIT_BRANCH_CURRENT_NAME.$timestamp"

  echo "Start to publish $LIB_NAME library to npm"
  ./scripts/build-and-publish-lib.sh $LIB_NAME --dry-run
fi
echo -e "✅ Done. ✅️"
