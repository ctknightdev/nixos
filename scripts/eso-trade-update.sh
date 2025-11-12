#!/usr/bin/env bash

echo downloading....
curl -s -o /tmp/PriceTable.zip 'https://us.tamrieltradecentre.com/download/PriceTable' &&
echo extracting... &&
unzip -o -q /tmp/PriceTable.zip -d "/home/$USER/.steam/steam/steamapps/compatdata/306130/pfx/drive_c/users/steamuser/My Documents/Elder Scrolls Online/live/AddOns/TamrielTradeCentre/"
rm -f /tmp/PriceTable.zip
echo done
