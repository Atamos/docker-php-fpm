FROM centos:6
MAINTAINER Marco Sciatta "marco.sciatta@gmail.com"
ENV UPDATED_AT 2015-01-08

RUN yum -y update && yum clean all
RUN rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm

RUN yum -y install \ 
 	php55w-fpm \
        php55w-mysql \
	php55w-cli \
	php55w-apc \
	curl \
	vim \
	php55w-gd \
	php55w-intl \
	php55w-pear \ 
	php55w-imagick \
	php55w-imap \
	php55w-mcrypt \
	php55w-ming \
	php55w-ps \
	php55w-pspell \
	php55w-recode \
	php55w-tidy \
	php55w-xmlrpc \
	php55w-xsl \
	php55w-intl


RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

RUN curl -LsS http://symfony.com/installer > symfony.phar
RUN mv symfony.phar /usr/local/bin/symfony
RUN chmod a+x /usr/local/bin/symfony

ADD php.ini /etc/php.ini

RUN sed -i s/\;cgi\.fix_pathinfo\s*\=\s*1/cgi.fix_pathinfo\=0/ /etc/php.ini
RUN sed -i '/^listen = /clisten = 0.0.0.0:9000'  /etc/php-fpm.d/www.conf 
RUN sed -i '/^listen.allowed_clients/c;listen.allowed_clients =' /etc/php-fpm.d/www.conf 
RUN sed -i '/^;catch_workers_output/ccatch_workers_output = yes' /etc/php-fpm.d/www.conf 

EXPOSE 9000

WORKDIR /var/www
CMD ["/usr/sbin/php-fpm", "--nodaemonize"]

