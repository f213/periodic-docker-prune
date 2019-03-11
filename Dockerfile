FROM python:3.6-alpine

RUN apk update --no-cache && apk add docker

ADD requirements.txt /
RUN pip install -r /requirements.txt

ADD entrypoint.py /
ENTRYPOINT python /entrypoint.py