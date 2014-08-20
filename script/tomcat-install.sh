#!/bin/bash -x

#install vbox prerequisities
sudo yum -y install kernel-headers kernel-devel gcc make perl curl wget
#install vbox guest additions
sudo mount -o loop /home/vagrant/VBoxGuestAdditions.iso /mnt
sudo sh /mnt/VBoxLinuxAdditions.run --nox11

#install sun java
sudo mkdir /usr/java
cd /usr/java
sudo wget --no-cookies --no-check-certificate --header "Cookie: s_cc=true; s_nr=1402489533342;gpw_e24=http%3A%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjava-archive-downloads-javase6-419409.html; s_sq=%5B%5BB%5D%5D; oraclelicense=accept-securebackup-cookie" -O jdk-6u45-linux-x64.bin http://download.oracle.com/otn-pub/java/jdk/6u45-b06/jdk-6u45-linux-x64.bin
sudo chmod 755 jdk-6u45-linux-x64.bin
sudo ./jdk-6u45-linux-x64.bin

echo "export JAVA_HOME=/usr/java/jdk1.6.0_45" >> $HOME/.bashrc
echo "export PATH=$JAVA_HOME/bin:$PATH" >> $HOME/.bashrc
source $HOME/.bashrc
echo $JAVA_HOME
java -version

#instll tomcat6
sudo yum -y --exclude=java install tomcat6 tomcat6-webapps tomcat6-admin-webapps
sudo chkconfig --level 3 tomcat6 on

VAGRANT_USER=vagrant
VAGRANT_HOME=/home/$VAGRANT_USER
VAGRANT_KEY_URL=https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub

#install vagrant keys
mkdir -pm 700 $VAGRANT_HOME/.ssh
wget --no-check-certificate "${VAGRANT_KEY_URL}" -O $VAGRANT_HOME/.ssh/authorized_keys
chmod 0600 $VAGRANT_HOME/.ssh/authorized_keys
chown -R $VAGRANT_USER:$VAGRANT_USER $VAGRANT_HOME/.ssh

#cleanup
sudo yum -y remove kernel-headers kernel-devel gcc make perl
rm -rf /home/vagrant/VBoxGuestAdditions.iso
sudo rm -rf /usr/java/jdk-6u45-linux-x64.bin
sudo yum -y clean all

sudo rm -rf /tmp/*
sudo dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -f /EMPTY
