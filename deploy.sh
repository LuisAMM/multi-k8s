docker build -t luisfredo/multi-client:latest -t luisfredo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t luisfredo/multi-server:latest -t luisfredo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t luisfredo/multi-worker:latest -t luisfredo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push luisfredo/multi-client:latest
docker push luisfredo/multi-client:$SHA
docker push luisfredo/multi-server:latest
docker push luisfredo/multi-server:$SHA
docker push luisfredo/multi-worker:latest
docker push luisfredo/multi-worker:$SHA

kubectl apply -f ./k8s

kubectl set image deployments/server-deployment server=luisfredo/multi-server:$SHA
kubectl set image deployments/client-deployment client=luisfredo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=luisfredo/multi-worker:$SHA
