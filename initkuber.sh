#docker
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - 
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" 
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose -y
sudo sysctl --system
#kuber
sudo apt-get update
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - 
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update 
sudo apt-get install -y kubelet=1.18.0-00 kubectl=1.18.0-00 kubeadm=1.18.0-00 
sudo apt-mark hold kubelet kubeadm kubectl 
swapoff -a 
kubeadm init --pod-network-cidr=10.244.0.0/16 
mkdir -p $HOME/.kube 
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config 
sudo chown $(id -u):$(id -g) $HOME/.kube/config 
export KUBECONFIG=/etc/kubernetes/admin.conf 
kubectl taint nodes --all node-role.kubernetes.io/master- 
kubectl apply -f flanel.yaml
#nfs
sudo apt update
sudo apt install nfs-common -y 
sudo apt-get install cifs-utils -y 
kubectl apply -f mynfsprivisioner.yaml
kubectl patch storageclass autonfs -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
#portainer
kubectl apply -f portainerNodeport.yaml
kubectl get services --all-namespaces
#ingress
kubectl apply -f myingress.yaml
MY_NOW_IP=`curl -s https://icanhazip.com`
kubectl patch svc ingress-nginx-controller -n ingress-nginx -p '{"spec": {"type": "NodePort", "externalIPs":["$MY_NOW_IP"]}}'
kubectl get svc -n ingress-nginx
#swapoff
sudo cp /etc/fstab /etc/fstab_backup