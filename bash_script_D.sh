#!/bin/bash

for i in 110-cdn 100-frontend 80-backend 71-Route53 70-web-alb 60-acm 52-vpn 50-app-lb 40-Rds 30-bastion 21-sg-rules 20-sg 10-vpc; do cd $i  && terraform destroy --auto-approve && echo "$i, has been deleted" && cd ..; done
