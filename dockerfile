FROM nextcloud:24.0.12

RUN set -ex; \
    \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        mariadb-client \
    ; \
    rm -rf /var/lib/apt/lists/*
