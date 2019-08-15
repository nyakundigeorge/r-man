#!/bin/sh

# Override user ID lookup to cope with being randomly assigned IDs using
# the -u option to 'docker run'.
USER_ID=$(id -u)
# Ensure that assigned uid has entry in /etc/passwd.

if [[ `id -u` -ge 10000 ]]; then
    cat /etc/passwd | sed -e "s/^$RMAN_USER:/builder:/" > /tmp/passwd
    echo "$RMAN_USER:x:`id -u`:`id -g`:,,,:/home/$RMAN_USER:/bin/bash" >> /tmp/passwd
    cat /tmp/passwd > /etc/passwd
    rm /tmp/passwd
fi

# mkdir -p logs/celery

# touch logs/celery/%n%I.log logs/celery/%n.pid logs/celery/beat.log logs/celery/beat.pid celerybeat-schedule

# # start celery worker in the background
# celery multi start worker -A app -l info --pidfile=logs/celery/%n.pid --logfile=logs/celery/%n%I.log
# celery -A app beat -l info --pidfile=logs/celery/beat.pid --logfile=logs/celery/beat.log -s celerybeat-schedule --detach

gunicorn --config conf/gunicorn_config.py wsgi:app