#!/bin/sh
# Fichier d'installation/Configuration de BOINC
echo "Script d'auto-installation de BOINC sur votre ordinateur."
sudo apt-get update && apt-get upgrade && echo "==> Update et upgrade du système effectuées" # Update et upgrade de l'OS

sudo apt-get install boinc-client && echo "BOINC installé" # Installation du client BOINC

echo "Joindre un compte pour BOINC"
echo "Quel est votre mot de passe pour le client BOINC sur cet ordinateur ?"
read pass_client
sudo echo $pass_client > /var/lib/boinc-client/gui_rpc_auth.cfg && echo "==> Password GUI inscrit dans le fichier gui_prc_auth.cfg" # Inscrire le password GUI dans le fichier idoine
echo "Quelle est l'adresse du manager ? (exemple : http://am.statseb.fr/ ou http://bam.boincstats.com/"
read manager
echo "Quelle est l'adresse mail utilisée avec ce manager ?"
read mail
echo "Quel est votre mot de passe sur ce manager ?"
read pass_manager
sudo boinccmd --host localhost --passwd $pass_client --join_acct_mgr $manager $mail $pass_manager && echo "==> Vous avez maintenant rejoint le manager $manager"

sudo /etc/init.d/boinc-client restart

sudo boinccmd --set_run_mode always && echo "==> BOINC tourne maintenant en permanence" # Utiliser BOINC en permanence

sudo boinccmd --set_network_mode always && echo "==> BOINC à maintenant toujours accès à Internet" # Toujours être relié au réseau

echo "Adresse ip de l'ordinateur hôte (ayant accès à celui-ci). Exemple : 192.168.1.10"
read ip_master
sudo echo $ip_master > /etc/boinc-client/remote_hosts.cfg && echo "==> IP de l'ordinateur hôte inscrite dans le fichier remote_hosts.cfg" # Inscrire l'IP de l'ordi hôte

echo "==> Donnez un nom à cette machine"
read nom
sudo echo $nom > /etc/hostname
sudo echo 127.0.0.1 localhost > /etc/hosts
sudo echo 127.0.1.1 $nom >> /etc/hosts
echo "==> Votre ordinateur s'appelle maintenant $nom"

sudo /etc/init.d/boinc-client restart && echo "==> Client BOINC redémarré. Bon crunch !"

sudo reboot
