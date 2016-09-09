#!/bin/bash

scale() {
  if [ $number_of_nodes -eq 0 ]; then
    echo "Cannot scale to 0 nodes. Stop the cluster instead."
    exit 1
  fi
  if [ -z $number_of_nodes ]; then
    echo "Must specifity the number of nodes"
    exit 1
  fi
  current_nodes=`docker-compose ps | grep nifinode | awk '{print $1}' | cut -d '_' -f 3 | sort -rn | head -1`
  if [ $number_of_nodes -eq $current_nodes ]; then
    echo "Nothing to do"
    exit 0
  fi
  [[ $number_of_nodes -gt $current_nodes ]] && scale_up
  [[ $number_of_nodes -lt $current_nodes ]] && scale_down
}

scale_up() {
  docker-compose scale nifinode=$number_of_nodes
}
scale_down() {
  current_nodes=`docker-compose ps | grep nifinode | awk '{print $1}' | cut -d '_' -f 3 | sort -rn | head -1`
  to_remove=`docker-compose ps | grep nifinode | awk '{print $1}' |  sort -r | head -$(expr $current_nodes - $number_of_nodes)`
  for n in $to_remove; do
    hostnames="$hostnames `cat $(docker inspect $n | grep hostname | awk -F ':' '{print $2}' | cut -d '"' -f 2)`"
  done
  echo -e "Before scale down the cluster, be sure to manually disconnect the following hosts from the nifi interfaces:\n\n$hostnames\n\nAre you sure you want to scale down the cluster [y/N]?"
  read response
  case $response in
    y|Y)
      docker-compose scale nifinode=$number_of_nodes
      ;;
    *)
      echo "Aborting..."
      ;;
  esac
}

case $1 in
  start)
    docker-compose up -d
  ;;
  stop)
    docker-compose down
  ;;
  status)
    echo "Currently running nifi nodes:"
    docker-compose ps | grep nifinode | awk '{print $1}'
  ;;
  clean)
    docker-compose down -v --rmi all
  ;;
  logs)
    docker-compose logs nifinode
  ;;
  scale)
    shift
    number_of_nodes=$1
    scale
  ;;
  *)
    echo "Usage: $0 [start|stop|status|clean|scale|logs]"
esac
