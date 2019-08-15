docker build -t moyuanchen/multi-client:latest -t moyuanchen/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t moyuanchen/multi-server:latest -t moyuanchen/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t moyuanchen/multi-worker:latest -t moyuanchen/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push moyuanchen/multi-client:latest
docker push moyuanchen/multi-server:latest
docker push moyuanchen/multi-worker:latest

docker push moyuanchen/multi-client:$SHA
docker push moyuanchen/multi-server:$SHA
docker push moyuanchen/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=moyuanchen/multi-server:$SHA
kubectl set image deployment/client-deployment client=moyuanchen/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=moyuanchen/multi-worker:$SHA