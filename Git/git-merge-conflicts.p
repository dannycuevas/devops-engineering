# Merge Conflicts
-Conflicts can come up when merging branches, and they have to be manually resolved
-In most cases, Git is smart enough to know how files should be modified when we are merging branches, however that is not always the case

-Git does not always know what version of the merges you want to keep, and we just end up in a merge conflict

-There are several ways to resolve those conflicts, for example,
in git guis
or simply in the code editor

-Example Conflict Message
"CONFLICT (content): merge conflict in filename1.txt
Automatica merge failed; fix conflicts and then commit the result"

### Solution
-Then we will have to go and open those files where there are conflicts, and fix them
and then we can commit changes
-The files will be "decorated", meaning some content to indicate where there are conflicts
you will see the decoration once you open the specific files with conflicts

## Resolving Conflicts Workflow
-Whenever you encounter merge conflicts, follow these steps to resolve them:

1-Open up the files with the merge conflicts

2-Edite the files manually to remove the conflicts. Decide which branch content you want to keep in each conflict manually as well, or you can also keep the content from both branches

3-Remove the "conflict markers" in the documents, and edit the document to how you want it to look as an "end product", and save the file(s), git add the files and then make the git commit

-So effectively, what we are doing, is manually editing all the necessary text, like adding or removing or modifying the text, to get rid of conflicts, and have a unified "correct" text/code

4-Add your changes and then make the regular commit

5-Now you are ready to push your changes to the remote repository
