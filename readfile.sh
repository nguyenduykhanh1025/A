info_changed_libs=./versions/info-changed-libs.txt
LIB_NAME=common-ui

echo "Check if '$info_changed_libs' exists"
if [ -f "$info_changed_libs" ]; then
    echo "'$info_changed_libs' exists."
    branchName=$(cat "$info_changed_libs" | grep "branchName" | cut -d'=' -f2 | xargs)
    updatedAt=$(cat "$info_changed_libs" | grep "updatedAt" | cut -d'=' -f2 | xargs)

    preReleaseIdValue=$(echo "$branchName"  | sed 's/[-|/|~|^| |:]/_/g')'_'$(echo "$updatedAt"  | sed 's/[-|/|~|^| |:]/_/g')

    echo "Delete old dependencies update branch..."
    git push origin --delete "feature/auto-update-$LIB_NAME-version" || true
    git branch -D "feature/auto-update-$LIB_NAME-version" || true

    echo "Create fresh update branch..."
    git checkout -q -b "feature/auto-update-$LIB_NAME-version"

    git push --set-upstream origin "feature/auto-update-$LIB_NAME-version"

    npx nx release $LIB_NAME prepatch --preReleaseId="$preReleaseIdValue"

    echo $preReleaseTag
else
    echo "'$info_changed_libs' not existing."
fi
