#!/bin/bash

#Actualizaion de repositorios
#Variables (comandos que se repetiran a lo largo del script)
update="sudo apt-get update"
upgrade="sudo apt-get upgrade -y"
fullCommandUpdate="$update; $upgrade"
patron="plugins="

#instalar herramientas
sudo apt-get install -y git tilix neofetch htop flatpak gnupg curl wget gpg


#Agregando repositorios
#sudo add-apt-repository ppa:flatpak/stable
#sudo apt update
#sudo apt-get install -y flatpak

sudo apt-get install -y gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#homebrew
#echo "instalando homebrew"
#sudo curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh


#volver a cargar la terminal
bash
sudo flatpak remote-add --if-not-exists elementary https://flatpak.elementary.io/repo.flatpakrepo

sudo flatpak remote-modify elementary --prio 2



#Instalar postgres
sudo apt install -y postgresql


#Agregar repositorios de mongodb
#comandos oficiales de la pagina de mongodb para ubuntu 22.04 jammy Jellyfish

curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor
   
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list   

#cambiar a variable
#sudo apt-get update
$update

#instalacion de mongo
sudo apt-get install -y mongodb-org


#instalar VsCode repo oficial

sudo apt-get install -y wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

sudo apt install -y apt-transport-https
sudo apt update
sudo apt install -y code 

#install sublime text 4
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null

echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

#instalar docker
#remover paquetes no oficiales en repositorios apt (recomendacion en la documentacion de instalacion de docker)
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done


#instalar docker para ubuntu
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

#Instala oh my bash pero no configura ningun plugin
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

#instalar zsh
$update 
sudo apt install -y zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"




git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

bash
#La variable esta declarada a esta altura porque al principio de la ejecucion este archivo todavia no existe
archivo="~/.zshrc"

# Reemplazar la línea que contiene el patrón
sed -i "/$patron/c plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions)" "$archivo"

source ~/.zshrc

#extensiones y herramientas
#Ulauncher
sudo add-apt-repository universe -y 
sudo add-apt-repository ppa:agornostal/ulauncher -y 
sudo apt update 
sudo apt install -y ulauncher

#cambiar la termial
echo $'||||||||| \n \n \e[31;1mEscoger la terminal por defecto (Recomendado tilix)\e[0m \n \n |||||||||| \n ';
sudo update-alternatives --config x-terminal-emulator

#Configurando shell por defecto a zsh
chsh -s /bin/zsh


#Configuracion del escritorio
sudo apt install -y gnome-tweaks                                      

#Descargar los temas Sweet
curl -Lfs https://www.gnome-look.org/p/1253385/loadFiles | jq -r '.files | first.version as $v | .[] | select(.version == $v).url' | perl -pe 's/\%(\w\w)/chr hex $1/ge' | xargs wget



#Actviar la extencion user-themes
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
#Extraer los temas de Sweet
cat *.tar.xz | sudo tar -xvJf - -i -C /usr/share/themes 

#Establecer el tema
gsettings set org.gnome.shell.extensions.user-theme name "Sweet-Ambar-Blue-Dark-v40"
gsettings set org.gnome.desktop.interface gtk-theme "Sweet-Ambar-Blue-V40"
gsettings set org.gnome.desktop.wm.preferences theme "Sweet-Ambar-Blue-V40"

#fondo de pantalla
curl --output waves.png https://images8.alphacoders.com/134/1346083.png

# Estableciendo los iconos
cat *.tar.xz | sudo tar -xvJf - -i -C /usr/share/icons
gsettings set org.gnome.desktop.interface icon-theme "Sweet-Purple-Filled"






# link de iconos
curl -Lfs https://www.gnome-look.org/p/1284047/loadFiles | jq -r '.files | first.version as $v | .[] | select(.version == $v).url' | perl -pe 's/\%(\w\w)/chr hex $1/ge' | xargs wget

