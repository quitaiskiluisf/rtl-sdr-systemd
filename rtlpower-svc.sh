#! /bin/bash

RUNNING=1;

trap 'RUNNING=0' SIGINT;

while [ $RUNNING -ne 0 ]; do
  TMPFILE=$(mktemp);
  rtl_power -1 $RTLPOWER_ARGS > $TMPFILE;
  DATE=$(head -n 1 $TMPFILE | cut -c 1-10);
  cat $TMPFILE | gzip -c $GZIP_ARGS >> "${FILE_PREFIX}.${DATE}.gz";
  rm -rf $TMPFILE;
done
