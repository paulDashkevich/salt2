firewalld:
  pkg.installed:
    - name: firewalld
  service.running:
    - enable: True
    - reload: True
    - restarted: True
    - require:
       - pkg: firewalld
  firewalld.present:
    - name: public
    - default: False
    - masquerade: True
    - ports:
       - 80/tcp
       - 443/tcp
       - 2224/tcp
       - 8083/tcp
       - 21064/tcp
       - 5403/tcp
       - 5404/udp
       - 5405/udp
       - 5406/udp
       - 3124/tcp
       - 9929/udp
       - 9929/tcp
       - 3260/tcp
       - 860/tcp
       - 4505/tcp
       - 4506/tcp

reload_firewalld:
  cmd.run:
    - name: 'firewall-cmd --reload'
    - require:
      - service: firewalld
