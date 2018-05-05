#!/bin/bash

# executar enviando o codigo do processo, 
# exemplo: ps aux | grep java
# chamada: ./thread-dump.sh <pid>
# deve ser executado com o mesmo usuario dono do processo,
# su -p -s /bin/sh jboss -c ./thread-dump.sh <pid>

pid="$1"

[ -z $pid ] && echo "Informe o pid do processo java" && exit 1

for n in {1..10}; do
  jstack $1 > `date +%Y%m%d%H%M%S`.thdump
  sleep 5
done
