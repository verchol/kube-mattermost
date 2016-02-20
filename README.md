#kube-mattermost

##Quickstart

1. Setup a Kubernetes cluster (on <a href="https://blog.redspread.com/2016/02/04/google-container-engine-quickstart/">Google Container Engine</a> [recommended] or <a href="https://coreos.com/kubernetes/docs/latest/kubernetes-on-aws.html#kube-aws-quickstart">AWS</a>)
2. Clone the repository: `git clone http://github.com/redspread/kube-mattermost`
3. Run `spread deploy .` in the cloned directorey.
4. You should be able to see a Mattermost instance running in your browser with that public IP!


## Recommended for Production
Run `spread deploy` to update the cluster after making changes.

### Customize image (email + other settings)
1. <a href="http://docs.mattermost.com/install/smtp-email-setup.html">Enable email</a> in `config.template.json`.
1. Build image (`docker build -t "youruser/yourrepo:sometag" .`)
1. Push image (`docker push youruser/yourrepo:sometag`)
1. Replace the Image field in `mattermost.ctr` with your image name (youruser/yourrepo:sometag)

### Use persistent volume
Unless a persistent volume is used, the data stored in postgres will be lost if for any reason the postgres container stops running. 

1. Create persistent disks  
**Google:**  
`gcloud compute disks create --size=30GB mattermost-postgres`  
`gcloud compute disks create --size=30GB mattermost-assets`  
1. Un-comment the appropriate volume sections in `app/rc.yml` and `db/rc.yml`

### Set database password
1. Set Postgres username and password in `.k2e/secret.yaml`. 

*Note: Secret  data values are base64 encoded.*

 

Notes: The volume sizes are suggested, but you can change them to whatever you'd like.
##Troubleshooting

Make sure kubectl is set to the correct project, cluster, and zone. For those using Google, <a href="https://blog.redspread.com/2016/01/10/gcloud-cheat-sheet/">here's a cheat sheet</a> to common gcloud errors (auth login, project, zone, and cluster).

Here's the original <a href="https://github.com/npcode/mattermost-docker">Dockerfile and docker-compose setup</a> by <a href="http://github.com/npcode">@npcode</a>.