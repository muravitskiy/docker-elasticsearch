#!/bin/bash

PLUGINS_PATH=/usr/share/elasticsearch/plugins/search-guard-6/tools
CONFIG_PATH=/usr/share/elasticsearch/config/searchguard

hash=$($PLUGINS_PATH/hash.sh -p $ELASTIC_PWD)
sed -ri "s|hash:[^\r\n#]*#elastic|hash: \'$hash\' #elastic|" $CONFIG_PATH/sg_internal_users.yml

hash=$($PLUGINS_PATH/hash.sh -p $KIBANA_PWD)
sed -ri "s|hash:[^\r\n#]*#kibana|hash: '$hash' #kibana|" $CONFIG_PATH/sg_internal_users.yml

hash=$($PLUGINS_PATH/hash.sh -p $LOGSTASH_PWD)
sed -ri "s|hash:[^\r\n#]*#logstash|hash: '$hash' #logstash|" $CONFIG_PATH/sg_internal_users.yml

hash=$($PLUGINS_PATH/hash.sh -p $BEATS_PWD)
sed -ri "s|hash:[^\r\n#]*#beats|hash: '$hash' #beats|" $CONFIG_PATH/sg_internal_users.yml


$PLUGINS_PATH/sgadmin.sh \
-cd $CONFIG_PATH \
-cn $CLUSTER_NAME \
-cacert $CONFIG_PATH/ssl/ca.pem \
-cert $CONFIG_PATH/ssl/cert.pem \
-key $CONFIG_PATH/ssl/key.pem \
-h $HOSTNAME \
-nhnv

exec /usr/local/bin/docker-entrypoint.sh $@