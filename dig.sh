#!/bin/sh

: > result.txt
: > remaining.txt

cat ./words.txt \
  | xargs -I$ dig @8.8.8.8 $.com \
  | tee -a result.txt \
  | grep -B 3 'verisign-grs' \
  | grep -oE "[a-z]{5}\.com" \
  | tee -a remaining.txt &


wait
git add -A
git commit -m "$(date +%Y%m%d)"
git push
