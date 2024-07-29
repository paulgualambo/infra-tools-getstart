#se ejecuta con el perfil del programador
USERNAME="paul"
#creacion de carpeta
mkdir -p ~/workspace

#brindando permisos a la carpeta backup
sudo chown $USERNAME:$USERNAME /backup
sudo cp -R /backup/* /home/$USERNAME/workspace/
sudo mkdir -p /home/$USERNAME/workspace/projects /home/$USERNAME/workspace/data
sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/workspace/
#habilitar crontab -e
# copiar al final  "* * * * * /home/paul/config_vm/backup.sh" ejecución a cada minuto