#!/bin/bash

sudo apt -y update 
sleep 15 
sudo apt -y update 
sudo apt -y install apache2 
sudo systemctl start apache2 
sudo chmod 666 /etc/apache2/ports.conf 
sudo chmod 666 /etc/apache2/sites-available/000-default.conf 
sudo sed -i 's/80/8080/g' /etc/apache2/ports.conf 
sudo sed -i 's/80/8080/g' /etc/apache2/sites-available/000-default.conf 
sudo systemctl restart apache2 
sudo chown -R ${var.cloo_vm_admin_username}:${var.cloo_vm_admin_username} /var/www/html 

cat << EOM > /var/www/html/index.html
<!DOCTYPE html>
<html>
<body>
<h1>Hanwha Solution Terraform PoC</h1>
<p>VM Success!!</p>
</body>
</html>
EOM
