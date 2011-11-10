#!/bin/bash

site=$1

if [ -z "$site" ]
then
echo "Usage: $0 <site>"
exit 1
fi

tempdir=$TMPDIR/load_tarchive_db.$$
mkdir -p $tempdir
cp /data/incoming/${site}IBIS/incoming/tarchive_data.sql.gz $tempdir/
gunzip $tempdir/tarchive_data.sql.gz
mysql --defaults-file=/home/ibis/mriscript.my.cnf -e "DELETE FROM tarchive WHERE neurodbCenterName='${site}'"
mysql --defaults-file=/home/ibis/mriscript.my.cnf < $tempdir/tarchive_data.sql
rm -fr $tempdir
