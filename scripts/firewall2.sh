#!/bin/bash
clear
# by Haboryn
# Creditos:
# SSHTLS
ip=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
if [[ "$ip" = "" ]]; then
	ip=$(wget -qO- ipv4.icanhazip.com)
fi
read -p "IP do servidor: " -e -i $ip ip
echo Apagando todas as regras.
sleep 1
# Apagando todas as regras
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X

echo Bloqueando tudo..
sleep 1
# Mudando a politica - Começa bloqueando tudo
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

echo Liberando conexoes pre-estabelecidas...
sleep 1
# Libera conexões pre-estabelecidas
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -t filter -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

echo Liberando HTTPS....
sleep 1
# Liberar HTTPS
iptables -A OUTPUT -p tcp -d $ip --dport 443 -m state --state NEW -j ACCEPT

echo Liberando HTTP.....
sleep 1
# Liberar HTTP
iptables -A OUTPUT -p tcp -d $ip --dport 80 -m state --state NEW -j ACCEPT

echo Liberando DNS......
sleep 1
# Liberar DNS
iptables -A OUTPUT -p tcp --dport 53 -m state --state NEW -j ACCEPT
iptables -A OUTPUT -p udp --dport 53 -m state --state NEW -j ACCEPT

echo Liberando DHCP.......
sleep 1
#Liberar DHCP
iptables -A OUTPUT -p tcp --dport 67 -m state --state NEW -j ACCEPT
iptables -A OUTPUT -p udp --dport 67 -m state --state NEW -j ACCEPT

echo Liberando SSH........
sleep 1
#Liberar SSH
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 144 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 144 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT

echo Liberando PROXY.........
sleep 1
#Liberar SQUID
iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
iptables -A INPUT -p tcp --dport 8799 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 3128 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 8080 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 3128 -j ACCEPT
iptables -A FORWARD -p tcp --dport 8080 -j ACCEPT
iptables -A FORWARD -p tcp --dport 8799 -j ACCEPT
iptables -A FORWARD -p tcp --dport 80 -j ACCEPT
iptables -A FORWARD -p tcp --dport 3128 -j ACCEPT
iptables -A OUTPUT -p tcp -d $ip --dport 5223 -m state --state NEW -j ACCEPT
iptables -A OUTPUT -p tcp -d $ip --dport 9339 -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp --dport 5223 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 5223 -j ACCEPT
iptables -A INPUT -p tcp --dport 9339 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 9339 -j ACCEPT

echo Bloqueando PING...........
sleep 1
#Bloquear PING
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
#Liberar WEBMIN
iptables -A INPUT -p tcp --dport 10000 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 10000 -j ACCEPT

#Bloqueando torrent
echo Bloqueando torrent.......
sleep 1
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 6881:6889 -j DNAT --to-dest $ip
iptables -A FORWARD -p tcp -i eth0 --dport 6881:6889 -d $ip -j REJECT
iptables -A OUTPUT -p tcp --dport 6881:6889 -j DROP
iptables -A OUTPUT -p udp --dport 6881:6889 -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP

echo Firewall configurado...
sleep 1
