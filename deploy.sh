docker build -t mohitkmr07/multi-client:latest -t mohitkmr07/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mohitkmr07/multi-server:latest -t mohitkmr07/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mohitkmr07/multi-worker:latest -t mohitkmr07/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mohitkmr07/multi-client:latest
docker push mohitkmr07/multi-server:latest
docker push mohitkmr07/multi-worker:latest

docker push mohitkmr07/multi-client:$SHA
docker push mohitkmr07/multi-server:$SHA
docker push mohitkmr07/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mohitkmr07/multi-server:$SHA
kubectl set image deployments/client-deployment client=mohitkmr07/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mohitkmr07/multi-worker:$SHA