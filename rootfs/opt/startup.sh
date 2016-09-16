#!/bin/sh


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

  echo -e "\n"
  echo " ==================================================================="
  echo " starting carbon-c-relay"
  echo " ==================================================================="
  echo ""

  startSupervisor
}

run

# EOF
