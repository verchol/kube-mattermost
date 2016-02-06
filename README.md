#kube-mattermost

##Quickstart

1. Setup a Kubernetes cluster (on <a href="https://blog.redspread.com/2016/02/04/google-container-engine-quickstart/">Google Container Engine</a> [recommended] or <a href="https://coreos.com/kubernetes/docs/latest/kubernetes-on-aws.html#kube-aws-quickstart">AWS</a>)
2. Clone the repository: `git clone http://github.com/redspread/kube-mattermost`
3. Deploy the Kubernetes objects:  
`kubectl create -f app/rc.yml`
`kubectl create -f app/.k2e/app-service.yml`
`kubectl create -f db/rc.yml`
`kubectl create -f db/.k2e/db-service.yml`
4. Grab the public IP address (Load Balancer Ingress) `kubectl describe services/mattermost-app`
5. You should be able to see a Mattermost instance running in your browser with that public IP!


##Required for Production

1. Set Postgres username and password in `db/make_db.sh`. 
2. <a href="http://docs.mattermost.com/install/smtp-email-setup.html">Enable email</a> in `config.template.json`.
3. Create persistent disks, and make sure to un-comment the appropriate volume sections in `app/rc.yml` and `db/rc.yml`.  
Google: `gcloud compute disks create --size=30GB mattermost-postgres`  
`gcloud compute disks create --size=30GB mattermost-assets`  
AWS:  
`aws ec2 create-volume --availability-zone <ZONE> --size 10 --volume-type gp2`  
`aws ec2 create-volume --availability-zone <ZONE> --size 10 --volume-type gp2`  

Notes: The volume sizes are suggested, but you can change them to whatever you'd like. There are some limitations to using AWS volumes, which you can <a href="https://github.com/kubernetes/kubernetes/blob/master/docs/user-guide/volumes.md#awselasticblockstore">read about here</a>.

##Troubleshooting

Make sure kubectl is set to the correct project, cluster, and zone. For those using Google, <a href="https://blog.redspread.com/2016/01/10/gcloud-cheat-sheet/">here's a cheat sheet</a> to common gcloud errors (auth login, project, zone, and cluster).

Here's the original <a href="https://github.com/npcode/mattermost-docker">Dockerfile and docker-compose setup</a> by <a href="http://github.com/npcode">@npcode</a>.