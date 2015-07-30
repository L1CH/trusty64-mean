Vagrant Box For Mean.io/Mean.js Project
=================
This is an all-in-one vagrant box for developing mean.io/mean.js projects.


## Read me first
Always Run Vagrant as Administrator
```
e.g. open CMD as Administrator, then type any vagrant commands
```

## Prerequisite
Git >= 1.9.x  
Vagrant >= 1.7.3  
VirtualBox >= 4.3.28 (**DO NOT USE 5.x**)

## How to start
1.  Download the vagrant box files from [Release Page](https://github.com/L1CH/trusty64-mean/releases) and Unzip it (**Recommend**)  
    **OR**  
    Use git to obtain these files (**NOT Recommend**)  
    ```
    git clone https://github.com/L1CH/trusty64-mean.git
    cd trusty64-mean
    rm -rf .git
    ```

2.  Run the following command to bring up vagrant
    ```
    vagrant up
    ```
3.  Connect to vagrant guest machine, when vagrant finish its job
    ```
    vagrant ssh
    ```

## Setup in vagrant

1.  **The shell script below required to be run once if:**  
    a. you run vagrant up first time  
    **OR**  
    b. you update current vagrant box

    ```
    yes n | bower install
    ```

2.  **The shell script below required to be run once if *！you are using Windows！* AND :**  
    a. you create/init mean.io project into *Vagrant Synced Folders*  
    **OR**  
    b. you cloned any mean project into *Vagrant Synced Folders*  
    <br/>

    *You must run the following shell in the project folder (where you run npm install):*
    ```
    ln -s ~/.alt_node_modules node_modules
    ```

##  Licensing
The source code is licensed under GPL v3. License is available [here](/LICENSE).
