#!/bin/sh

resultfile="result-com.txt"

echo "" > $resultfile

cat words.txt \
  | xargs -I@ whois @.com \
  | grep "^No match" \
  | sed 's/^.*"\(.*\)".*$/\1/' \
  | tr 'A-Z' 'a-z' \
  | tee -a $resultfile &


wait
git add -A
git commit -m "$(date +%Y%m%d)"
git push
