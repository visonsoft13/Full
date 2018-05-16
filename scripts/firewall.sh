clear
tput setaf 2 ; tput bold ; echo "------------------------------------" ; tput sgr0
echo ""
tput setaf 2 ; tput bold ; echo "   Execute por sua conta e risco" ; tput sgr0
echo ""
tput setaf 2 ; tput bold ; echo "------------------------------------" ; tput sgr0
echo ""
echo "Digite 1 para bloquear  o Torrent";
echo "ou";
echo "Digite 2 para liberar o Torrent";
echo "ou";
echo "Digite 3 ou Crtl C para Cancelar";
sleep 2s
read protecao
if [[ "$protecao" = '1' ]]; then
        firewall2
fi
if [[ "$protecao" = '2' ]]; then
        torrent
fi
if [[ "$protecao" = '3' ]]; then
        exit
fi
sleep 1s
clear
tput setaf 2 ; tput bold ; echo "------------------------" ; tput sgr0
echo ""
tput setaf 2 ; tput bold ; echo "        Pronto" ; tput sgr0
echo ""
tput setaf 2 ; tput bold ; echo "------------------------" ; tput sgr0
echo ""
