#!/bin/bash
CHECKOUT_BRANCH="$1"
BRANCH_INDICATOR="On branch "

if [ "$CHECKOUT_BRANCH" == "" ]
then
  CHECKOUT_BRANCH="master"
fi


# git status | grep "On branch " | sed "s/on branch //i" | read CURRENT_BRANCH
read CURRENT_BRANCH < <(git status 2> /dev/null | grep "$BRANCH_INDICATOR" | sed "s/$BRANCH_INDICATOR//i")

if [ "$?" -ne "0" ]
then
  echo "current directory is not a repository or git is not installed"
  exit 1
fi

if [ "$CURRENT_BRANCH" == "$CHECKOUT_BRANCH" ]
then
  echo "Checkout branch ($CHECKOUT_BRANCH) could not be the current branch ($CURRENT_BRANCH)"
  echo "use 'rcb ANOTHER_BRANCH_TO_CHECKOUT' to rebase current branch"
  exit 2
fi

git checkout "$CHECKOUT_BRANCH"
if [ "$?" -ne "0" ]
then
  echo "Failed to checkout branch $CHECKOUT_BRANCH"
  exit 2
fi
git pull origin "$CHECKOUT_BRANCH"
if [ "$?" -ne "0" ]
then
  echo "Failed to pull branch $CHECKOUT_BRANCH"
  exit 3
fi
git checkout "$CURRENT_BRANCH"
if [ "$?" -ne "0" ]
then
  echo "Failed to checkout branch $CURRENT_BRANCH"
  exit 2
fi
git rebase -i "$CHECKOUT_BRANCH"