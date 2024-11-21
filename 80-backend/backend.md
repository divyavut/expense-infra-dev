#### application Infra changes frequently when new version launches
 1. Create the Backend Ec2
 2. connect to backend from terraform using provisioners  and Configure the backend using ansible pull based mechanism. variables in terraform --> shell script --> ansible
 3. stop Ec2 
 4. Take AMI from stopped instance
 5. Delete the Ec2 instance
 7. Create Target groups ---> where we set up health configuration of targets
 6. Create Launch template using AMI
 7. Create Auto scaling group using Launch template and place it in Target groups
 8. create auto scaling policy based on CPU utilization 
 

#### Ansible Pull based mechanism
1.  In a pull-based mechanism, the managed nodes(backend) themselves pull configurations from a central location (usually a Git repository or similar) and apply those configurations locally


#### Null Resource
1.  It will not create any resources but usefull for provisioners. null resource is used to connect ec2 insatnce though provisioners.
    1. Triggers -> When new instance is created
    2. connection to ec2(remote)
    3. File provisioner( copy file from local  to remomte(ec2) )
    4. provisioner(remote-exec) --> execute commands on Remote server(ec2) from copied file
    5. provisioner will only run when instance is creating but not when instance is updating.
    6. taint --> forcing to rerun the  particular resource.
       - terraform taint null_resource.backend


####  Important to note
- Here we have remember one point, we are connecting to backend server which have private ip from local machine. this i only possible when our local laoptob connects to vpn then the local laptob existence changes to  aws cloud  and IP location is virginia, it gets the vpn ip.

#### Passing Environment variables
1. terraform ---> shell --> ansible

#### Commands
1. terraform taint null_resource.backend
2. ansible-pull -i localhost, -U giturl filename.yaml -e environmentvariables1 -e environmentvariables2

####  apply and destroy the infra using shell script
1. for i in 10-vpc 20-sg 21-sg-rules 30-bastion 40-Rds 50-app-lb 51-Route53 52-vpn; do cd $i && terraform apply --auto-approve && cd ..; done
2. for i in  52-vpn 51-Route53 50-app-lb 40-Rds 30-bastion 21-sg-rules 20-sg 10-vpc; do cd $i && terraform destroy --auto-approve && cd ..; done

#### Rolling Update
1. create one new instance using new version, once this is up, delete the one old instance
2. min health of the instance should be 50 per while performing rolling strategy
3. Zero down time approach