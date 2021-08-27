#!/bin/bash
rm -rf build ; npm run build ; rm -rf /var/www/tor ; mkdir /var/www/tor ; cp -rf build/* /var/www/tor ; chmod 777 /var/www/tor/* ; cp -rf /sysres/source/restapi/* /var/www/tor
