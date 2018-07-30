FROM docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.4

RUN bin/elasticsearch-plugin install -b com.floragunn:search-guard-6:6.2.4-22.1
RUN chmod +x /usr/share/elasticsearch/plugins/search-guard-6/tools/sgadmin.sh
RUN chmod +x /usr/share/elasticsearch/plugins/search-guard-6/tools/hash.sh

COPY config/ /usr/share/elasticsearch/config/

ENV CLUSTER_NAME="elasticsearch" \
    MINIMUM_MASTER_NODES=1 \
    HOSTS="127.0.0.1," \
    NODE_NAME=NODE-1 \
    NODE_MASTER=true \
    NODE_DATA=true \
    NODE_INGEST=true \
    HTTP_ENABLE=true \
    HTTP_CORS_ENABLE=true \
    HTTP_CORS_ALLOW_ORIGIN=* \
    HTTP_PORT=9200 \
    HTTP_PUBLISH_PORT=9200 \
    NETWORK_HOST="0.0.0.0" \
    NETWORK_PUBLISH_HOST="127.0.0.1" \
    TRANSPORT_PORT=9300 \
    TRANSPORT_PUBLISH_PORT=9300 \
    ELASTIC_PWD="changeme" \
    KIBANA_PWD="changeme" \
    LOGSTASH_PWD="changeme" \
    BEATS_PWD="changeme" \
    HEAP_SIZE="1g" \
    HTTP_SSL=true

COPY entrypoint.sh /run/entrypoint.sh
RUN chmod +x /run/entrypoint.sh

ENTRYPOINT ["/run/entrypoint.sh"]