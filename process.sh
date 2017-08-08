#!/bin/bash
script=$1
key=$2
version=$3
echo $script
echo $key
sed -i 's/UIUCIDENTIFIER/$key/' /pkg/base.pkg/PackageInfo
sed -i 's/UIUCVERSION/$version/' /pkg/base.pkg/PackageInfo
cp /data/$script /pkg/scripts/postinstall
chmod +x /pkg/scripts/postinstall
(cd /pkg/scripts &&  find . | cpio -o --format odc --owner 0:80 | gzip -c ) > /pkg/base.pkg/Scripts
(cd /pkg/base.pkg && xar --compression none -cf /data/$1.pkg *)
