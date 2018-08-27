# cryptobear
Basic shell script that encrypts/ decrypts batch files 
AES 256 CBC encryption

## Requirements:

Mac OS  
Openssl installed on your machine  
zip installed  
Knowledge with command line  

## Instructions

1.) Make folder and put `cryptobear.sh` in it.  
2.) CD into that folder and create two more folders. ie `mkdir encrypt` `mkdir decrypt`.  
3.) Open cryptobear.sh in a text editor or file editing tool. ie `vim cryptobear.sh`  
4.) Run `chmod +x cryptobear.sh` to make sure shell is executable  

### Populate variables
5.) `hash="your password"` choose a secure password and put it in.  
6.) `basedir=` put in the path to the folder you've created. ie `pwd`  
7.) `encrypted_file_dir=` provide path to the folder you are using to decrypt files.  
8.) `decrypted_file_dir=` provide path to the folder you are using to encrypt files.  

### Run script
9.) Copy files you want to encrypt/decrypt into the respective folders  
10.) Run script by typing `./cryptobear.sh`  
