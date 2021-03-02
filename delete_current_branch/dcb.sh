#!/bin/bash
CHECKOUT_BRANCH="$1"
BRANCH_INDICATOR="On branch "

if [ "$CHECKOUT_BRANCH" == "" ]
then
  CHECKOUT_BRANCH="master"
fi


# git status | grep "On branch " | sed "s/on branch //i" | read CURRENT_BRANCH
read CURRENT_BRANCH < <(git status | grep "$BRANCH_INDICATOR" | sed "s/$BRANCH_INDICATOR//i")

if [ "$?" -ne "0" ]
then
  echo "current directory is not a directory or git is not installed"
  exit 1
fi

if [ "$CURRENT_BRANCH" == "$CHECKOUT_BRANCH" ]
then
  echo "Checkout branch ($CHECKOUT_BRANCH) could not be the current branch (CURRENT_BRANCH)"
  echo "use 'dcb ANOTHER_BRANCH_TO_CHECKOUT' to delete current branch"
  exit 2
fi

git checkout "$CHECKOUT_BRANCH"
git branch -D "$CURRENT_BRANCH"