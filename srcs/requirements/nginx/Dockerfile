FROM alpine:3.17.5

RUN apk -U upgrade \
	&& rm -rf /var/cache/apk/* \
	&& apk add --no-cache nginx openssl dumb-init

RUN openssl req -newkey rsa:4096 -noenc -x509 -days 365 \
	-subj /C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=Student/CN=SSL_self_signed_certs \
	-keyout /etc/ssl/server.key -out /etc/ssl/server.crt

RUN chmod 600 /etc/ssl/server.crt /etc/ssl/server.key

COPY ./conf/default.conf /etc/nginx/http.d/default.conf

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["nginx", "-g", "daemon off;"]