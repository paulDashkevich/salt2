remi-release:
  pkgrepo.managed:
    - source: https://rpms.remirepo.net/enterprise/remi-release-7.rpm
    - baseurl: http://rpms.remirepo.net/enterprise/7/php74/$basearch
    - enabled: true
    - gpgkey: https://rpms.remirepo.net/RPM-GPG-KEY-remi
    - gpgcheck: 1

php-fpm:
  cmd.run:
    - name: yum install -y https://rpms.remirepo.net/enterprise/remi-release-7.rpm
  pkg.installed:
    - version: latest
    - names:
       - php-cli
       - php-common
       - php-devel
       - php-fpm
       - php-mysqlnd
       - php-pdo
       - php-pear
       - php-pecl-mysql
       - php-xml
       - php-gd
       - php-pecl-zip
       - php-mbstring
  service.running:
    - enable: True
    - reload: True
    - restarted: True
    - watch:
       - file: /etc/php-fpm.d/www.conf
       - file: /etc/php-fpm.conf
       - file: /etc/php.ini

files_copy:
  file.managed:
    - user: www-data
    - group: www-data
    - files_mode: 644
    - dirs_mode: 755
    - names:
      - /etc/php-fpm.conf:
        - source: salt://php-fpm/php-fpm.conf
      - /etc/php-fpm.d/www.conf:
        - source: salt://php-fpm/www.conf
      - /etc/php.ini:
        - source: salt://php-fpm/php.ini
