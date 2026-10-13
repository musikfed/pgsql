FROM postgres:16-bookworm

USER root
RUN apt-get update \
 && apt-get install -y --no-install-recommends python3 python3-pip curl \
 && pip3 install --break-system-packages --no-cache-dir "patroni[etcd3]>=4,<5" psycopg2-binary \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/patroni /var/lib/postgresql/patroni \
 && chown -R postgres:postgres /etc/patroni /var/lib/postgresql/patroni

COPY patroni.yml /etc/patroni/patroni.yml
USER postgres
ENTRYPOINT ["patroni"]
CMD ["/etc/patroni/patroni.yml"]
