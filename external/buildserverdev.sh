#!/bin/bash
  
# ----------------------------------------------------------------------------
# Instructions to create new server for the examples site
# ----------------------------------------------------------------------------
# 1) Create linux based server
# 2) Copy this script to the linux machine
# 3) Make sure the variables at the top of the script are correct
# 4) Run the script "sudo bash buildserverdev.sh"
# 5) When the script it run it will create an SSHKEY that will need to be added
#    to the git repository in order to access it later in the script. After
#    adding the sshkey then press enter to let the script continue.
# ----------------------------------------------------------------------------
  
# Specific settings
DEBUG=false
PRODUCTIONDB="http://digideek.com/apdf/production.sqlite3"
PRODUCTIONATTACHMENTS="http://digideek.com/apdf/production.files.gz"
DEVDIR="/opt/examples"
USERNAME="Derek Andelin"
USEREMAIL="derek.andelin@activepdf.com"
  
# Get SSH Key to add to git repository
sudo -u activepdf ssh-keygen -t rsa -b 2048 -f $HOME/.ssh/id_rsa
sudo -u activepdf ssh-keygen -y
#sudo -u activepdf mkdir -p $HOME/.ssh
#sudo -u activepdf echo 'ssh-rsa...' > $HOME/.ssh/id_rsa
#sudo -u activepdf chmod 600 $HOME/.ssh/id_rsa; chmod 600 $HOME/.ssh/id_rsa.pub
read -p "Copy ssh-rsa key to git service and then press [Enter] key to continue..."
echo ''
  
# Install Packages
apt-get update
apt-get upgrade -y
apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties
apt-get install -y libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
apt-get install -y ruby1.9.3 ruby-dev
git config --global user.name $USERNAME
git config --global user.email $USEREMAIL
git config --global push.default simple
if [ "$DEBUG" = true ]
then
read -p "Press [Enter] key to continue..."
echo ''
fi
  
# Install Nginx
gpg --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
gpg --armor --export 561F9B9CAC40B2F7 | apt-key add -
apt-get install -y apt-transport-https
echo 'deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main' >> /etc/apt/sources.list.d/passenger.list
chown root /etc/apt/sources.list.d/passenger.list
chmod 666 /etc/apt/sources.list.d/passenger.list
apt-get update
apt-get install -y nginx-full passenger
service nginx start
# Open up the server's IP address in your browser to make sure that nginx is up and running.
service nginx restart
if [ "$DEBUG" = true ]
then
read -p "Press [Enter] key to continue..."
echo ''
fi
  
# Create directory for site deployment
mkdir $DEVDIR
chown activepdf $DEVDIR
cd $DEVDIR
  
# Get the git repository
ssh-keyscan activepdf.unfuddle.com | sudo -u activepdf cat > $HOME/.ssh/known_hosts
chown activepdf:activepdf $HOME/.ssh/known_hosts
sudo -u activepdf git clone git@activepdf.unfuddle.com:activepdf/ex.git $DEVDIR
if [ "$DEBUG" = true ]
then
read -p "Press [Enter] key to continue..."
echo ''
fi
  
# Create additional directories
sudo -u activepdf mkdir $DEVDIR/releases
sudo -u activepdf mkdir $DEVDIR/shared
sudo -u activepdf mkdir $DEVDIR/shared/log
sudo -u activepdf mkdir $DEVDIR/public/system
if [ "$DEBUG" = true ]
then
read -p "Press [Enter] key to continue..."
echo ''
fi
  
# Install bundler
gem install bundler --no-rdoc --no-ri
  
# Setup the new repository
sudo -u activepdf bundle
sudo -u activepdf rake db:migrate
if [ "$DEBUG" = true ]
then
read -p "Press [Enter] key to continue..."
echo ''
fi
  
# nginx setup for examples site
echo $'
server {
  listen 3000 default_server;
  listen [::]:3000 default_server ipv6only=on;
    
  server_name examples.activepdf.com;
  passenger_enabled on;
  rails_env    development;
  root         /opt/examples/public;
    
  # redirect server error pages to the static page /50x.html
  error_page   500 502 503 504  /50x.html;
  location = /50x.html {
      root   html;
  }
}
' > /etc/nginx/sites-enabled/default
perl -p -i -e 's/# passenger_root/passenger_root/' /etc/nginx/nginx.conf
perl -p -i -e 's/# passenger_ruby/passenger_ruby/' /etc/nginx/nginx.conf
service nginx restart
if [ "$DEBUG" = true ]
then
read -p "Press [Enter] key to continue..."
echo ''
fi
  
# Download production DB
curl -o $DEVDIR/db/development.sqlite3 $PRODUCTIONDB
chown activepdf $DEVDIR/db/development.sqlite3
  
# Download production attachments
curl -o $DEVDIR/public/system/production.files.gz $PRODUCTIONATTACHMENTS
tar -zxvf $DEVDIR/public/system/production.files.gz -C $DEVDIR/public/system/
rm $DEVDIR/public/system/production.files.gz
if [ "$DEBUG" = true ]
then
read -p "Press [Enter] key to continue..."
echo ''
fi
  
# Open the folder in Sublime Text
sudo -u activepdf subl $DEVDIR
  
# Spit out the local URL so that it can be opened and bookmarked
echo ''
echo 'http://127.0.0.1:3000/?admin_tag=43egwf97hewao73fesag3a3w4tyew4AOga'
echo ''
  
exit 0
