#!/bin/bash
MOUNTPATH=$(pwd)/www-server-deploy
RSYNCPARAM=""
PWDL=$(pwd)

[ -e .rsyncignore ] && RSYNCPARAM="${RSYNCPARAM}--exclude-from=".rsyncignore" --exclude=".rsyncignore" "

[ -e $MOUNTPATH ] && rm -rf $MOUNTPATH

USERPARAMS=""
i=0
for userparam in "$@"
do
  if [ $i != 0 ]; then
    USERPARAMS="$USERPARAMS $userparam"
  fi
  i=1
done

mkdir $MOUNTPATH

sshfs $1:www $MOUNTPATH

rsync -avzc --no-times --no-perms --no-owner --no-group --exclude=www-server-deploy $RSYNCPARAM $USERPARAMS . $MOUNTPATH/

fusermount -u $MOUNTPATH

rmdir $MOUNTPATH
