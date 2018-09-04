# CrossCompilerSync.sh running:

### - Move script to ~/raspi folder

### - Edit Raspberry pi source list
`sudo nano /etc/apt/sources.list`

uncomment line: deb-src


### - If you want you can generate SSH key and copy it to Raspberry so you don't have to write passwords more than once:
`ssh-keygen`

`ssh-copy-id username@ipaddress`

### - Set execute permissions for the script and run it:
`chmod +x CrossCompilerSync.sh`

`./CrossCompilerSync.sh`
