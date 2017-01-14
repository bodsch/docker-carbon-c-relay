#!/bin/sh


GRAPHITE_HOST=${GRAPHITE_HOST:-graphite}
GRAPHITE_PORT=${GRAPHITE_PORT:-2003}

cfgFile="/etc/carbon-c-relay.conf"

createConfig() {

  sed -i \
    -e "s/%GRAPHITE_HOST%/${GRAPHITE_HOST}/" \
    -e "s/%GRAPHITE_PORT%/${GRAPHITE_PORT}/" \
    ${cfgFile}

}

startSupervisor() {

  echo -e "\n Starting Supervisor.\n\n"

  if [ -f /etc/supervisord.conf ]
  then
    /usr/bin/supervisord -c /etc/supervisord.conf >> /dev/null
  else
    exec /bin/sh
  fi
}


run() {

  createConfig

  /usr/bin/carbon-c-relay -f ${cfgFile} -t < /dev/null > /dev/null

  /usr/bin/carbon-c-relay -f ${cfgFile} -w 4 -q 2056 -m -b 2056 -l /var/log/carbon-relay.log

#  echo -e "\n"
#  echo " ==================================================================="
#  echo " starting carbon-c-relay"
#  echo " ==================================================================="
#  echo ""
#
#  startSupervisor
}

run

# EOF
