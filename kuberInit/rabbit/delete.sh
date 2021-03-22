kubectl delete -f statefull.yaml
kubectl delete -f ingress.yaml
kubectl delete -f rabbitmq_rbac.yaml
kubectl delete -f rabbitmq_configmap.yaml
kubectl delete -f pvcAndPv.yaml