#!/bin/bash

# ----------------------------------------------------------------------------
# Instructions to create new server for the examples site
# ----------------------------------------------------------------------------
# 1) Create linux based server
# 2) Make sure the variables at the top of the script are correct
# 3) ssh into the server as root "ssh root@ipaddress"
# 4) make sure the buildserver.sh file is in the location of the url in step 5
# 5) Run the following command:
#    bash <(curl -s http://digideek.com/apdf/buildserver.sh)
# 6) After script is finished deploy the web site to the new machine
# 7) Copy attachment files folder from old machine to new machine (from host):
#    scp -3 -r examples@10.1.10.40:/opt/examples/shared/system/files/ deploy@107.170.153.226:/opt/examples/shared/system/


# Specific settings
AdminSSHKEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDZUC/mJah1Ud5a/yrMUDqUfBSSUl8U+RC8pcT06M0eKFyNCZhbdTALYonT6XAzzkwYLdOj/EI9Gua2A60xwYPnjIpysLJssMYvY+Iys/arhWvzd9lkIY/JqA+KsXgy2Z1PN3BaJ3QRYdP73TwHRnnLLhoKHOymaOXJJDiAWaSRjbqjBehAubXAEkOBQDIT+b5gezAyntw5B1io/LHyiCObU9XKzCtDR5ZU5HCYUHCu10pRMEkhotl8ZVTnJCT8Eau3vgRBOi/abebYDIsYWpBisFwkcO3D/OosSXpMhq4H42HvfxpJT4jiCzBOzDrqsZk6BbNU5D6GXsCNMg1T07sb"
ProductionDB="http://digideek.com/apdf/production.sqlite3"
BackupDBURL="http://digideek.com/apdf/backupdb.php"
BackupFilesURL="http://digideek.com/apdf/backupfiles.php"

# Add Deploy User
sudo adduser deploy
sudo adduser deploy sudo
sudo -u deploy mkdir -p /home/deploy/.ssh
sudo -u deploy echo $AdminSSHKEY >> /home/deploy/.ssh/authorized_keys

# Install Ruby
apt-get update
apt-get upgrade -y
apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties
apt-get install -y libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
apt-get install -y ruby

# Install Nginx
gpg --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
gpg --armor --export 561F9B9CAC40B2F7 | apt-key add -
apt-get install -y apt-transport-https
echo 'deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main' >> /etc/apt/sources.list.d/passenger.list
chown root /etc/apt/sources.list.d/passenger.list
chmod 600 /etc/apt/sources.list.d/passenger.list
apt-get update
apt-get install -y nginx-full passenger
service nginx start
# Open up the server's IP address in your browser to make sure that nginx is up and running.
service nginx restart

# Create directory for site deployment
mkdir /opt/examples
chown deploy /opt/examples
sudo -u deploy mkdir /opt/examples/releases
sudo -u deploy mkdir /opt/examples/shared
sudo -u deploy mkdir /opt/examples/shared/log

# Install bundler
gem install bundler --no-rdoc --no-ri

# nginx setup for examples site
echo $'
server {
  listen 80 default_server;
  listen [::]:80 default_server ipv6only=on;
  
  server_name examples.activepdf.com;
  passenger_enabled on;
  rails_env    production;
  root         /opt/examples/current/public;
  
  # redirect server error pages to the static page /50x.html
  error_page   500 502 503 504  /50x.html;
  location = /50x.html {
      root   html;
  }
}
server {
  listen              443 ssl;
  server_name examples.activepdf.com;
  passenger_enabled on;
  rails_env    production;
  root         /opt/examples/current/public;
  
  # redirect server error pages to the static page /50x.html
  error_page   500 502 503 504  /50x.html;
  location = /50x.html {
      root   html;
  }
  ssl_certificate     examples.activepdf.com.crt;
  ssl_certificate_key examples.activepdf.com.key;
  ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
  ssl_ciphers         HIGH:!aNULL:!MD5;
}
' > /etc/nginx/sites-enabled/default
echo $'-----BEGIN CERTIFICATE-----
MIIEsDCCA5igAwIBAgIDBoHEMA0GCSqGSIb3DQEBCwUAMEcxCzAJBgNVBAYTAlVT
MRYwFAYDVQQKEw1HZW9UcnVzdCBJbmMuMSAwHgYDVQQDExdSYXBpZFNTTCBTSEEy
NTYgQ0EgLSBHMzAeFw0xNTA4MjQwODI3NTdaFw0xNjA5MjUwMzUyMTJaMIGTMRMw
EQYDVQQLEwpHVDc2MjgyODExMTEwLwYDVQQLEyhTZWUgd3d3LnJhcGlkc3NsLmNv
bS9yZXNvdXJjZXMvY3BzIChjKTEzMS8wLQYDVQQLEyZEb21haW4gQ29udHJvbCBW
YWxpZGF0ZWQgLSBSYXBpZFNTTChSKTEYMBYGA1UEAwwPKi5hY3RpdmVwZGYuY29t
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA650Q787pvrlVXHqnXIN9
8lYwhBYP6W84/X5QP3gzxauRdfN/WftCbnaQhyV4tKfUdmbjkAhtFYjyQSSJOIUm
L45z5iAbiTt3W7ecrrTrheikbP24JTk4licdRc/NnRz3CKu5urHn+L2Y6l2qdJi5
EwExixSZxK4707H+DJKM1035KBpltc0xfzwUQmlfXBUoDdISFUAJaxPJm0+hEhLs
o2TPxs4LIuSPzxqxestXjWPRvHgVlPNNuo61ulWuC0NpBrqbO3puxB8pU4LF36IX
uzWokPV23FOL2SfxWfiOaLNYw3vCtACB36ImOvfpo7sN0ce+mrFPAVgisuoyj/Md
WwIDAQABo4IBVjCCAVIwHwYDVR0jBBgwFoAUw5zz/NNGCDS7zkZ/oHxb8+IIy1kw
VwYIKwYBBQUHAQEESzBJMB8GCCsGAQUFBzABhhNodHRwOi8vZ3Yuc3ltY2QuY29t
MCYGCCsGAQUFBzAChhpodHRwOi8vZ3Yuc3ltY2IuY29tL2d2LmNydDAOBgNVHQ8B
Af8EBAMCBaAwHQYDVR0lBBYwFAYIKwYBBQUHAwEGCCsGAQUFBwMCMCkGA1UdEQQi
MCCCDyouYWN0aXZlcGRmLmNvbYINYWN0aXZlcGRmLmNvbTArBgNVHR8EJDAiMCCg
HqAchhpodHRwOi8vZ3Yuc3ltY2IuY29tL2d2LmNybDAMBgNVHRMBAf8EAjAAMEEG
A1UdIAQ6MDgwNgYGZ4EMAQIBMCwwKgYIKwYBBQUHAgEWHmh0dHBzOi8vd3d3LnJh
cGlkc3NsLmNvbS9sZWdhbDANBgkqhkiG9w0BAQsFAAOCAQEAK5bLpduQhud5Kywy
IbvC2IgGS/k/bgk0exYM6hHJp26iCPRp/xQcL/onZo1oil/veaxg8cQ4c0mzwSOi
3GzTbZ2z/eDokO8VmkczQBeJBvrXf0/8qlDg2cqphcrApmRhUIzMEusuUHle5WJ2
NFdl2e/E2tR0rU9QYRNFlkm+HSthNnFD9+Y9o+fIb0JP2ZawxVq5y0OJa4rRIZiB
4Tfg454VLX90hZWcMUoG84nXxTC12t+hw1T785h78O9XpEoSMTUN8Yp+kWbYMNUC
vNeejncnaAjQ38jxCIB2sDAKsoGvVWlq/mSs3OYTItoss6fEj9lle6eSs9Ny9rqK
q1ay9A==
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIEJTCCAw2gAwIBAgIDAjp3MA0GCSqGSIb3DQEBCwUAMEIxCzAJBgNVBAYTAlVT
MRYwFAYDVQQKEw1HZW9UcnVzdCBJbmMuMRswGQYDVQQDExJHZW9UcnVzdCBHbG9i
YWwgQ0EwHhcNMTQwODI5MjEzOTMyWhcNMjIwNTIwMjEzOTMyWjBHMQswCQYDVQQG
EwJVUzEWMBQGA1UEChMNR2VvVHJ1c3QgSW5jLjEgMB4GA1UEAxMXUmFwaWRTU0wg
U0hBMjU2IENBIC0gRzMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCv
VJvZWF0eLFbG1eh/9H0WA//Qi1rkjqfdVC7UBMBdmJyNkA+8EGVf2prWRHzAn7Xp
SowLBkMEu/SW4ib2YQGRZjEiwzQ0Xz8/kS9EX9zHFLYDn4ZLDqP/oIACg8PTH2lS
1p1kD8mD5xvEcKyU58Okaiy9uJ5p2L4KjxZjWmhxgHsw3hUEv8zTvz5IBVV6s9cQ
DAP8m/0Ip4yM26eO8R5j3LMBL3+vV8M8SKeDaCGnL+enP/C1DPz1hNFTvA5yT2AM
QriYrRmIV9cE7Ie/fodOoyH5U/02mEiN1vi7SPIpyGTRzFRIU4uvt2UevykzKdkp
YEj4/5G8V1jlNS67abZZAgMBAAGjggEdMIIBGTAfBgNVHSMEGDAWgBTAephojYn7
qwVkDBF9qn1luMrMTjAdBgNVHQ4EFgQUw5zz/NNGCDS7zkZ/oHxb8+IIy1kwEgYD
VR0TAQH/BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAQYwNQYDVR0fBC4wLDAqoCig
JoYkaHR0cDovL2cuc3ltY2IuY29tL2NybHMvZ3RnbG9iYWwuY3JsMC4GCCsGAQUF
BwEBBCIwIDAeBggrBgEFBQcwAYYSaHR0cDovL2cuc3ltY2QuY29tMEwGA1UdIARF
MEMwQQYKYIZIAYb4RQEHNjAzMDEGCCsGAQUFBwIBFiVodHRwOi8vd3d3Lmdlb3Ry
dXN0LmNvbS9yZXNvdXJjZXMvY3BzMA0GCSqGSIb3DQEBCwUAA4IBAQCjWB7GQzKs
rC+TeLfqrlRARy1+eI1Q9vhmrNZPc9ZE768LzFvB9E+aj0l+YK/CJ8cW8fuTgZCp
fO9vfm5FlBaEvexJ8cQO9K8EWYOHDyw7l8NaEpt7BDV7o5UzCHuTcSJCs6nZb0+B
kvwHtnm8hEqddwnxxYny8LScVKoSew26T++TGezvfU5ho452nFnPjJSxhJf3GrkH
uLLGTxN5279PURt/aQ1RKsHWFf83UTRlUfQevjhq7A6rvz17OQV79PP7GqHQyH5O
ZI3NjGFVkP46yl0lD/gdo0p0Vk8aVUBwdSWmMy66S6VdU5oNMOGNX2Esr8zvsJmh
gP8L8mJMcCaY
-----END CERTIFICATE-----
' > /etc/nginx/examples.activepdf.com.crt
#-----END RSA PRIVATE KEY-----' > /etc/nginx/examples.activepdf.com.key

perl -p -i -e 's/# passenger_root/passenger_root/' /etc/nginx/nginx.conf
perl -p -i -e 's/# passenger_ruby/passenger_ruby/' /etc/nginx/nginx.conf
service nginx restart

# Download production DB
curl -o /opt/examples/shared/production.sqlite3 $ProductionDB
chown deploy /opt/examples/shared/production.sqlite3

# Setup daily DB backup
BackupCRON="#!/bin/bash

TEMPDB=/tmp/backup.sqlite3.gz
gzip -c /opt/examples/shared/production.sqlite3 > \$TEMPDB
curl -T \$TEMPDB \"$BackupDBURL\"
rm \$TEMPDB

TEMPFILES=/tmp/backup.files.tar.gz
tar -zcf \$TEMPFILES --directory=/opt/examples/shared/system files
curl -T \$TEMPFILES \"$BackupFilesURL\"
rm \$TEMPFILES

exit 0"
echo "$BackupCRON" > /etc/cron.daily/backup
chmod 755 /etc/cron.daily/backup

exit 0
