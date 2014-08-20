#!/bin/bash

ACTION=$1

function clean()
	{
	vagrant destroy -f
	rm -rf boxes/ output-virtualbox-iso/
	}

function buildbox()
	{
	packer build template/centos65.json
	}

function startbox()
	{
	vagrant box add -f boxes/virtualbox/centos65-tomcat.box --name vlad/tomcat
	vagrant up
	vagrant ssh
	}

case $ACTION in
start)
	buildbox
	startbox
;;
rebuild)
	clean
	buildbox
	startbox
;;
stop)
	clean
;;
*)
  echo $"Usage: $0 {start|rebuild|stop}"
  exit 2
;;
esac

