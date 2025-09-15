# MariaDB to Storj Backup on Akash Network
Deploy a MariaDB instance and automated backup to Storj using Akash Network.

## Overview
[This SDL](https://github.com/eluvietiee/mariadb-backup/blob/main/sdl.yaml) deploys two services on Akash:
- mariadb: Runs MariaDB with main_db database.
- backup: Runs Alpine Linux with mariadb-client and rclone to dump and upload daily backups to Storj.

Backups are triggered via cron every minute. Data is stored exclusively on Storj — no persistent storage required on Akash.

## Requirements
- Akash wallet with sufficient $AKT
- Storj access key, secret key, and bucket name

## Deployment
1. Log in to the Akash Console [here](https://console.akash.network/new-deployment?step=edit-deployment) and paste the contents of [sdl.yaml](https://raw.githubusercontent.com/eluvietiee/mariadb-backup/refs/heads/main/sdl.yaml) into the editor. You can also use SDL with SHM storage enabled with [sdl-smh.yaml](https://raw.githubusercontent.com/eluvietiee/mariadb-backup/refs/heads/main/sdl-shm.yaml) file.
2. Edit the environment variables:
- `MARIADB_ROOT_PASSWORD`
- `STORJ_ACCESS_KEY`
- `STORJ_SECRET_KEY`
- `STORJ_BUCKET`
3. Set the backup interval in cron to your choice. Currently it is set to every minute (`*/1 * * * *`).
4. Click "Create Deployment".

## Backup Behavior
- Dumps main_db to SQL file daily (minute-by-minute in this config)
- Compresses with gzip
- Uploads to Storj bucket via rclone
- Cleans local files after upload
- The backup script is fetched from: https://raw.githubusercontent.com/eluvietiee/mariadb-backup/refs/heads/main/backup.sh
