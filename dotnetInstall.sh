#!/bin/bash

ProgramsToInstall=("git"
"docker.io"
"docker-doc"
"docker-compose" 
"docker-compose-v2" 
"podman-docker" 
"containerd" 
"runc"
"dotnet8"

)

if [ $(whoami) == "root" ]; then 
    sudo apt update && sudo apt upgrade -y 

    mkdir $HOME/programs

    wget https://dl.pstmn.io/download/latest/linux_64 && 
    tar xvf postman-linux-x64.tar.gz
    mv Postman $HOME/programs
    rm -rf postman-linux-x64.tar.gz
    
    wget https://github.com/VSCodium/vscodium/releases/download/1.88.1.24104/codium_1.88.1.24104_amd64.deb
    sudo dpkg -i codium_1.88.1.24104_amd64.deb
    rm -rf codium_1.88.1.24104_amd64.deb

    for program in "${ProgramsToInstall[@]}"; do 
        sudo apt install $program -y

    done 

    systemctl enable docker
    # Fuck off the credentials
    docker run -e "ACCEPT_EULA=1" -e "MSSQL_USER=SA" -e "MSSQL_SA_PASSWORD=SQLConnect1" -e "MSSQL_PID=Developer" -p 1433:1433 -d --name=sql_connect mcr.microsoft.com/azure-sql-edge
    clear 

    echo "[+] Docker with sqlserver created"
    echo "[+] Dotnet8 Installed"
    echo "[+] Postman is at $HOME/programs/Postman"
    exit 0

else 
    echo "[-] Please execute this script like root."
    exit 1

fi 
