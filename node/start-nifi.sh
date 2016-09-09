#!/bin/bash

# Nifi directory location
sed -i "s,^\(nifi\.flow\.configuration\.file\s*=\s*\).*$,\1$DATADIR\/flow.xml.gz," /opt/nifi-1.0.0/conf/nifi.properties
sed -i "s,^\(nifi\.database\.directory\s*=\s*\).*$,\1$DATADIR\/database_repository," /opt/nifi-1.0.0/conf/nifi.properties
sed -i "s,^\(nifi\.flowfile\.repository\.directory\s*=\s*\).*$,\1$DATADIR\/flowfile_repository," /opt/nifi-1.0.0/conf/nifi.properties
sed -i "s,^\(nifi\.content\.repository\.directory\.default\s*=\s*\).*$,\1$DATADIR\/content_repository," /opt/nifi-1.0.0/conf/nifi.properties
sed -i "s,^\(nifi\.provenance\.repository\.directory\.default\s*=\s*\).*$,\1$DATADIR\/provenance_repository," /opt/nifi-1.0.0/conf/nifi.properties

# Nifi cluster configs
sed -i "s,^\(nifi\.cluster\.is\.node\s*=\s*\).*$,\1true," /opt/nifi-1.0.0/conf/nifi.properties
sed -i "s,^\(nifi\.cluster\.node\.address\s*=\s*\).*$,\1$(hostname)," /opt/nifi-1.0.0/conf/nifi.properties
sed -i "s,^\(nifi\.cluster\.node\.protocol\.port\s*=\s*\).*$,\1$PORT," /opt/nifi-1.0.0/conf/nifi.properties
sed -i "s,^\(nifi\.zookeeper\.connect\.string\s*=\s*\).*$,\1zookeeper:2181," /opt/nifi-1.0.0/conf/nifi.properties

# Web config
sed -i "s,^\(nifi\.web\.http\.host\s*=\s*\).*$,\1$(hostname)," /opt/nifi-1.0.0/conf/nifi.properties

# Start Nifi
/opt/nifi-1.0.0/bin/nifi.sh start

tailf $LOGDIR/nifi-app.log
