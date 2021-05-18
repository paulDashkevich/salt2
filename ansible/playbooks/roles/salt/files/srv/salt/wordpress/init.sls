/mnt/gfs2/WP/:
    archive.extracted:
      - source: https://wordpress.org/latest.tar.gz
      - source_hash: md5=5493c7abf5317889af2bcd885d352823
      - source_hash_update: True
      - user: www-data
      - group: www-data
      - use_cmd_unzip: True

/mnt/gfs2/WP/wordpress/wp-config.php:
    file.managed:
         - source: salt://wordpress/wp-config.php
         - user: www-data
         - group: www-data
         - mode: 644
