#!/bin/bash

# update
#yum -y update

# install etckeeper from epel
rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum -y install etckeeper

etckeeper init
etckeeper commit -m "initial commit."

# install mysql 5.5.x from remi
rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
yum -y install mysql mysql-devel mysql-server mysql-utilities --enablerepo=remi

sed -i -e "1a character-set-server = utf8" /etc/my.cnf
sed -i -e "1i default-character-set = utf8" /etc/my.cnf
sed -i -e "1i [client]" /etc/my.cnf

service mysqld start
mysql -e "GRANT ALL PRIVILEGES ON *.* TO dbuser@'localhost' IDENTIFIED BY 'password' WITH GRANT OPTION; FLUSH PRIVILEGES;"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO dbuser@'%' IDENTIFIED BY 'password' WITH GRANT OPTION; FLUSH PRIVILEGES;"

# install mongodb
cat << EOT > /etc/yum.repos.d/mongodb.repo
[mongodb]
name=MongoDB Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/
gpgcheck=0
enabled=1
EOT
yum -y install mongodb-org

# install rabbitmq 
rpm -Uvh http://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm
yum install -y https://www.rabbitmq.com/releases/rabbitmq-server/v3.4.1/rabbitmq-server-3.4.1-1.noarch.rpm
echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config
rabbitmq-plugins enable rabbitmq_management

# install common tools
yum -y install vim-enhanced

# setup chkconfig
chkconfig iptables off
chkconfig ip6tables off
chkconfig mysqld on
chkconfig mongod on
chkconfig rabbitmq-server on

# disable SELINUX. require restart OS
sed -i -e "s/SELINUX\=permissive/SELINUX\=disabled/" /etc/selinux/config

# vagrant reload...
