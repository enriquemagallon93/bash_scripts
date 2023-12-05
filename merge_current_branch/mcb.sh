#!/bin/bash
CHECKOUT_BRANCH="$1"
BRANCH_INDICATOR="On branch "
CMD_OPTIONS=""

# Get all of the text that follows the first '--' in the command
OPTIONS="no"
for arg in "$@"; do
  if ([ "$OPTIONS" == "yes" ]); then
    CMD_OPTIONS="$CMD_OPTIONS $arg"
  fi
  if [ "$arg" == "--" ]; then
    OPTIONS="yes"
  fi
done

if [ "$CHECKOUT_BRANCH" == "" ]; then
  CHECKOUT_BRANCH="$(git branch -rl '*/HEAD' | rev | cut -d/ -f1 | rev)"
fi

CURRENT_BRANCH="$(git branch --show-current)"

if [ "$?" -ne "0" ]; then
  echo "current directory is not a repository or git is not installed"
  exit 1
fi

if [ "$CURRENT_BRANCH" == "$CHECKOUT_BRANCH" ]; then
  echo "Checkout branch ($CHECKOUT_BRANCH) could not be the current branch ($CURRENT_BRANCH)"
  echo "use 'rcb ANOTHER_BRANCH_TO_CHECKOUT' to rebase current branch"
  exit 2
fi

git checkout "$CHECKOUT_BRANCH"
if [ "$?" -ne "0" ]; then
  echo "Failed to checkout branch $CHECKOUT_BRANCH"
  exit 2
fi
git pull origin "$CHECKOUT_BRANCH"
if [ "$?" -ne "0" ]; then
  echo "Failed to pull branch $CHECKOUT_BRANCH. Returning to $CURRENT_BRANCH"
  git checkout "$CURRENT_BRANCH"
  exit 3
fi
git checkout "$CURRENT_BRANCH"
if [ "$?" -ne "0" ]; then
  echo "Failed to checkout branch $CURRENT_BRANCH"
  exit 2
fi
git merge $CHECKOUT_BRANCH$CMD_OPTIONS
