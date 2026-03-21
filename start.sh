#!/bin/bash
php-fpm8.2 -D
sleep 1
nginx -g 'daemon off;'