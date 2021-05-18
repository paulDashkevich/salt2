create_directories:
  file.directory:
    - names:
        - /mnt/gfs2/tmp/nginx_cache
        - /mnt/gfs2/WP/wordpress
        - /mnt/gfs2/PHP/php/session
        - /mnt/gfs2/PHP/php/wsdlcache
        - /mnt/gfs2/PHP/php-fpm
        - /etc/php-fpm.d
    - user: www-data
    - group: www-data
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - recurse:
        - user
        - group
        - mode
