docker build -t pres1av/multi-client:latest -t pres1av/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t pres1av/multi-server:latest -t pres1av/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t pres1av/multi-worker:latest -t pres1av/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push pres1av/multi-client:latest
docker push pres1av/multi-client:$GIT_SHA
docker push pres1av/multi-server:latest
docker push pres1av/multi-server:$GIT_SHA
docker push pres1av/multi-worker:latest
docker push pres1av/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pres1av/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=pres1av/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=pres1av/multi-worker:$GIT_SHA