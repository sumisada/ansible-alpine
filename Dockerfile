FROM alpine:latest

# Inhibits python to write byte code cache locally
ENV PYTHONDONTWRITEBYTECODE=1

RUN apk --no-cache add \
        python3 \
        py3-pip \
	curl    \
    &&	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    && source /root/.cargo/env \
    && apk add --no-cache --virtual build-dependencies \
        gcc \
        musl-dev \
        libffi-dev \
        openssl-dev \
        python3-dev \
    && pip install ansible \
    && rm -rf /root/.cache/pip \
    && apk del build-dependencies

#RUN mkdir -p /root/.ssh
#COPY test_server /root/.ssh/id_rsa
#COPY test_server.pub /root/.ssh/id_rsa.pub
#COPY <<EOF /root/.ssh/config
#
#EOF

WORKDIR /tests

# Inhibits pytest to write tests cache
#ENTRYPOINT ["py.test", "-p", "no:cacheprovider"]
