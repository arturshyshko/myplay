export CREATE_DATABASE=${CREATE_DATABASE:-False}
export PERFORM_MIGRATIONS=${PERFORM_MIGRATIONS:-True}
export LOAD_FIXTURES=${LOAD_FIXTURES:-False}
export COLLECT_STATIC=${COLLECT_STATIC:-False}

if [ ! -z "${WAIT_FOR_HOST_PORT}" ]
then
    echo "[run.sh] - Waiting for host:port '${WAIT_FOR_HOST_PORT}'."
    # (we assume that `WAIT_FOR_HOST_PORT` is set to <host>:<port> of the database)
    bin/wait-for-it.sh ${WAIT_FOR_HOST_PORT} -- echo "Remote ${WAIT_FOR_HOST_PORT} is ready."
fi

if [ "${CREATE_DATABASE}" == "True" ]
then
    echo "[run.sh] - Creating db"
	python manage.py createdb
fi

if [ "${PERFORM_MIGRATIONS}" == "True" ]
then
    echo "[run.sh] - Migrations"
	python manage.py migrate --noinput
fi

if [ "${LOAD_FIXTURES}" == "True" ]
then
    echo "[run.sh] - Loading fixtures"
	python manage.py load-fixtures
fi

if [ "${COLLECT_STATIC}" == "True" ]
then
    echo "[run.sh] - Collecting static"
	python manage.py collectstatic --noinput
fi

uwsgi --ini /app/bin/uwsgi.ini
