echo "____GITLAB____"
kubectl apply -f gitlab-admin-service-account.yaml
MY_NOW_IP=`curl -s https://icanhazip.com`
MY_KUB_URL='http://'$MY_NOW_IP':6443'
echo MY_KUB_URL
kubectl config view --raw -o json | jq -r '.clusters[0].cluster."certificate-authority-data"' | tr -d '"' | base64 --decode
MY_KUBE_TOKEN=`kubectl -n kube-system get secrets -o json | jq -r '.items[] | select(.metadata.name | startswith("gitlab-admin")) | .data.token' | base64 --decode`
echo MY_KUBE_TOKEN
echo "________"
sed -i "s/__KURL__/$MY_KUB_URL/" ./kuberinit/configs/server-type.yaml
sed -i "s/__KTOKEN__/$MY_KUBE_TOKEN/" ./kuberinit/configs/server-type.yaml
