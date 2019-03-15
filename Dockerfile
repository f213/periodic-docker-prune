FROM python:3.6-alpine
ENV DOCKER_VERSION=18.09.3

RUN wget https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz && \
    tar zxpvf docker-${DOCKER_VERSION}.tgz && \
    cp docker/docker /usr/bin && \
    rm -Rf docker && \
    rm -Rf docker-${DOCKER_VERSION}.tgz

ADD requirements.txt /
RUN pip install -r /requirements.txt

ADD entrypoint.py /
ENTRYPOINT python /entrypoint.py