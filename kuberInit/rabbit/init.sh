kubectl apply -f pvcAndPv.yaml
kubectl apply -f rabbitmq_configmap.yaml
kubectl apply -f rabbitmq_rbac.yaml
kubectl apply -f statefull.yaml
kubectl apply -f ingress.yaml