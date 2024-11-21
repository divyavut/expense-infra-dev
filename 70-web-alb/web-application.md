#### Web application
1. Use https protocol to secure the domain access from user
2. For security --> apply certificate on domain

#### Domain Checking Companies 
1. ACM provides certificate for the given domain, before providing domain, they will check the authorisation of your domain, and then they creates a records, we have to update those records in hosted zone. 

#### Steps for creating secure domain
1. Domain name(Input) --> ACM(certificate provider) --> records(acm creates records for validation)---> update the records in hosted zone (route53) --> vaidation completed --->  creates secure domain(https:*.dev.divyavutakanti.com)
