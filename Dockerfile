FROM python:3.13-alpine
ENV DOCKER_VERSION=29.3.1

ARG TARGETARCH=amd64
RUN case "${TARGETARCH}" in \
      amd64) ARCH="x86_64" ;; \
      arm64) ARCH="aarch64" ;; \
      *) echo "Unsupported architecture: ${TARGETARCH}" && exit 1 ;; \
    esac && \
    wget -q "https://download.docker.com/linux/static/stable/${ARCH}/docker-${DOCKER_VERSION}.tgz" && \
    tar zxpvf docker-${DOCKER_VERSION}.tgz && \
    cp docker/docker /usr/bin && \
    rm -Rf docker && \
    rm -Rf docker-${DOCKER_VERSION}.tgz

COPY requirements.txt /
RUN pip install --no-cache-dir -r /requirements.txt

COPY entrypoint.py /
ENTRYPOINT ["python", "/entrypoint.py"]
