#!/bin/bash

for i in 10-vpc 20-sg 21-sg-rules 30-bastion 40-Rds 50-app-lb 52-vpn 60-acm 70-web-alb 71-Route53 80-backend 100-frontend; do cd $i && terraform apply --auto-approve && echo "$i, has been created" && cd ..; done