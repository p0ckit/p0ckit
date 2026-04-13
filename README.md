# p0ckit
p0ckit is a Bash-based framework that helps you manage and runs modules/scripts.
It comes with some modules/scripts but you are free to add/modify as you want
(be careful right now it doesn't have the function to restore them)
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
OR 
You can download the .zip file from [here](https://github.com/tgrd0813/p0ckit/archive/refs/heads/main.zip)
then [go here](#windows)

ps: you will not have .git folder. that means that you will not be able to update the tool using the script or tool commands
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
> Note if you are serious about cybersecurity/hacking or actively learning on windows  
> You should really reconsider the life choices you made  
> But I still added some workarounds for you too, not my pleasure but you're welcome  

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

# Actually using the script
Now that p0ckit is installed you will need to start it using the commands from [before](#using-the-framework).  
After that you can type "help" or "help a/-a" to see the help menu or advanced help menu.  
Or it you want to jump right in just do "use module-name" to start a module, e.g.  
```bash
fw()# use ntscan
fw(core/ntscan)#
```
You now loaded the wanted module.  
In there you can type "show options/info" to see either one of them.
```bash
fw(core/ntscan)# show info
#str_info
#   this is a script that just runnes nmap -sV with the given ip and port
#end_info
fw(core/ntscan)# show options
#str_op
#   rhost   (required)
#   port    (optional)
#end_op
fw(core/ntscan)#
```
You can set the options you want by using set key value e.g.  
```bash
fw(core/ntscan)# set rhost 192.168.1.1
Set: rhost => 192.168.1.1
fw(core/ntscan)# set port 1234
Set: port => 1234
fw(core/ntscan)#
```
Now that you set the options it's time to run it  
```bash
fw(core/ntscan)# run
Starting Nmap 7.98 ( https://nmap.org ) at 2026-04-04 22:02 +0300
Nmap scan report for 192.168.1.1
Host is up (0.0012s latency).

PORT     STATE  SERVICE VERSION
1234/tcp closed hotline

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 0.80 seconds
fw(core/ntscan)#
```
You now used a module, go try the other ones.  

# Updating
## linux
run the command below in the framework
```bash
update
```
OR manually
```bash
git pull origin main
```
## Windows
if you use git bash is the same as in linux
if you use docker you will need to run the update.bat file

Notes:
- you shouldn't use the update/fix commands in docker since it's not persistent
- the .bat file will ask if you want it to rebuild the docker container  
ps: the update.bat file is ai generated

# Modules
## Core
### ntscan
Is a bash wrapper for nmap.  
It takes the ip/host (optionally port) and runs "nmap ip -sV"  

### wifi_attack
This is a more complicated wrapper for aircrack-ng suite.  
It chains the attacks like recon hand-capture and cracking in one module.  
You must specify the interface and the attack type for any attack accompanied by it's specific arguments.  

### web_fuzzer
As the name says it's a python made web fuzzer.  
It can scan multiple url's and url endpoints.  
It can do single as well, you can filter the status codes, specify the amount of workers and much more.  

### sub_enum
It's a subdomain enumeration tool made in python.  
Same as the [web_fuzzer](#web_fuzzer) can scan single or multiple url/subdomains.  
You can filter through the output, specify the amount of workers and a little bit more.  
(TLDR; same as the web_fuzzer but for subdomains)

## In work
For now there are no modules in work check the project to do list

## Creating modules
You can create your own modules in whatever language you want it only needs three things to work perfectly:  
-options  
```
#str_op
#    option 1
#   option 2
#   etc
#end_op
```
-description
```
#str_info
#   line 1
#   line 2
#   etc
#end_info
```
-script/variables
```
#t first
```
do this for languages/scripts that require to be run first and to give the variables after.  
```
#t last
```
do this for languages/scripts that require the variables to be set first and then to run the script.  

# Important Notes
> Even tho I made some workarounds for windows please just don't use windows at least use a VM.  
> VMware workstation pro is free now you have no reasons not to use linux.  

# Credits
for the cracking part of the wifi_attack module I use the [crackstation.net](https://crackstation.net) human-only wordlist.  
as a small nice easter egg I added naas ([no-as-a-service](https://github.com/hotheadhacker/no-as-a-service)) for fun.  

