# CentOS7 based apache/php container using Software Collections, with MySQL support.

## Installed Software

* centos-release-scl (software collections repo)
* httpd24
* rh-php56 (php 5.6 base package)
* rh-php56-php (apache support for php 5.6)
* rh-php56-mysqlnd
* rh-php56-mbstring

## Configuration

Default configuration uses run-apache script to start apache and adds the foreground option to the Software Collections sysconfig file for apache. All content in the html directory is populated into the software collections home directory /opt/rh/httpd24/root/var/www/html.

## Some useful commands

To build an image tagged gizmonicus/centos7-scl-simple:

        docker build --rm -t  .

To run gizmonicus/centos7-scl-simple using local port 8080 forwarded to container port 80:

        docker run -d -p 8080:80 gizmonicus/centos7-scl-simple

To see what docker containers are running:

        docker ps

To open a shell into a currently running container (get container name from "docker ps"):

        docker exec -it {CONTAINER_NAME} /bin/bash

To connect to a container using local port 8080 forwarded to container port 80:

        (In browser) http://localhost:8080/
