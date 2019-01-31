docker build -t oasystemskylesklareski/multi-client:latest -t oasystemskylesklareski/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t oasystemskylesklareski/multi-server:latest -t oasystemskylesklareski/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t oasystemskylesklareski/multi-worker:latest -t oasystemskylesklareski/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push oasystemskylesklareski/multi-client:latest
docker push oasystemskylesklareski/multi-server:latest
docker push oasystemskylesklareski/multi-worker:latest

docker push oasystemskylesklareski/multi-client:$SHA
docker push oasystemskylesklareski/multi-server:$SHA
docker push oasystemskylesklareski/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=oasystemskylesklareski/multi-server:$SHA
kubectl set image deployments/client-deployment client=oasystemskylesklareski/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=oasystemskylesklareski/multi-worker:$SHA