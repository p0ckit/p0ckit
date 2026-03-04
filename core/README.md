# p0ckit
p0ckit is a Bash-based framework that helps you manage and runs modules/scripts.
It comes with some modules/scripts but you are free to add/modify as you want
(be carefull right now it doesn't have the function to restore them)
# Downloading
To downloading the framework you will need git installed for both Linux/Windows
You can download it from [here](https://git-scm.com/install)
If you already downloaded the repo [go here](#using-the-framework)
## Linux
To download the framework in linux just run the commands below
```bash
git clone https://github.com/tgrd0813/p0ckit.git
cd p0ckit
```
## Windows
```bash
git clone https://github.com/tgrd0813/p0ckit.git
cd p0ckit
```
ps: or you can download the .zip file from [here](https://github.com/tgrd0813/p0ckit/archive/refs/heads/main.zip)
then [go here](#windows)

# Using the framework
## linux
To use the framework you just need to run:
```bash
bash p0ckit.sh
```
OR
```bash
chmod +x p0ckit.sh
./p0ckit.sh
```

## Windows/Docker
To run the framework in Windows you need to have [Docker](https://www.docker.com/products/docker-desktop/) installed.
After you install it you can either use the GUI or the commands below
(they are the same if you want to run the docker image in linux)

## Build the image

```bash
docker build -t p0ckit .
```
## Run the image
```bash
docker run -i -t p0ckit
```

Note:
- The image is based on Debian and includes `bash`, `git`, `python3`, `nmap`, `npm`, `curl`, and `jq`.

# Updating
## linux
run the command below in the framework
```bash
update
```
OR manualy
```bash
git pull origin main
```
## Windows
if you use git bash is the same as in linux
if you use docker you will need to run the update.py file
Notes:
- you won't be able to use the update/fix commands in docker since it's not persistent
- the .py file ask if you want it to rebuild the docker container

ps: the update.py file is ai generated

# Modules
Right now there is only one it's scanners/ntscan (even tho in the index file are more, those are just for tests) which just runs nmap with the ip given.
I plan to add more in the future.
