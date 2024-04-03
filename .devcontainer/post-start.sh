#!/bin/bash

echo "post-start start" >> ~/.status.log

kind export kubeconfig --name workshop

terraform init >> ~/.status.log 2>&1

source ~/.bashrc

echo "post-start complete" >> ~/.status.log
