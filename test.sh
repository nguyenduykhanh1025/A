fullName=feature/DUBASDK-344-sdk-frontend-create-display-tabular-data2^
# Var=$("$fullName" | sed -e "s/[-|/|~|^]/_/g")

comp=$(echo "$fullName"  | sed 's/[-|/|~|^]/_/g')

echo $comp

AFFECTED_LIBS=$(npx nx print-affected --type=lib --select=projects --base=$MASTER_BASE --head=HEAD --plain)

echo $AFFECTED_LIBS
