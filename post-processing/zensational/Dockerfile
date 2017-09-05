FROM node:6
MAINTAINER Justin Pfefferle <jpfeffer@student.42.us.org>

RUN apt-get update \
    && apt-get install -y jq python git build-essential supervisor --no-install-recommends \
    && mkdir -p /var/log/supervisor

WORKDIR /opt/post_processing
RUN git clone https://github.com/Netsrfr/post_processing_consumer.git consumer
WORKDIR /opt/post_processing/consumer
RUN npm install

COPY config.json /opt/post_processing/consumer/conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#no ports exposed

CMD supervisord -c /etc/supervisor/supervisord.conf -n
