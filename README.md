## Overview 

A script that, when launched from a cloned git repository directory, will set certain tags and push them back to the origin. For demonstration purposes. 



#### Prerequisites

* bash shell on a linux node
* git client package installed
* existing git repository with local or remote origin configured



#### Step-by-step guide

1. Download the script.sh to yours git repository on the filesystem

   ```bash
   $ wget https://raw.githubusercontent.com/ciforbg/s7T3nnA6/master/script.sh -O /path/to/local/gitrepo/script.sh
   ```

   

2. Navigate to the repository directory and make the script executable

   ```bash
   $ cd /path/to/local/gitrepo
   $ chmod u+x ./script.sh
   ```

   

3. Execute the script either with or without arguments(single argument is only allowed). It will determine  set of tags based on branch, time and the presence of an additional passed argument. Then it will push the tags to the origin only if a remote is configured and the source repo is not empty.

   ```bash
   $ ./script.sh 
   $ ./script.sh v1.0.1
   ```

   