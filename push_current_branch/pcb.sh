#!/bin/bash
REMOTE="$1"
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
REMOTE_OPTION=""

if [ "$REMOTE" == "" ]; then
  REMOTE="origin"
fi

check_for_remote_existance() {
  git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null 1>/dev/null
  return "$?"
}

check_for_remote_existance

if [ "$?" == "128" ]; then
  REMOTE_OPTION=" -u ${REMOTE} ${CURRENT_BRANCH}"
fi

git push${REMOTE_OPTION}
