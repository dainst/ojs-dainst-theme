mkdir ojs-2.4.8.1



sudo git clone -b ojs-stable-2_4_8 https://github.com/pkp/ojs.git ojs-2.4.8.1

cd ojs-2.4.8.1

sed -i -e 's/git:/https:/g' .gitmodules 

git submodule init
git submodule update

cp ../ojs-2.4.8.0/config.inc.php .
cp -R ../ojs-2.4.8.0/public/ .
cp -R ../ojs-2.4.8.0/plugins/themes/dainst/ plugins/themes/
chown -R www-data:www-data *
chmod -R 777 plugins/themes/dainst/
chmod 777 ojs-2.4.8.1

---

ln  -s ../ojs_shared/public
ln  -s ../ojs_shared/config.inc.php
ln  -s ../ojs_shared/ojs-dainst-theme/ plugins/themes
chown -R www-data:www-data ojs