# Simple Webserver

## Technical context

**Set up a basic website**
I chose to use a nginx webserver, with a very basic web content- an `index.html` "Hello World" file and an image). To keep it simple, I ran everything below from GCP Cloud Shell, within a project of a GCP free trial account. Here are the steps I followed - snippet from my bash history:

```
git clone https://github.com/flelain/devops-challenge
cd devops-challenge/
docker build -t gcr.io/devops-challenge-336815/devops-challenge:0.1 .
docker push gcr.io/devops-challenge-336815/devops-challenge:0.1
cd terraform
terraform init
terraform apply -auto-approve
# terraform destroy -auto-approve # to destroy the resource created
```
Eventually, the container is run and service is exposed by GCP. See https://devops-cloudrun-phzhtxl4da-ew.a.run.app/.

All files -terraform files, Dockerfile, `nginx.conf`file and website assets- made available on [my gihub](github.com/flelain/devops-challenge).

## Bonus
### Load-balancing
The solution I opted for here (GCP Cloud Run) scales by itself; hence a loadbalancer option is not quite relevant. Now, for a real non-trivial website, I would rely on:
- a kubernetes cluster (managed like GKE on GCP or not managed), hosting the diverse microservices composing my website (frontend, cart, paymentservice, recommendation, ... for ex for an e-shop)
- an external loadbalancer; again managed (eg GCP global external lb) or unmanaged (nginx, haproxy, ...) which would round-robin towards the live instances of the website

### Automation
I used GitLab CI to automate the build and push of the image and then the deployment of the container on GCP. The steps I followed:
- Set up a [`.gitlab-ci.yml` file](.gitlab-ci.yaml), with 3 jobs (build/push, tf apply and tf destroy)
- Create of a Service Account on GCP, with Editor and Cloud Run Admin roles, to allow GitLab runner to perform all the actions needed
- Issue of a JSON key for that service account, provided to GL as a env var.
- Add a `backend.tf` file to store terraform states in a GCP Cloud Storage bucket - necessary to add a `destroy` step to my pipeline.

With this pipeline:
1. the image is built on a runner of my GitLab instance and then pushed to `gcr.io` container registry (that of my GCP project)
2. Terraform plan is applied leading to the creation of a Cloud Run service, running my container image on this GCP managed PaaS.
3. Cloud Run service can be destroyed with the `destroy` job, relying on the `terraform state` stored in a GCP bucket.

## Discussion topics
