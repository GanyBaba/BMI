#!/bin/sh -x
# Install Apache
sudo apt-get -y update
sudo apt-get -y install apache2
sudo sh -c "echo '<html><h1>This is Amazon Customize Machine </h1></html>' > /var/www/html/index.html"