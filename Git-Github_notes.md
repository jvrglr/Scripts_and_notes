### Git notes

## Basic concepts
* **repository**: A *folder*, usually hidden and called ".git" that git uses to track for changes in the project. 

## Basic commands
* **git init**:  Creates the repository in the folder where git init was executed. This should be the first command.
* **git add filename**: Adds changes in filename to be stored. 
> git add . : add all changes.

> git add *.extension : add all changes in the files with extension named "extension".
* **git commit -m "message"**: Commit (like really save) added changes to memmory. "Message" should be filled with the information of the changes so that it is easy to keep track of what every commit stores.
* **git log**: Gives you the list of all commits with identifier, associated message and commit time and date.
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

## License
* Use MIT (or CC BY 4.0 if it's more data/scripts than software).
* Add citation statement to readme:

This project is shared for **academic and research purposes**. It is free to use, redistribute, modify, and share for research purposes, provided that proper credit is given to the authors through citation of:

Aguilar, Javier, Miguel A. Muñoz, and Sandro Azaele.  
*The Limits of Inference in Complex Systems: When Stochastic Models Become Indistinguishable.*  
arXiv preprint arXiv:2509.24977 (2025).
