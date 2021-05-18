nginx:
  pkg:
    - installed
  service:
    - running
    - enable: True
    - restarted: True
    - watch:
      - pkg: nginx
      - file: /etc/nginx/nginx.conf

/etc/nginx/nginx.conf:
  file:
    - managed
    - source: salt://nginx/nginx.conf
    - user: root
    - group: root
    - mode: 644

/var/lib/nginx/tmp:
  file.directory:
    - user: www-data
    - group: www-data
    - makedirs: False
    - recurse:
        - user
        - group
        - mode
