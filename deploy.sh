docker build -t zhongduo/multi-client:latest -t zhongduo/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t zhongduo/multi-server:latest -t zhongduo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t zhongduo/multi-worker:latest -t zhongduo/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push zhongduo/multi-client:latest
docker push zhongduo/multi-server:latest
docker push zhongduo/multi-worker:latest
docker push zhongduo/multi-client:$SHA
docker push zhongduo/multi-server:$SHA
docker push zhongduo/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=zhongduo/multi-server:$SHA
kubectl set image deployments/client-deployment client=zhongduo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=zhongduo/multi-worker:$SHA