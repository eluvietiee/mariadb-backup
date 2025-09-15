#!/bin/sh

mysqldump -h $DB_HOST -u $DB_USER -p$DB_PASSWORD main_db > /tmp/db_backup.sql

rclone config create storj s3 \
  provider Storj \
  access_key_id $STORJ_ACCESS_KEY \
  secret_access_key $STORJ_SECRET_KEY \
  endpoint https://gateway.storjshare.io \
  region us-east-1

rclone copy /tmp/db_backup.sql storj:$STORJ_BUCKET/$(date +%Y-%m-%d-%H%M%S).sql

rm /tmp/db_backup.sql
