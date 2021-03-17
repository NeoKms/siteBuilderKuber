echo "____GITLAB____"
kubectl apply -f gitlab-admin-service-account.yaml
MY_NOW_IP=`curl -s https://icanhazip.com`
echo 'http://'$MY_NOW_IP':6443'
kubectl config view --raw -o json | jq -r '.clusters[0].cluster."certificate-authority-data"' | tr -d '"' | base64 --decode
kubectl -n kube-system get secrets -o json | jq -r '.items[] | select(.metadata.name | startswith("gitlab-admin")) | .data.token' | base64 --decode
echo "________"