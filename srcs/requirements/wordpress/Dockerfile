FROM alpine:3.17.5

RUN apk -U upgrade \
	&& rm -rf /var/cache/apk/* \
	&& apk add --no-cache php81 \
	php81-fpm \
	php81-openssl \
	php81-curl \
	php81-intl \
	php81-json \
	php81-mbstring \
	php81-mysqli \
	php81-opcache \
	php81-xml \
	php81-zip \
	php81-phar \
	php81-exif \
	php81-dom \
	php81-fileinfo \
	curl \
	dumb-init

COPY ./tools/wp-start.sh .

RUN sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
		/etc/php81/php-fpm.d/www.conf && \
	sed -i "s|;cgi.fix_pathinfo=1|cgi.fix_pathinfo=0|g" \
		/etc/php81/php.ini

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

EXPOSE 443

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["sh", "./wp-start.sh"]