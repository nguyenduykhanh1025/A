git checkout -b product-new-version
git remote set-url origin "git@github.com:nguyenduykhanh1025/A.git"
git pull origin master
git fetch --tags
npm install
npx nx release product
