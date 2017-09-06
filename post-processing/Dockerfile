FROM node:6
MAINTAINER Justin Pfefferle <jpfeffer@student.42.us.org>

RUN apt-get update \
    && apt-get install -y jq python git build-essential supervisor --no-install-recommends \
    && mkdir -p /var/log/supervisor

WORKDIR /opt/backbeat
RUN git clone https://github.com/Netsrfr/backbeat.git
#COPY ./backbeat/ /opt/backbeat/backbeat
WORKDIR /opt/backbeat/backbeat
RUN git checkout wip/post_processing && npm install
#RUN npm install

COPY config.json /opt/backbeat/backbeat/conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#no ports exposed

CMD supervisord -c /etc/supervisor/supervisord.conf -n
