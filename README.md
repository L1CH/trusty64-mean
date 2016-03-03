Vagrant Box For Mean.js Project
=================
This is an all-in-one vagrant box for developing mean.js projects.


## Read me first
Always Run Vagrant as **!!! Administrator !!!**
```
e.g. open CMD as Administrator, then type any vagrant commands
```

## Prerequisite
Git >= 1.9.x  
Vagrant >= 1.7.4  
VirtualBox >= 5.0.10

## How to start
1.  Download the vagrant box files from [Release Page](https://github.com/L1CH/trusty64-mean/releases) and Unzip it (**Recommend**)  
    **OR**  
    Use git to obtain these files (**NOT Recommend**)  
    ```
    git clone https://github.com/QiyuLi/trusty64-mean.git
    cd trusty64-mean
    rm -rf .git
    ```

2.  You can change the nodejs version in folder **.provision/vagrant.sh**  
    For example, install latest 4.x version:  
    ```
    VAGRANT_NODE_VERSION=v4
    ```

3.  Run the following command (in the folder where Vagrantfile locates) to bring up and restart vagrant  
    ```
    vagrant up
    vagrant reload
    ```

4.  Connect to vagrant guest machine, when vagrant finish its job  
    ```
    vagrant ssh
    ```

## Setup in vagrant
1.  **The shell script below required to be run once if *！you are using Windows！* AND :**  
    a. you create/init mean.js project into *Vagrant Synced Folders* (**/vagrant** folder on guest machine)  
    **OR**  
    b. you cloned any mean project into *Vagrant Synced Folders* (**/vagrant** folder on guest machine)  
    <br/>

    *You must run the following shell in the project folder (where you run npm install):*  
    ```
    ln -s ~/.alt_node_modules node_modules
    ```

    **For example:** (inside guest machine)  
    ```
    git clone https://github.com/meanjs/mean.git
    cd mean
    ln -s ~/.alt_node_modules node_modules
    npm install
    grunt test
    ```

## Recommend Operations (Optional)

1.  Install Vagrant Plugins:
    a. Automatically Update VirtualBox Guest Addiction:  
    ```
    vagrant plugin install vagrant-vbguest
    ```

##  Licensing
The source code is licensed under GPL v3. License is available [here](/LICENSE).
