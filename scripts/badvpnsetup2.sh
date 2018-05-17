#!/bin/bash

if [ $(id -u) -eq 0 ]
then
	clear
else
	if echo $(id) |grep sudo > /dev/null
	then
	clear
	echo "Voce não é root"
	echo "Seu usuario esta no grupo sudo"
	echo -e "Para virar root execute \033[1;31msudo su\033[0m"
	exit
	else
	clear
	echo -e "Vc nao esta como usuario root, nem com seus direitos (sudo)\nPara virar root execute \033[1;31msu\033[0m e digite sua senha root"
	exit
	fi
fi
udpvar=$(netstat -nlpt | egrep -o udpgw)
if [ -d /etc/VpsPackdir ]
then
echo ""
else
mkdir /etc/VpsPackdir
fi

if [ -d /etc/VpsPackdir/senha ]
then
echo ""
else
mkdir /etc/VpsPackdir/senha
fi

if [ -d /etc/VpsPackdir/limite ]
then
echo ""
else
mkdir /etc/VpsPackdir/limite
fi

clear
echo -e "\033[36;37mMENU BADVPN\033[0m"
echo -e "\033[0;35m------------------------------------------------------------\033[0m"
echo -e "\033[1;36m[\033[1;31m1\033[1;36m] INSTALAR BADVPN \033[1;30m(No Description)\033[1;36m
[\033[1;31m2\033[1;36m] INICIAR BADVPN \033[1;30m(No Description)\033[1;36m
[\033[1;31m3\033[1;36m] PARAR BADVPN \033[1;30m(No Description)\033[1;36m
[\033[1;31m0\033[1;36m] VOLTAR \033[1;30m(No Description)\033[0m"
echo -e "\033[0;35m------------------------------------------------------------\033[0m"
echo -e "\033[1;36mQUAL E A SUA OPÇAO?\033[0m"
read -p ": " opcao

case $opcao in
 1)
if [ "$udpvar" = "" ]
 then
  echo -e "\033[1;36mO \033[1;31mBADVPN...\033[0m será instalado, que e nada mais que um programa que libera portas UDP no servidor e assim permitindo serviço VOIP como ligação no WhatsApp, Skype, etc. 
\033[1;31mAGUARDE...\033[0m"
sleep 5s
echo -e "\033[1;36mInstalando, aguarde....\033[0m"
cd /root/
wget https://www.dropbox.com/s/zur95ox2pkymbkj/badvpn-udpgw?dl=0 && mv /root/badvpn-udpgw /bin/badvpn-udpgw
chmod 777 /bin/*
echo "#!/bin/bash
if [ "'$1'" == start ]
then
badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 10 > /dev/null &
echo 'BaDVpN rodando na porta 7300'
fi
if [ "'$1'" == stop ]
then
badvpnpid="'$(ps x |grep badvpn |grep -v grep |awk '"{'"'print $1'"'})
kill -9 "'"$badvpnpid" >/dev/null 2>/dev/null
kill $badvpnpid > /dev/null 2> /dev/null
kill "$badvpnpid" > /dev/null 2>/dev/null''
kill $(ps x |grep badvpn |grep -v grep |awk '"{'"'print $1'"'})
killall badvpn-udpgw
fi" > /bin/badvpn
chmod 777 /bin/badvpn
sleep 3s
echo -e "\033[1;31m           Instalador Badvpn\n\033[0m"
echo -e "Istalando do Badvpn"
chmod 777 /bin/badvpn-udpgw
echo -e "\033[1;32m             Instalação completa\033[0m" 
echo -e "\033[1;37mComandos:\n\033[1;31mbadvpn start\033[1;37m para iniciar o badvpn"
echo -e "\033[1;31mbadvpn stop \033[1;37m para parar o badvpn\033[0m"
sleep 5s
echo -e "\033[1;36mTUDO PRONTO\033[0m"
sleep 5s
  vpnbad
  exit
else
echo -e "\033[1;36mBADUDP JA ESTA INSTALADO...\033[0m"
sleep 4s
 vpnbad
exit
fi;;
 2)
if [ "$udpvar" = "" ]
 then
  echo -e "\033[1;36mIniciando...\033[0m"
sleep 2
badvpn start
echo -e "\033[1;36mBadVPN iniciado...\033[0m"
sleep 5s
clear
  vpnbad
  exit
else
echo -e "\033[1;36mBadVPN Ja Esta Rodando na Porta 7300\033[0m"
sleep 3s
vpnbad
exit
fi;;
 3)
if [ "$udpvar" = "" ]
then
echo -e "\033[1;36mBadVPN Ja Esta Parado!\033[0m"
sleep 3s
vpnbad
exit
 else
  echo -e "\033[1;36mParando serviço...\033[0m"
sleep 2
badvpn stop
echo -e "\033[1;36mBadVPN parado...\033[0m"
sleep 5s
  vpnbad
  exit
fi;;
 0)
  adm
  sleep 1s
  exit;;
 *)
  id > /dev/null 2> /dev/null
esac
