#!/bin/bash
# openoffice.org headless server script
#
# chkconfig: 2345 80 30
# description: headless openoffice server script
# processname: openoffice
#
# Author: Vic Vijayakumar
# Modified by Federico Ch. Tomasczik
#
# http://code.google.com/p/openmeetings/wiki/OpenOfficeConverter
#
# sudo chmod 0755 /etc/init.d/openoffice.sh
# sudo update-rc.d openoffice.sh defaults
# sudo /etc/init.d/openoffice.sh start
# sudo apt-get install openoffice.org-headless openoffice.org-writer openoffice.org-draw

OOo_HOME=/usr/bin
SOFFICE_PATH=$OOo_HOME/soffice
PIDFILE=/var/run/openoffice-server.pid

set -e

case "$1" in
    start)
    if [ -f $PIDFILE ]; then
      echo "OpenOffice headless server has already started."
      sleep 5
      exit
    fi
      echo "Starting OpenOffice headless server"
      $SOFFICE_PATH -headless -nologo -nofirststartwizard -accept="socket,host=127.0.0.1,port=8100;urp" & > /dev/null 2>&1
      touch $PIDFILE
    ;;
    stop)
    if [ -f $PIDFILE ]; then
      echo "Stopping OpenOffice headless server."
      killall -9 soffice && killall -9 soffice.bin
      rm -f $PIDFILE
      exit
    fi
      echo "Openoffice headless server is not running."
      exit
    ;;
    *)
    echo "Usage: $0 {start|stop}"
    exit 1
esac
exit 0
