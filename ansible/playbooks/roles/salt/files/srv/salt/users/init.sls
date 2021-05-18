www-data:
  group.present:
    - gid: ''
  user.present:
    - shell: /bin/bash
    - home: /home/www-data
    - uid: ''
    - gid: ''
    - groups:
         - www-data
