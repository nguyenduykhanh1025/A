# ARGS
LIB_NAME=$1
ADDITIONAL_ARGS=${@:2}
GIT_BRANCH_CURRENT_NAME=$(git rev-parse --abbrev-ref HEAD | cut -d'/' -f 2)
timestamp=$(date +%s)

# CONST
PUBLISHABLES_LIBS=("product" "common-ui")
MASTER_BASE=main

AFFECTED_LIBS=$(npx nx print-affected --type=lib --select=projects --base=$MASTER_BASE --head=HEAD --plain)
echo $LIB_NAME
# if [[ "$AFFECTED_LIBS" == *"$LIB_NAME"* ]]; then
  echo "Checkout to $GIT_BRANCH_CURRENT before creating a new branch for changing the version of $LIB_NAME"
  git checkout $GIT_BRANCH_CURRENT

  echo "Delete old dependencies update branch..."
  git push origin --delete "feature/auto-update-$LIB_NAME-version" || true
  git branch -D "feature/auto-update-$LIB_NAME-version" || true

  echo "Create fresh update branch..."
  git checkout -q -b "feature/auto-update-$LIB_NAME-version"

  git push --set-upstream origin "feature/auto-update-$LIB_NAME-version"
  echo '----------------'
  echo $GIT_BRANCH_CURRENT_NAME
  npx nx release $LIB_NAME prepatch --preReleaseId="DUBASDK.$timestamp"
# fi
echo -e "✅ Done. ✅️"
