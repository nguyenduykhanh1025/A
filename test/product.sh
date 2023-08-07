git clone https://github.com/nguyenduykhanh1025/A.git
cd A
git checkout -b product-new-version
git fetch --tags
npm install
npx nx release product
