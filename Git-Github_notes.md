## Git
* git merge Branch_name **Merges the specified branch into the currently active branch**
* git branch -d Branch_name **Delete branch**
* git log **History of commits**
* git reset --hard HEAD~1 **Undo last commit**

## Working with remote
* git add file_name **or** git stage file_name **They are synonyms. The command prepares the files for commit.**

* https://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes
    
* git push origin branch_name   **Pushes local repository to remote branch_name**
    
* git remote show origin    **See remote associated with local repository**

* git remote add origin remote_repository_URL   **Set new remote**

* git remote -v     **Verifies the new remote URL**

* git clone https://github.com/YOUR-USERNAME/YOUR-REPOSITORY New_Name   **Clone from remote on new folder New_name**

* git pull origin Branch_name   **Fetch+merge local from remote**
* git checkout filename **WHEN PULLING, Discard local changes for a specific file https://stackoverflow.com/questions/15745045/how-do-i-resolve-git-saying-commit-your-changes-or-stash-them-before-you-can-me/20036755**

## Information
* git branch -a **"Hidden" branches**

## Merging: **Using VI to add commit message**  
https://stackoverflow.com/questions/19085807/please-enter-a-commit-message-to-explain-why-this-merge-is-necessary-especially  
    press "i"
    write your merge message
    press "esc"
    write ":wq"
    then press enter
