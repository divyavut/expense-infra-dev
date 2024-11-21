#### Bastion 
1. Bastion host is used to connect hosts in private subnets
2. Login to Bastion  and from bastion, we can connect to hosts(private Ip) in private subnet.
3. Its very difficult task to connect hosts in private subnet using vpn, always we want to first connect bastion and then hosts in private subnet. we can use vpn instaed to bastion to connect to hosts in private subnet, so that we can directly connect to hosts in provite subnet using open vpn connect client.
4. IF we connect from bastion host to private host in private subnet, we dont get Userinterface for browsing any Ip.