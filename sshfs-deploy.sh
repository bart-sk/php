#!/bin/bash
MOUNTPATH=$(pwd)/www-server-deploy
RSYNCPARAM=""
PWDL=$(pwd)

[ -e .rsyncignore ] && RSYNCPARAM="${RSYNCPARAM}--exclude-from=".rsyncignore" --exclude=".rsyncignore" "

[ -e $MOUNTPATH ] && rm -rf $MOUNTPATH

[ ! -z $2 ] && RSYNCPARAM="${RSYNCPARAM}--dry-run "

mkdir $MOUNTPATH

sshfs $1:www $MOUNTPATH

rsync -rlvP --update --inplace --no-i-r --progress --exclude=www-server-deploy $RSYNCPARAM . $MOUNTPATH/

fusermount -u $MOUNTPATH

rmdir $MOUNTPATH