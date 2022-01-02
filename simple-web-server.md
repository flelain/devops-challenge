## Technical context
Firsts steps followed:
- spin up a Compute Engine instance on GCP (centos)
- install apache2/httpd
- setup and test a basic homepage (index.html and a picture in instance /var/www/html directory)

Create a Dockerfile to build an image of that trivial app: see [Dockerfile](./Dockerfile)
Build and push the image (GCP Cloud Shell) with:
```
docker build -t gcr.io/cto-gcp-cloud-ops/devops-challenge:0.1 .
docker push gcr.io/cto-gcp-cloud-ops/devops-challenge:0.1
```

Create a terraform plan (with a backend) and a couple of variables (see [here in the repo](./terraform))

Then, through GCP Cloud Shell (terraform, docker, ...)
```
terraform init
terraform plan
```

Deploy with GitLab CI, based on this [.gitlab-ci.yml file]()

Made available on  https://devops-cloudrun-svvlutnrmq-ew.a.run.app



### Steps followed
**Set up a basic website**
I used the "Hello World" trivial website publicly available here: https://github.com/haggman/HelloWorldNodeJs which I built a container image from and that I deployed on Google Cloud Platform through Cloud Run service (via a terraform plan)

Using the GCP Cloud Shell as my launchpad, here are the steps I followed (snippet from my bash history):
```
git clone https://github.com/haggman/HelloWorldNodeJs
cd HelloWorldNodeJs/
docker build -t gcr.io/my-project/devops-challenge:0.1 .
docker push gcr.io/my-project/devops-challenge:0.1
terraform init
terraform apply
```
Eventually, the container is run and service exposed by GCP. See https://devops-cloudrun-svvlutnrmq-ew.a.run.app/.

All files (terraform files, Dockerfile attached).


### Steps followed
**Set up a basic website**
I chose to use a nginx webserver, with a very basic web content- an `index.html` "Hello World" file and an image). To keep it simple, I ran everything below from GCP Cloud Shell, within a project of a GCP free trial account. Here are the steps I followed - snippet from my bash history:

```
git clone https://github.com/flelain/devops-challenge
docker build -t gcr.io/my-project/devops-challenge:0.1 .
docker push gcr.io/my-project/devops-challenge:0.1
terraform init
terraform apply
```
Eventually, the container is run and service exposed by GCP. See https://devops-cloudrun-svvlutnrmq-ew.a.run.app/.

All files (terraform files, Dockerfile attached).


