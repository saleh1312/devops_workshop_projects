#!/bin/bash

kubeadm config images pull --cri-socket=unix:///var/run/cri-dockerd.sock

# # #### create cluster
# # kubeadm config print init-defaults > /vagrant/k8s_init_file.yml
# # and then edit this file with ports and cidr and systemd
kubeadm init --config /vagrant/k8s_init_file.yml

cd /home
export KUBECONFIG="/etc/kubernetes/admin.conf"

echo 'KUBECONFIG="/etc/kubernetes/admin.conf"' | sudo tee -a /etc/environment
source /etc/environment


# ### install calico
curl https://raw.githubusercontent.com/projectcalico/calico/v3.29.2/manifests/calico.yaml -O

kubectl apply -f calico.yaml


kubeadm token create --print-join-command > /vagrant/join.sh
sed -i '1s|$| --cri-socket=unix:///var/run/cri-dockerd.sock|' /vagrant/join.sh
chmod +x /vagrant/join.sh


echo "Waiting for 180 seconds before proceeding..."
sleep 180

# to see nodes
# sudo -i
# kubectl get nodes