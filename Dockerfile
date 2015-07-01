#
# ElasticSearch Dockerfile
#
# https://github.com/dockerfile/elasticsearch
#

# Pull base image.
FROM java:jdk
#dockerfile/java:oracle-java7

# Install ElasticSearch.
RUN \
  cd /tmp && \
  wget https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.6.0.tar.gz && \
  tar xvzf elasticsearch-1.6.0.tar.gz && \
  rm -f elasticsearch-1.6.0.tar.gz && \
  mv /tmp/elasticsearch-1.6.0 /elasticsearch

# Define mountable directories.
VOLUME ["/data"]

# Mount elasticsearch.yml config
ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["/elasticsearch/bin/elasticsearch"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300
