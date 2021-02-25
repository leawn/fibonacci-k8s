docker build -t leawn/fibonacci-calc-client:latest -t leawn/fibonacci-calc-client:$GIT_SHA ./client
docker build -t leawn/fibonacci-calc-server:latest -t leawn/fibonacci-calc-server:$GIT_SHA ./server
docker build -t leawn/fibonacci-calc-worker:latest -t leawn/fibonacci-calc-worker:$GIT_SHA ./worker

docker push leawn/fibonacci-calc-client:latest
docker push leawn/fibonacci-calc-client:$GIT_SHA

docker push leawn/fibonacci-calc-server:latest
docker push leawn/fibonacci-calc-server:$GIT_SHA

docker push leawn/fibonacci-calc-worker:latest
docker push leawn/fibonacci-calc-worker:$GIT_SHA

kubectl apply -f k8s/
kubectl set image deployments/server-deployment server=leawn/fibonacci-calc-server:$GIT_SHA
kubectl set image deployments/client-deployment client=leawn/fibonacci-calc-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=leawn/fibonacci-calc-worker:$GIT_SHA


# On Google Cloud using Cloud Shell of the Kubernetes Engine Cluster
# gcloud config set project $project-id
# gcloud config set compute/zone $region
# gcloud container clusters get-credentials $cluster-name
# kubectl create secret generic pgpassword --from-literal PGPASSWORD=$some-password

# Helm setup github.com/kubernetes/nginx-ingress(?) //smth like that // github.com/helm/helm
#