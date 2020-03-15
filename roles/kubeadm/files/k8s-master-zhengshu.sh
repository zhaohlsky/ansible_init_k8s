#!/bin/bash
mkdir -p /etc/kubernetes/pki/etcd
cp -a /mnt/kubernetes/pki/ca.*  /etc/kubernetes/pki/
cp -a /mnt/kubernetes/pki/sa.*  /etc/kubernetes/pki/
cp -a /mnt/kubernetes/pki/front-proxy-ca.*  /etc/kubernetes/pki/
cp -a /mnt/kubernetes/pki/etcd/ca.*  /etc/kubernetes/pki/etcd/
cp -a /mnt/kubernetes/admin.conf  /etc/kubernetes/
