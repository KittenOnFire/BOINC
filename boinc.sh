#!/bin/sh
# Fichier d'installation/Configuration de BOINC
echo "Script d'auto-installation de BOINC sur votre ordinateur."
sudo apt-get update && echo "Update du système effectuée" # Update et upgrade de l'OS

sudo apt-get install boinc-client && echo "BOINC installé" # Installation du client BOINC

echo "Joindre un compte pour BOINC"
echo -e "\t\e[1;33;40m Quel est votre mot de passe pour le client BOINC sur cet ordinateur ? \e[0m 1;33m"
read pass_client
sudo echo $pass_client > /var/lib/boinc-client/gui_rpc_auth.cfg && echo -e "Password GUI inscrit dans le fichier gui_rpc_auth.cfg" # Inscrire le password GUI dans le fichier idoine
echo -e "\t\e[1;33;40m Quelle est l'adresse du manager ? (exemple : http://am.statseb.fr/ ou http://bam.boincstats.com/) \e[0m 1;33m"
read manager
echo -e "\t\e[1;33;40m Quelle est l'adresse mail utilisée avec ce manager ? \e[0m 1;33m"
read mail
echo -e "\t\e[1;33;40m Quel est votre mot de passe sur ce manager ? \e[0m 1;33m"
read pass_manager
cd /var/lib/boinc-client
sudo boinccmd --join_acct_mgr $manager $mail $pass_manager && echo "Vous avez maintenant rejoint le manager $manager"

sudo /etc/init.d/boinc-client restart

sudo boinccmd --set_run_mode always && echo "BOINC tourne maintenant en permanence" # Utiliser BOINC en permanence

sudo boinccmd --set_network_mode always && echo -e "BOINC a maintenant toujours accès à Internet" # Toujours être relié au réseau

echo -e "\t\e[1;33;40m Adresse ip locale de l'ordinateur hôte (ayant accès à celui-ci). Exemple : 192.168.1.10 \e[0m 1;33m"
read ip_master
sudo echo $ip_master > /etc/boinc-client/remote_hosts.cfg && echo "IP de l'ordinateur hôte inscrite dans le fichier remote_hosts.cfg" # Inscrire l'IP de l'ordi hôte

echo -e "\t\e[1;33;40m  Donnez un nom à cette machine \e[0m 1;33m"
read nom
sudo echo $nom > /etc/hostname
sudo echo 127.0.0.1 localhost > /etc/hosts
sudo echo 127.0.1.1 $nom >> /etc/hosts
echo "Votre ordinateur s'appelle maintenant $nom"

sudo /etc/init.d/boinc-client restart && echo " Client BOINC redémarré. Bon crunch !"
