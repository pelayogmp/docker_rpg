#!/bin/sh

set -e

CONTAINER="redmine"

[ -r ./gmail-passwd.secret ] || {
    echo "gmail-passwd.secret not found" 1>&2
    exit 1
}

# gmail-passwd.secret MUST define USER_NAME and EMAIL_PASSWD
. ./gmail-passwd.secret

test -z "$USER_NAME" -o -z "$EMAIL_PASSWD" && {
    echo "Missing USER_NAME or EMAIL_PASSWd" 1>&2
    exit 1
}

test -d ./tmp || mkdir ./tmp

cat ./config/configuration.yml | sed -E "s/__USER_NAME__/${USER_NAME}/; s/__EMAIL_PASSWD__/${EMAIL_PASSWD}/" > ./tmp/configuration.yml

which docker >/dev/null 2>&1 && docker container ls | grep -q -E "${CONTAINER}$" || {
    echo "Container ${CONTAINER} is not running, cannot be updated automatically" 1>&2
    echo 1>&2
    echo "Start the container and execute:" 1>&2
    echo 1>&2
    echo "docker cp ./tmp/configuration.yml ${CONTAINER}:/usr/src/redmine/config"
    echo "docker exec ${CONTAINER} chown redmine:redmine /usr/src/redmine/config/configuration.yml"
    echo "docker exec ${CONTAINER} chmod 640 /usr/src/redmine/config/configuration.yml"
    echo "docker container restart -s 15 -t 10 ${CONTAINER}"
    exit 0
}

docker cp ./tmp/configuration.yml ${CONTAINER}:/usr/src/redmine/config
docker exec ${CONTAINER} chown redmine:redmine /usr/src/redmine/config/configuration.yml
docker exec ${CONTAINER} chmod 640 /usr/src/redmine/config/configuration.yml

docker container restart -s 15 -t 10 ${CONTAINER}
