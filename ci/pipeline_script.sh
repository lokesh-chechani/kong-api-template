#!/usr/bin/env bash

admin_api="$1"
admin_token="$2"
kong_workspace="$3"
repository_path="$4"
tmp_path="$5"

echo "Converting OAS file to Kong declarative configuration named kong.yaml"

echo "Using Inso version: "$(inso --version)

inso generate config ${repository_path}/swagger-petstore.yaml -o ${tmp_path}/kong.yaml

echo "Taking a snapshot of the current Kong EE configuration"

deck dump -o ${tmp_path}/currentConfig.yaml --headers "kong-admin-token:$admin_token" --kong-addr ${admin_api} --tls-skip-verify

echo "Generating decK diff of current vs new state"

deck diff -s $repository_path/meta.yaml -s ${tmp_path}/kong.yaml -s $repository_path/plugins/ --workspace $kong_workspace --headers "kong-admin-token:$admin_token" --kong-addr ${admin_api} --tls-skip-verify

echo "Deploying API to Kong"

deck sync -s $repository_path/meta.yaml -s ${tmp_path}/kong.yaml -s $repository_path/plugins/ --workspace $kong_workspace --headers "kong-admin-token:$admin_token" --kong-addr ${admin_api} --tls-skip-verify

echo "Deployment complete. Moving to test phase"
