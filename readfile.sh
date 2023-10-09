FILE_INFO_CHANGED_LIBS=./versions/info-changed-libs.txt
LIB_NAME=common-ui
VERSION_SPECIAL_SIGNAL_REGEX='s/[-|/|~|^| |:]/./g'
BRANCH_UPDATE_VERSION=feature/auto-update-$LIB_NAME-version

echo "Check if '$FILE_INFO_CHANGED_LIBS' exists"
if [ -f "$FILE_INFO_CHANGED_LIBS" ]; then
    echo "'$FILE_INFO_CHANGED_LIBS' exists."

    branchName=$(cat "$FILE_INFO_CHANGED_LIBS" | grep "branchName" | cut -d'=' -f2 | xargs)
    updatedAt=$(cat "$FILE_INFO_CHANGED_LIBS" | grep "updatedAt" | cut -d'=' -f2 | xargs)

    branchNameFormatted=$(echo "$branchName"  | sed "$VERSION_SPECIAL_SIGNAL_REGEX")
    updatedAt=$(echo "$updatedAt"  | sed "$VERSION_SPECIAL_SIGNAL_REGEX")

    preReleaseIdValue=$branchNameFormatted'.'$updatedAt
    echo "preReleaseId value: $preReleaseIdValue"

    echo "Delete old dependencies update branch..."
    git push origin --delete $BRANCH_UPDATE_VERSION || true
    git branch -D $BRANCH_UPDATE_VERSION || true

    echo "Create fresh update branch..."
    git checkout -q -b $BRANCH_UPDATE_VERSION

    git push --set-upstream origin $BRANCH_UPDATE_VERSION

    npx nx release $LIB_NAME prepatch --preReleaseId="$preReleaseIdValue"
else
    echo "'$FILE_INFO_CHANGED_LIBS' not existing."
fi
