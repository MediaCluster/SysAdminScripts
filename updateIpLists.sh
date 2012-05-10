#!/bin/bash

/usr/bin/wget -c --no-check-certificate 'https://zeustracker.abuse.ch/blocklist.php?download=ipblocklist' -O '/etc/iptables/zeus-list.txt' > /dev/null 2>&1
echo "Zeus Tracker IP blocklist updated"

/usr/bin/wget -c 'http://www.spamhaus.org/drop/drop.lasso' -O spamhaus.txt > /dev/null 2>&1
echo "SPAMHAUS   DROP (Don't Route Or Peer) List updated"

echo "Reloading IPTABLES  Rules"
/etc/init.d/firewall restart
