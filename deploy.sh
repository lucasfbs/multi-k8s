docker build -t lfbds/multi-client:latest -t lfbds/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lfbds/multi-server:latest -t lfbds/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lfbds/multi-worker:latest -t lfbds/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lfbds/multi-client:latest
docker push lfbds/multi-client:$SHA
docker push lfbds/multi-server:latest
docker push lfbds/multi-server:$SHA
docker push lfbds/multi-worker:latest
docker push lfbds/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lfbds/multi-server:$SHA
kubectl set image deployments/client-deployment server=lfbds/multi-client:$SHA
kubectl set image deployments/worker-deployment server=lfbds/multi-worker:$SHA
