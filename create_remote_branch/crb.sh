#!/bin/bash
BRANCH_INDICATOR="On branch "

# git status | grep "On branch " | sed "s/on branch //i" | read CURRENT_BRANCH
read CURRENT_BRANCH < <(git status 2> /dev/null | grep "$BRANCH_INDICATOR" | sed "s/$BRANCH_INDICATOR//i")

if [ "$?" -ne "0" ]
then
  echo "current directory is not a repository or git is not installed"
  exit 1
fi

git push -u origin "${CURRENT_BRANCH}"
