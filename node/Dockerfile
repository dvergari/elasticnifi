FROM centos:latest

MAINTAINER dvergari


ADD http://mirror.nohup.it/apache/nifi/1.0.0/nifi-1.0.0-bin.tar.gz /tmp
#COPY ./nifi-1.0.0-bin.tar.gz /tmp

VOLUME ["/nifi"]
EXPOSE 8080
RUN yum install -y java; cd /opt/; tar -xzvf /tmp/nifi-1.0.0-bin.tar.gz
ADD start-nifi.sh /usr/bin/start-nifi.sh

CMD ["start-nifi.sh"]
