AlmaLinux_PieterDC
name: pdeconinck
WW: Pieter

met nmtui ip op 10.14.123.123 gezet
default gateway op 10.14.0.1
dns op 10.14.0.1



https://docs.docker.com/engine/install/rhel/#install-using-the-repository


sudo yum install -y yum-utils
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/rhel/docker-ce.repo

Repo wou niet worken dus aangepast in
sudo vi /etc/yum.repos.d/docker-ce.repo 

start typen met i en dan esc shift zz to save (vi)

[docker-ce-stable]
name=Docker CE Stable - $basearch
baseurl=https://download.docker.com/linux/centos/$releasever/$basearch/stable
enabled=1
gpgcheck=1
gpgkey=https://download.docker.com/linux/centos/gpg


sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl start docker


Website container
met docker .net 
database container
mariadb
https://learn.microsoft.com/en-us/dotnet/core/docker/build-container?tabs=windows

Containerize a .net app with docker