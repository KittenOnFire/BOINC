#!/bin/sh
# Fichier d'installation/Configuration de BOINC
echo "Script d'auto-installation de BOINC sur votre ordinateur."
sudo apt-get update && apt-get upgrade && echo "Update et upgrade du système effectuées" # Update et upgrade de l'OS

sudo apt-get install boinc-client && echo "BOINC installé" # Installation du client BOINC

echo "Joindre un compte pour BOINC"
echo "Quel est votre mot de passe pour le client BOINC sur cet ordinateur ?"
read pass_client
sudo $pass_client > /var/lib/boinc-client/gui_rpc_auth.cfg && echo "Password GUI inscrit dans le fichier gui_prc_auth.cfg" # Inscrire le password GUI dans le fichier idoine
echo "Quelle est l'adresse du manager ? (exemple : https://am.statseb.fr/ ou https://bam.boincstats.com/"
read manager
echo "Quelle l'adresse mail utilisée avec ce manager ?"
read mail
echo "Quel est votre mot de passe sur ce manager ?"
read pass_manager
sudo boinccmd --host localhost --passwd $pass_client --join_acct_mgr $manager $mail $pass_manager && echo "Vous avez maintenant rejoint le manager $manager"

sudo boinccmd --set_run_mode always && echo "BOINC tourne en permanence" # Utiliser BOINC en permanence

sudo boinccmd --set_network_mode always && echo "BOINC est toujours connecté à Internet" # Toujours être relié au réseau

echo "Adresse ip de l'ordinateur hôte (ayant accès à celui-ci). Exemple : 192.168.1.10"
read ip_master
$ip_master > /etc/boinc-client/remote_hosts.cfg && echo "IP de l'ordinateur hôte inscrite dans le fichier remote_hosts.cfg" # Inscrire l'IP de l'ordi hôte

sudo /etc/init.d/boinc-client restart && echo "Client BOINC redémarré. Bon crunch !"
