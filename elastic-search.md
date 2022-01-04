# Test Elastic Search
## Discussion topics
So far, I've only been a light user of ElasticSearch in a K8s environment. Therefore, I'm now discovering the architecture and details about its implementation in the [ElasticSearch official documentation](https://www.elastic.co/guide/index.html).
I understand there are two major kinds of nodes: master and data nodes. The first are responsible for the control and operations (eg creation/deletion of indexes). The latter contain the actual data. Nodes are software instances, not machines. An ElasticSearch cluster is a logical set of master and data nodes. Within a cluster, tasks like searching and indexing are spread across all nodes.  
It exists a third kind of node: the client, responsible for loadbalancing and routing request to cluster nodes.

Security wise, different aspects and related features are to be considered for ElasticSearch and Kibana:
- manage access to the cluster based on identity (users/service accounts), based either on password, token, other auth keys, ... with a local or global directory
- enforce a role-based access, which certainly is a feature one can set with ElasticSearch and Kibana
- encrypt communication between nodes to protect data integrity and confidentiality (through SSL/TLS for exmaple)
- maybe obvious but... avoid exposing Elastic or Kibana on Internet
- surely other key options to be considered (IP filtering as mentioned in doc for example, security events auditing as well, ...)

From my experience of ElasticSearch as a Kubernetes cluster admin in a production grade context, I used to dedicate 3 K8s cluster nodes to ElasticSearch&Kibana, hosting master/data ES nodes, relying on cluster's persistent storage for storing the data (ceph cluster based storage, 1TB/persistent volume). Deployment, provisioning, management and orchestration of the full ElasticStack was taken care of by a K8s operator.
