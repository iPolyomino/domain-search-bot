#!/bin/sh

echo "" > result.txt
echo "" > remaining.txt

cat ./words.txt \
  | xargs -I$ dig @8.8.8.8 $.com \
  | tee -a result.txt \
  | grep -B 3 'verisign-grs' \
  | grep -E "^;[a-z]{5}" \
  | tee -a remaining.txt &


wait
git add -A
git commit -m "$(date +%Y%m%d)"
git push
