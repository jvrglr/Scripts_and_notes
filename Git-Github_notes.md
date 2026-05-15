### Git notes

## Basic concepts
* **repository**: The whole project (=folder where the project is)
* **branches**: Different "states of the memory" is like different history lines of the project.

## Basic commands
* **git init**:  Creates the repository in the folder where git init was executed. Basically it creates a hidden repository (.git) where all data of changes is stored. This should be the first command. 
* **git add filename**: Adds changes in filename to be stored. Git stage means the same thing (it seems that stage was added after "add" as it is more intuitively representing what the command does).
> git add . : add all changes.

> git add *.extension : add all changes in the files with extension named "extension".
* **git commit -m "message"**: Commit (like really save) added changes to memmory. "Message" should be filled with the information of the changes so that it is easy to keep track of what every commit stores.
* **git log**: Gives you the list of all commits with identifier, associated message, in which branch it is located and commit time and date.
* **git branch**: List branches
* **git checkout -b branchname**:  Creates a new branch called branchname and switches to it. It always try to create it; but don't overwrite: if a branch with that name already exists it will throw an error.
>  **git checkout branchname**: Switch branch to "branchname". 

> **git checkout filename**:It discards the unstaged changes in filename, restoring it to the state of the last commit. Checkout discards unstaged (not added) local changes.

> **git checkout commit_hash**: Go back to commit hash with detached head (you are not in a branch an could lose further changes)

>  **git checkout -b branch_name commit_hash** :Creates a new branch called branch_name from commit_hash. SEEMS SAFER WAY TO GO BACK TO A COMMIT.


* git merge Branch_name **Merges the specified branch into the currently active branch**
* git branch -d Branch_name **Delete branch**
* git reset --hard HEAD~1 **Undo last commit**

## Working with remote
* Just created a local repository with git init. Also a remote repository in github where I added a readme file. Run this to associate both repositories and get readmefile in local.
```
git remote add origin https://github.com/yourusername/your-repo-name.git
git branch -M main
git pull origin main --allow-unrelated-histories # This will require to provide github credentials (password through token, not log in passwrd).
```

* https://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes
    
* git push origin branch_name   **Pushes local repository to remote branch_name**
    
* git remote show origin    **See remote associated with local repository**

* git remote add origin remote_repository_URL   **Set new remote**

* git remote -v     **Verifies the new remote URL**

* git clone https://github.com/YOUR-USERNAME/YOUR-REPOSITORY New_Name   **Clone from remote on new folder New_name**

* git pull origin Branch_name   **Fetch+merge local from remote**

## Information
* git branch -a **"Hidden" branches**

## Merging: **Using VI to add commit message**  
https://stackoverflow.com/questions/19085807/please-enter-a-commit-message-to-explain-why-this-merge-is-necessary-especially  
    press "i"
    write your merge message
    press "esc"
    write ":wq"
    then press enter

## License
* Use MIT (or CC BY 4.0 if it's more data/scripts than software).
* Add citation statement to readme:

This project is shared for **academic and research purposes**. It is free to use, redistribute, modify, and share for research purposes, provided that proper credit is given to the authors through citation of: add_ref
