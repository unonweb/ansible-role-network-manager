NOTES
=====

Which user owns the connection?
-------------------------------

I still don't know where NetworkManager or Gnome saves the information which user has created a connection profile. Only that user may edit the connection. Normally this isn't an issue but sometimes NetworkManager asks for the password of WIFI connections that have already been setup. Then an administrator is required to enter it. Therefore I've tried to figure out how to enable normal user to edit the connection by the following means:

a) Add the user to the `permissions:` property of the connection file.
   -> This only seems to control who may use the connection, not edit.

b) Store connection in `~/.config/NetworkManager/`
   -> Gnome / NetworkManager seems to ignore a connection stored there - at least if a system connection with the same name is available

```yml
# add user permissions
- name: Add user permissions to wifi profiles
	become: true
	notify: Reload NetworkManager
	loop: "{{ network_manager_connections_wifi }}"
	loop_control:
	loop_var: connection
	ansible.builtin.lineinfile:
	path: "/etc/NetworkManager/system-connections/{{ connection.name }}.nmconnection"
	line: "permissions={{ connection.permissions }}"
	insertafter: '^\[connection\]$'
	state: present
	create: false
	backup: false
	owner: "root"
	group: "root"
	mode: u=rw,g=,o=
```

SNIPPETS
========

```yml
- name: Set fact primary_eth
  ansible.builtin.set_fact:
    primary_eth: "{{ ansible_facts.interfaces | select('match', '^en|^eth') | list | first }}"
```
