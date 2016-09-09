FROM centos:centos7

# cache the release and update so it won't take as long on subsequent rebuilds
RUN yum -y install centos-release-scl; yum -y update; yum clean all

# install dependencies
RUN yum -y install httpd24 rh-php56 rh-php56-php rh-php56-mysqlnd rh-php56-mbstring; yum clean all

# set apache to run in foreground - environment variable is simpler than using a file
# Custom runtime options can be set using APACHE_OPTIONS env, which is added to this variable by run-apache script
ENV OPTIONS "-D FOREGROUND"

# Allow access to the apache port, ssl is not supported at this point
EXPOSE 80

# Simple startup script to avoid some issues observed with container restart 
ADD run-apache /run-apache
RUN chmod -v +x /run-apache

CMD ["/run-apache"]

# Update code, can be overridden with a volume at runtime if needed for development
ADD html/ /opt/rh/httpd24/root/var/www/html/
