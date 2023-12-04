#!/bin/bash

if [ ! -e "/run/mysqld/mysqld.sock" ]; then
	mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db
	mkdir -p /run/mysqld

	mysqld &

	while ! mysqladmin ping; do
		sleep 1
	done

	mysql -uroot --skip-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';"
	mysql -uroot -p$MARIADB_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS $WP_DB_NAME;"
	mysql -uroot -p$MARIADB_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$WP_ADMIN'@'%' IDENTIFIED BY '$WP_ADMIN_PASSWORD';"
	mysql -uroot -p$MARIADB_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
	mysqladmin -uroot -p$MARIADB_ROOT_PASSWORD shutdown

fi

exec mysqld
