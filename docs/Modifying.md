# Modifying
All components of the installation (software, configuration, ...) are stored and pulled from version control (Git).
This allows install to be more reproducible, however it also means that modification have to be made in Git.

If you have access to the original repositories, you can directly modify the files and the last version will be pulled on the next playbook run.

However if that is not the case you will have to fork the repository you want to edit and change the associated url in this playbook : 
- To fork log into your github account (or other git provider, ex : gitlab, etc...) then go to the repo you want to clone and click the fork button (top right) > create a new fork
- Write down the url of your fork and replace it in the [repos.yml](/repos.yml) file
- Re-run the playbook, your modifications should have been applied
