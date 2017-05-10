Ansible role: SELinux
=========

Configures `Security-Enhanced Linux`

Requirements
------------

None.

Role Variables
--------------

    selinux_mode: disabled

Dependencies
------------

None.

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: shomatan.selinux }

License
-------

MIT

Author Information
------------------

Shoma Nishitateno