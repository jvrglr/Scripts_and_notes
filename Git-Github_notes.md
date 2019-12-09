## Git
* git merge Branch_name **Merges the specified branch into the currently active branch**
* git -d Branch_name **Delete branch**
* git log **History of commits**

## Working with remote
* git add file_name **or** git stage file_name **They are synonyms. The command prepares the files for commit.**

* https://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes
    
* git push origin branch_name   **Pushes local repository to remote branch_name**
    
* git remote show origin    **See remote associated with local repository**

* git remote add origin remote_repository_URL   **Set new remote**

* git remote -v     **Verifies the new remote URL**

* git clone https://github.com/YOUR-USERNAME/YOUR-REPOSITORY    **Clone from remote**

* git pull origin Branch_name   **Fetch+merge local from remote**

## Information
* git branch -a **"Hidden" branches**

## Merging: **Using VI to add commit message**
    press "i"
    write your merge message
    press "esc"
    write ":wq"
    then press enter
