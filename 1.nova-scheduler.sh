#!/bin/bash

. me/novarc

CA_DIR=/home/ohara/Projects/OpenStack/nova/trunk/CA
KEYS_PATH=/home/ohara/Projects/OpenStack/nova/data/keys
IMAGES_PATH=/home/ohara/Projects/OpenStack/nova/data/images
BUCKETS_PATH=/home/ohara/Projects/OpenStack/nova/data/buckets
INSTANCES_PATH=/home/ohara/Projects/OpenStack/nova/data/instances
NETWORKS_PATH=/home/ohara/Projects/OpenStack/nova/data/networks
LOGFILE=LOG_nova-scheduler_`date +%m%d-%H%M`


#NETWORK_ARGS="--flat_network=true --flat_network_gateway=192.168.1.1 --flat_network_netmask=255.255.255.0 --flat_network_network=192.168.1.0 --flat_network_ips=192.168.1.220,192.168.1.221,192.168.1.222 --flat_network_bridge=br0 --flat_network_broadcast=192.168.1.255"

# Not sure whether setting is required for multiple servers environment.
#HOSTIP=192.168.11.15
#HOST_ARGS="--redis_host=${HOSTIP} --rabbit_host=${HOSTIP} --s3_host=${HOSTIP}"

MYSQL_PASS=nova
SQL_CONN=mysql://root:${MYSQL_PASS}@localhost/nova

NOVA_SCHEDULER_ARGS="--ca_path=${CA_DIR} --keys_path=${KEYS_PATH} ${NETWORK_ARGS} --images_path=${IMAGES_PATH} --use_s3=false --instances_path=${INSTANCES_PATH} --networks_path=${NETWORKS_PATH} ${HOST_ARGS} --sql_connection=${SQL_CONN}"
#NOVA_SCHEDULER_ARGS="--ca_path=${CA_DIR} --keys_path=${KEYS_PATH} ${NETWORK_ARGS} --images_path=${IMAGES_PATH} --use_s3=false --instances_path=${INSTANCES_PATH} --networks_path=${NETWORKS_PATH} ${HOST_ARGS}"

echo ${NOVA_SCHEDULER_ARGS} > ${LOGFILE}

bin/nova-scheduler ${NOVA_SCHEDULER_ARGS} --nodaemon --verbose start 2>&1 |tee -a ${LOGFILE}
