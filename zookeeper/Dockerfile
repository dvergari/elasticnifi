FROM centos:latest

MAINTAINER dvergari


#ADD http://mirror.nohup.it/apache/nifi/1.0.0/nifi-1.0.0-bin.tar.gz /tmp
ADD http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.5.0.0/hdp.repo /etc/yum.repos.d/hdp.repo
RUN yum install -y java zookeeper

CMD ["zookeeper-server","start-foreground"]
