# AWS knowledge
## Discussion topics
### Add elasticity to the app
To cope with a dramatic increase in users and number of requests on the web app, the infra admin may:
- create extra EC2 instances and set up a load balancer in front of them. Ideally, create an instance group out of an instance template, and let AWS manage its scaling up/down automatically based on relevant instances monitored metrics (%CPU Usage for ex)
- use DynamoDB behind EC2 instances to suppport user-content metadata and caches, which may help manage many concurrent users requests.

### Bastion hosts
Bastion servers are traditionally used as a single point of entry to a network, to secure the access to this latter and the resources connected to it. In a public cloud environment, connection to any of the resources (EC2 instance for ex) on the VPC is made through the bastion server (often via SSH).
As per AWS documentation, "Bastion Hosts" is an AWS managed product, helping you out in setting up your bastion servers and scaling them up/down automatically depending on your needs.

### AWS Spot instances
Spot instances are EC2 instances, pre-emptible at anytime by AWS. In other words, they're not persistent and one can expect to have them shut down anytime.

Way cheaper than a regular EC2 instance, spot instances may be used for flexible workloads, i.e. stateless and loosely coupled to other instances workloads. Might be of great interest and particularly cost-effective for data&analytics compute and performance intensive workloads, which are rather fault-tolerant and standalone jobs.