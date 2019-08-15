FROM python:3.7.2-alpine3.8

ENV RMAN_USER email_service
ENV AA_MONITOR_GROUP email_service
ENV DEBIAN_FRONTEND noninteractive
ENV USER $RMAN_USER

RUN apk add --update alpine-sdk

RUN addgroup -S $RMAN_USER &
RUN adduser -S -g $AA_MONITOR_GROUP $RMAN_USER
RUN adduser $RMAN_USER root

WORKDIR /home/$RMAN_USER

COPY . .

RUN mkdir -p /logs/celery

RUN pip install pipenv
RUN pipenv lock -r > requirements.txt
RUN pip install -r requirements.txt

EXPOSE 6000

COPY docker-entrypoint.sh docker-entrypoint.sh

RUN chmod 555 docker-entrypoint.sh

RUN chmod o+x /home/$RMAN_USER
RUN chmod -R 775 /home/$RMAN_USER
RUN chown -R $RMAN_USER:root /home/$RMAN_USER

ENTRYPOINT ["./docker-entrypoint.sh"]