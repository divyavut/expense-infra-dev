### VPN(Forward proxy)
1. create Vpn SG
2. Create Vpn SG rules(443,943,1194,22)
3. create key pair for vpn (ssh-keygen -f filename)
4. create vpn with openvpn ami
5. openvpnas is a username of openvpn server
6. connect to openvpn server using (ssh -i path/Of/PrivateKey openvpnas@PublicIp/Of/openvpn server)
7. login to Admin UI using openvpn(username) and Admin@1234(password) that we have setted it up.
8. Do VPN setting in Admin UI (Cilent traffic, Dns setting)
9. Download open vpn connect client to connect to openvpn server
10. Give cilent UI path and username, password of openvpn server  and then connect.
11. Now our laptob existence changes to vpc public subnet
12. What ever we browser from our laptob with our router public ip maps to openvpn(in public subnet of aws) public ip. all traffic now flows from (our laptob public Ip)---> Vpn public ip ---> private Ip(loadbalancer).