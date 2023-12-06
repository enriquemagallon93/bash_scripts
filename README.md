# Bash Scripts

Useful bash scripts for repetitive git commands

**🧪 Note:** This scripts were created for practicing my bash scripts skills and are not unit tested or regularly maintained, so please use them carefully. Feel free to fork the repository if needed.


## Installation

```bash
cd ~/ # This uses your user root folder, but change it to the one you prefer
git clone REPO_URL
echo 'export PATH="~/bash_scripts:$PATH"' >> ~/.zshrc # In this case I am using .zsh, use the corresponding file
# for the terminal you are using. I.E. ~/.bash_profile for bash terminal.
# Replace '~/' with the path to where you cloned the repo
```

Finally reload your terminal

## How to use them

Once you installed them, you are able to use the following scripts in any repo where you are using git

### cbf (Create branch For)

It is a shortcut to create a new branch based on your Repository's main branch (main, master or any branch that is set as the main one).

Syntax: `cbf name-of-your-new-branch base-branch`, where base-branch is optional and it is set to your main branch by default

```bash
cbf sam-123-showcasing-bash-scripts # This checkout your main branch, update it from origin and then
# creates a new branch based on it with the name you provided
cbf sam-123-showcasing-bash-scripts staging # Same as above but uses the staging branch instead of your main one
```

**Internal steps it performs:**

 - `git checkout $BASE_BRANCH`
 - `git pull origin $BASE_BRANCH`
 - `git checkout -b $name-of-your-new-branch`

### crb (Create Remote Branch)

Shortcut for `git push -u origin "${CURRENT_BRANCH}"`

```bash
crb sam-123-showcasing-bash-scripts
```

### dcb (Delete Current Branch)

Useful for removing a temporal local branch. It removes the current branch and checkout the specified branch.

Syntax: `dcb name-of-local-branch-to-remove base-branch`, where base-branch is optional and it is set to your main branch by default (main, master or any branch that is set as the main one).

```bash
dcb sam-123-showcasing-bash-scripts # This checkout your main branch and then delete the sam-123-showcasing-bash-scripts local branch
dcb sam-123-showcasing-bash-scripts staging # Same as above but checks out the staging branch instead of your main one
```

**Internal steps it performs:**

 - `git checkout $BASE_BRANCH`
 - `git branch -d $name-of-local-branch-to-remove`

### mcb (Merge Current Branch)

It checks out a base branch, update it from origin and then merge it into the local branch you were when running the script.

Syntax: `mcb base-branch`, where base-branch is optional and it is set to your main branch by default (main, master or any branch that is set as the main one).

```bash
mcb sam-123-showcasing-bash-scripts # This checkout your main branch, update it from origin, then checks out your initial local branch and finally merge the main branch into it
mcb sam-123-showcasing-bash-scripts staging # Same as above but checks out and merges staging instead of the main one
```

**Internal steps it performs:**

 - `git checkout $BASE_BRANCH`
 - `git pull origin $BASE_BRANCH`
 - `git checkout $initial-branch`
 - `git merge $BASE_BRANCH`

### rcb (Rebase Current Branch)

It checks out a base branch, update it from origin and then rebase it into the local branch you were when running the script. It uses the rebase interactive mode, so at the end you are requested to edit or keep the new commits.

Syntax: `rcb base-branch`, where base-branch is optional and it is set to your main branch by default (main, master or any branch that is set as the main one).

```bash
rcb sam-123-showcasing-bash-scripts # This checkout your main branch, update it from origin, then checks out your initial local branch and finally rebase the main branch into it
rcb sam-123-showcasing-bash-scripts staging # Same as above but checks out and rebase staging instead of the main one
```

**Internal steps it performs:**

 - `git checkout $BASE_BRANCH`
 - `git pull origin $BASE_BRANCH`
 - `git checkout $initial-branch`
 - `git rebase -i $BASE_BRANCH`

### pcb (Push Current Branch)

It pushes your branch to the remote branch it relates. It no remote branch relates, it creates a remote branch with the same name and it is set as the tracking remote branch for local one.

Syntax: `pcb Remote`, where Remote is optional and it is set to `origin` by default.

```bash
pcb # If remote branch exists, it runs `git push`
# If does not exist, it runs `git push -u origin $current-branch-name`
pcb other-origin # Same as above, but uses `other-origin` as the remote instead of using `origin`
```