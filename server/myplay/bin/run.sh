export CREATE_DATABASE=${CREATE_DATABASE:-False}
export PERFORM_MIGRATIONS=${PERFORM_MIGRATIONS:-True}

if [ ! -z "${WAIT_FOR_HOST_PORT}" ]
then
    echo "[run.sh] - Waiting for host:port '${WAIT_FOR_HOST_PORT}'."
    # (we assume that `WAIT_FOR_HOST_PORT` is set to <host>:<port> of the database)
    bin/wait-for-it.sh ${WAIT_FOR_HOST_PORT} -- echo "Remote ${WAIT_FOR_HOST_PORT} is ready."
fi

if [ "${CREATE_DATABASE}" == "True" ]
then
	python manage.py createdb
fi

if [ "${PERFORM_MIGRATIONS}" == "True" ]
then
	python manage.py migrate --noinput
fi

uwsgi --ini /app/bin/uwsgi.ini
