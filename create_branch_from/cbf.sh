#!/bin/bash
NEW_BRANCH="$1"
BASE_BRANCH="$2"
BRANCH_INDICATOR="On branch "

if [ "$NEW_BRANCH" == "" ]
then
  echo "Please specify the name of the new branch ex. cbf test-branch"
  exit 4
fi

if [ "$BASE_BRANCH" == "" ]
then
  BASE_BRANCH="master"
fi


# git status | grep "On branch " | sed "s/on branch //i" | read CURRENT_BRANCH
read CURRENT_BRANCH < <(git status 2> /dev/null | grep "$BRANCH_INDICATOR" | sed "s/$BRANCH_INDICATOR//i")

if [ "$?" -ne "0" ]
then
  echo "current directory is not a repository or git is not installed"
  exit 1
fi

if [ "$CURRENT_BRANCH" != "$BASE_BRANCH" ]
then
  git checkout "$BASE_BRANCH"
  if [ "$?" -ne "0" ]
  then
    echo "Failed to checkout branch $BASE_BRANCH"
    exit 2
  fi
fi

git pull origin "$BASE_BRANCH"
if [ "$?" -ne "0" ]
then
  echo "Failed to pull branch $BASE_BRANCH"
  exit 3
fi
git checkout -b "$NEW_BRANCH"