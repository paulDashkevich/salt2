# Задание: salt - Управление конфигурацией на несколько серверов
## Цель: настроить формирование конфигурацией проекта через salt. Добавить в проект salt server добавить на конечные ноды миньоны солта настроить управление конфигурацией nginx и iptables.
> Выполнение работы:
>> Принято решение использовать Salt для развёртывания ролей nginx, php-fpm и firewalld вместо Ansible.
Изначально через terraform и Ansible разворачивается стенд для 5 ВМ (nginx-front(proxy), iscsi(target+client), pacemaker, keepalived, quorum-device, mysql)
После проигрывания playbook Ansible заходим на ноду iscsi, которая выполняет роль уже настроенного Salt-master'a и вводим следующую команду, которая на управляемых мастером нодах развернёт согласно state sls-сам нужные роли и настройки
```
salt '*' state.apply
```
Вывод успешно выполненной задачи примерно будет таков:
```
----------
          ID: /mnt/gfs2/WP/wordpress/wp-config.php
    Function: file.managed
      Result: True
     Comment: File /mnt/gfs2/WP/wordpress/wp-config.php is in the correct state
     Started: 11:36:18.734147
    Duration: 23.789 ms
     Changes:
----------
          ID: firewalld
    Function: pkg.installed
      Result: True
     Comment: The following packages were installed/updated: firewalld
     Started: 11:36:18.794372
    Duration: 29676.274 ms
     Changes:
              ----------
              ebtables:
                  ----------
                  new:
                      2.0.10-16.el7
                  old:
              firewalld:
                  ----------
                  new:
                      0.6.3-13.el7_9
                  old:
              ipset:
                  ----------
                  new:
                      7.1-1.el7
                  old:
              python-firewall:
                  ----------
                  new:
                      0.6.3-13.el7_9
                  old:
              python-slip:
                  ----------
                  new:
                      0.4.0-4.el7
                  old:
              python-slip-dbus:
                  ----------
                  new:
                      0.4.0-4.el7
                  old:
----------
          ID: firewalld
    Function: service.running
      Result: True
     Comment: Service firewalld is already enabled, and is running
     Started: 11:36:48.487207
    Duration: 447.699 ms
     Changes:
              ----------
              firewalld:
                  True
----------
          ID: firewalld
    Function: firewalld.present
        Name: public
      Result: True
     Comment: 'public' was configured.
     Started: 11:36:48.937991
    Duration: 8569.757 ms
     Changes:
              ----------
              masquerade:
                  ----------
                  new:
                      Masquerading successfully set.
                  old:
              ports:
                  ----------
                  new:
                      - 8083/tcp
                      - 9929/udp
                      - 4505/tcp
                      - 2224/tcp
                      - 5406/udp
                      - 3124/tcp
                      - 860/tcp
                      - 4506/tcp
                      - 5404/udp
                      - 5403/tcp
                      - 443/tcp
                      - 21064/tcp
                      - 3260/tcp
                      - 5405/udp
                      - 9929/tcp
                      - 80/tcp
                  old:
----------
          ID: reload_firewalld
    Function: cmd.run
        Name: firewall-cmd --reload
      Result: True
     Comment: Command "firewall-cmd --reload" run
     Started: 11:36:57.511632
    Duration: 579.321 ms
     Changes:
              ----------
              pid:
                  18223
              retcode:
                  0
              stderr:
              stdout:
                  success

Summary for web0
-------------
Succeeded: 36 (changed=27)
Failed:     0
-------------
Total states run:     36
Total run time:  694.437 s

```
После работы миньонов необходимо перезагрузить ноду proxy или просто службу nginx, так как после раскатки роли с firewalld обрываются все подключения.
Страничка с выбором языка и началом установки Wordpress будет находится по адресу, который выводит outputs terraform в блоке **reversedns
```
Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

external_ip_address = [
  "185.177.92.197",
  "185.177.93.26",
  "185.177.92.211",
  "185.177.92.5",
  "185.177.92.234",
]
internal_ip0 = [
  "10.1.0.10",
  "10.1.0.11",
  "10.1.0.12",
  "10.1.0.13",
  "10.1.0.14",
]
internal_ip2 = [
  "10.1.1.10",
  "10.1.1.11",
  "10.1.1.12",
]
reversedns = [
  "ip-185-177-92-5.ah-server.com",
```
Задание выполнено.
