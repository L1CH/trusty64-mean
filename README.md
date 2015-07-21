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
Run the following in CMD
```
git clone https://github.com/L1CH/trusty64-mean.git
cd trusty64-mean
vagrant up
```
When vagrant finish its job, connect to VM
```
vagrant ssh
```

## Setup in vagrant

1.  **The shell script below required to be run once when:**  
    a. first time you run vagrant up  
    OR  
    b. you update current vagrant box

    ```
    yes n | bower install
    ```

2.  **The shell script below required to be run once when:**  
    a. you create/init mean.io project  
    OR  
    b. you cloned any mean project  
    <br/>

    *You must run the following shell in the project folder (where you run npm install):*
    ```
    ln -s ~/.alt_node_modules node_modules
    ```

##  Licensing
The source code is licensed under GPL v3. License is available [here](/LICENSE).