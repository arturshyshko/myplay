FROM python:3.7

EXPOSE 8000

# Install Python requirements
ADD ./requirements.txt /tmp
RUN pip install -r /tmp/requirements.txt

RUN mkdir /app
WORKDIR /app
ADD . /app

RUN chmod +x /app/bin/*.sh

CMD bash -c "bin/run.sh"
