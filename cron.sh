#!/bin/sh

# 51 * * * * /crypt/home/lnovy/htdocs/krtek.net/index1/cpsdonation/cron.sh

cd /crypt/home/lnovy/htdocs/krtek.net/index1/cpsdonation

make > update.log 2>&1
rm -f cache/*

diff update.log update.log.ref
