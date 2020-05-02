# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import k3s with context %}
# TODO: make this value configurable via INSTALL_K3S_NAME
{%- set service_name = 'k3s' -%}

# TODO: clean up these paths based on config
{%- set uninstall_script = salt['grains.filter_by']({
  'server': '/usr/local/bin/k3s-uninstall.sh',
  'agent': '/usr/local/bin/k3s-agent-uninstall.sh'
}, grain='k3s-role', default='agent') %}

# k3s-uninstall:
#   cmd.run:
#     - name: '/usr/local/bin/k3s-uninstall.sh'

k3s-uninstall-by-role:
  cmd.run:
    - name: {{ uninstall_script }}
