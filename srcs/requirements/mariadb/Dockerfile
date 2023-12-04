FROM alpine:3.17.5

RUN apk -U upgrade \
	&& rm -rf /var/cache/apk/* \
	&& apk add --no-cache mariadb mariadb-client dumb-init

COPY ./conf/my.cnf /etc/my.cnf
COPY ./tools/db-start.sh .

EXPOSE 3306

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["sh", "./db-start.sh"]