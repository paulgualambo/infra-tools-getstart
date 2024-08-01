#se ejecuta con el perfil del programador
USERNAME="paul"
EMAIL=paul.gualambo@gmail.com
FULLNAME='paul romualdo gualambo giraldo'

#git Global
git config --global user.email $EMAIL
git config --global user.name $FULLNAME

#configure SSH
yes "" | ssh-keygen -t ed25519 -C "$EMAIL"

#Add .bashrc
echo -e '\n' >> ~/.bashrc
echo 'eval "$(ssh-agent -s)"' >> ~/.bashrc
echo 'ssh-add ~/.ssh/id_ed25519' >> ~/.bashrc
echo -e '\n' >> ~/.bashrc


#creacion de carpeta
mkdir -p ~/workspace

#brindando permisos a la carpeta backup
sudo chown $USERNAME:$USERNAME /backup
sudo cp -R /backup/* /home/$USERNAME/workspace/
sudo mkdir -p /home/$USERNAME/workspace/projects /home/$USERNAME/workspace/data
sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/workspace/
#habilitar crontab -e
# copiar al final  "* * * * * /home/paul/config_vm/backup.sh" ejecución a cada minuto
