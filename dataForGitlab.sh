echo "____GITLAB____"
kubectl apply -f gitlab-admin-service-account.yaml
MY_NOW_IP=`curl -s https://icanhazip.com`
sed -i "s/__KUBEIP__/$MY_NOW_IP/" ./kuberInit/configs/server-type.yaml
sed -i "s/__KURL__/$MY_NOW_IP/" ./kuberInit/configs/server-type.yaml
echo `kubectl cluster-info | grep -E 'Kubernetes master|Kubernetes control plane' | awk '/http/ {print $NF}'`
kubectl config view --raw -o json | jq -r '.clusters[0].cluster."certificate-authority-data"' | tr -d '"' | base64 --decode
MY_KUBE_TOKEN=`kubectl -n kube-system get secrets -o json | jq -r '.items[] | select(.metadata.name | startswith("gitlab-admin")) | .data.token' | base64 --decode`
sed -i "s/__KTOKEN__/$MY_KUBE_TOKEN/" ./kuberInit/configs/server-type.yaml
echo $MY_KUBE_TOKEN
echo "________"
