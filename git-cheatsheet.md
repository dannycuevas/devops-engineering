# GIT

### What is GIT?
-Git is a Version Control System, Free and Open Source

-What is a Version Control System?
It is a Software that helps track and manage changes to a set of files over time

-Version Control Systems offer:
Allow users to revisit earlier versions of files
Comparing changes made between different versions of the files
Undoing changes to the files
Sharing changes with other people
Or combine the changes
Git does this and more


# GIT CHEAT SHEET

-Check if GIT is already installed
git --version

> git config --global user.name "Daniel Cuevas"
> git config --global user.email "xxx@xxx.com"

-Check "if" the Git username has been configured
git config user.name
git config user.email

-Editing and configuring the user and user email in a simple way
git config --global --edit

𝗴𝗶𝘁 𝗶𝗻𝗶𝘁 : This is the very first command you'll need to use when starting a new project. It initializes a new Git repository in your current working directory. Or it can reinitialize an existing repo.

-GIT is going to monitor everything that happens in the main working directory including anything nested further down, like "child" or "grandchild" directories and so on.
-Before running GIT INIT, use GIT STATUS toverify that you are not already currently inside of a repo, because it might cause issues at some point. You can possibly fix these issues with deleting extra ".git" folders, just fyi.

𝗴𝗶𝘁 𝗰𝗹𝗼𝗻𝗲 <𝗿𝗲𝗽𝗼> : To work on an existing project, you'll want to clone (copy) it to your local machine. This command does that.


## MAKE CHANGES

𝗴𝗶𝘁 𝘀𝘁𝗮𝘁𝘂𝘀 : Before making or after making changes, it's good practice to check the status of your files. This command will show you any changes that are currently unstaged, along with the status of your git repo and its contents.

𝗴𝗶𝘁 𝗮𝗱𝗱 <𝗳𝗶𝗹𝗲𝗻𝗮𝗺𝗲> : After you've made some changes to your files, you'll want to stage them for a commit. This command adds a specific file to the stage.

𝗴𝗶𝘁 𝗮𝗱𝗱 . 𝗼𝗿 𝗴𝗶𝘁 𝗮𝗱𝗱 -𝗔 : Instead of adding files one by one, you can add all your changed files to the stage with one command.

https://git-scm.com/docs/git-add

-NOTE:
-When ADDING, we can add changes to a group of files 1st and then commit those specific changes, and then make changes to a 2nd batch of different files and then commit the 2nd batch of files, these can help us "separate" changes made to different groups of files with different "commits".

𝗴𝗶𝘁 𝗰𝗼𝗺𝗺𝗶𝘁 -𝗺 "𝗖𝗼𝗺𝗺𝗶𝘁 𝗺𝗲𝘀𝘀𝗮𝗴𝗲" : Now that your changes are staged, you can commit them with a descriptive message.


## UNDO CHANGES
-LINKS:
https://git-scm.com/docs/git-restore
https://git-scm.com/docs/git-reset

-When you have made changes to files in your repo, and you decide not to ADD or commit these changes, and you actually want to "restore" the file to its original state in the LAST commit, and you restore manually file by file

git restore FILE-NAME
git restore variables.tf

-If you have accidentally ADDED a file to your "Staging Area" with git add, and you actually do not wish to include that file in the next commit, you can remote that file from staging
git restore --staged FILE-NAME

-To undo your commits, you can use git reset to reset the repo back to a specific commit, also the commits will be gone as well

git reset COMMIT-HASH
git reset --hard COMMIT-HASH


## BRANCHING
-LINKS:
https://git-scm.com/docs/git-branch
https://git-scm.com/docs/git-switch

𝗴𝗶𝘁 𝗯𝗿𝗮𝗻𝗰𝗵 : This command will list all the current local branches in your current repository.

𝗴𝗶𝘁 𝗯𝗿𝗮𝗻𝗰𝗵 <𝗯𝗿𝗮𝗻𝗰𝗵𝗻𝗮𝗺𝗲> : This command creates a new branch. Should not include spaces.

-This will create the new branch "based off of the HEAD" where we currently were, so it "points" to that same exact spot.
-Example last most recent commit
"commit 87efbe07466c60192d855e4a3151e9528f29253c (HEAD -> master, superheroes, SongsList)"

𝗴𝗶𝘁 𝗰𝗵𝗲𝗰𝗸𝗼𝘂𝘁 <𝗯𝗿𝗮𝗻𝗰𝗵𝗻𝗮𝗺𝗲> : If you want to switch to a different branch, old version for some contexts.
https://git-scm.com/docs/git-checkout

-Always commit your changes before switching branches, or you will run into some conflicts.

git switch branch-name : Current and New command to switch to a different branch.
https://git-scm.com/docs/git-switch

git switch - : Return to the last branch

git switch -c branch-name : Create and switch to the newly created branch in a single command.

git branch -d branch-name
git branch --delete branch-name :
Deletes a branch by their name.

git branch -D : Shortcut for --delete --force, in other words, deleting a branch no matter its status.

git branch -v : Display all your branches with their Last commit only, in the form of a list, along with their commit message

### Branch Rename
-First change/switch to the branch that we want to rename

git branch -m new-name
git branch --move new-name

git branch -M new-name : shortcut for --move --force

### Merging Branches
https://git-scm.com/docs/git-merge
-We "merge" the "branches", we do not merge specific "commits"
-We always merge the current HEAD branch

-First switch into the branch you want to merge branches into (the receiveing branch)
-Use "git merge" to merge a "target" branch into the current branch

𝗴𝗶𝘁 𝗺𝗲𝗿𝗴𝗲 <𝗯𝗿𝗮𝗻𝗰𝗵𝗻𝗮𝗺𝗲> : Once you've finished making changes in a branch, you'll want to bring those changes into your main branch (usually master). This command does that.


## REMOTE REPOSITORIES

𝗴𝗶𝘁 𝗽𝘂𝘀𝗵 𝗼𝗿𝗶𝗴𝗶𝗻 <𝗯𝗿𝗮𝗻𝗰𝗵𝗻𝗮𝗺𝗲> : This command sends your commits to the remote repository.

𝗴𝗶𝘁 𝗽𝘂𝗹𝗹 : If other people are also working on your project, you'll want to keep your local repo up-to-date with their changes. This command fetches and merges any changes from the remote repository.

-Use Rebase to Pull from a newly connected remote repo into the local repo
git pull --rebase
git pull

𝗴𝗶𝘁 𝗿𝗲𝗺𝗼𝘁𝗲 -𝘃 : To check which remote servers are connected with your local repository.

### Remote Repo Status
-If you want to check if the remote repository is ahead of your local repository, you can use the following Git command:

git fetch
git status -uno

-The git fetch command fetches the latest changes from the remote repository without merging them into your working branch.
-The -uno option with git status displays the status without showing changes that are not staged.
-After running these commands, you'll be able to see if the remote repository is ahead of your local repository and if there are changes you need to pull.

# 𝗞𝗲𝘆 𝗗𝗶𝗳𝗳𝗲𝗿𝗲𝗻𝗰𝗲𝘀

𝗴𝗶𝘁 𝗳𝗲𝘁𝗰𝗵 𝘃𝘀 𝗴𝗶𝘁 𝗽𝘂𝗹𝗹: Both download data from a remote repository. However, git fetch just downloads it without integrating it, while git pull also merges it into your local files.

𝗴𝗶𝘁 𝗺𝗲𝗿𝗴𝗲 𝘃𝘀 𝗴𝗶𝘁 𝗿𝗲𝗯𝗮𝘀𝗲: Both incorporate changes from one branch to another. git merge combines the source and target branches via a new commit, whereas git rebase moves or combines commits to a new base, making a cleaner history.

𝗴𝗶𝘁 𝗿𝗲𝘀𝗲𝘁 𝘃𝘀 𝗴𝗶𝘁 𝗿𝗲𝘃𝗲𝗿𝘁: Both are used to undo changes. git reset discards local changes completely, while git revert undoes public changes by creating a new reversing commit, thereby preserving history.

