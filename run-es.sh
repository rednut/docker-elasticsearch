docker run -d --name="elasticsearch" -p 9200:9200 -p 9300:9300 -v /docker/elasticsearch:/data rednut/elasticsearch /elasticsearch/bin/elasticsearch -Des.config=/data/elasticsearch.yml
