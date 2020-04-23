# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import k3s with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

k3s-config-file-file-managed:
  file.managed:
    - name: {{ k3s.config }}
    - source: {{ files_switch(['example.tmpl'],
                              lookup='k3s-config-file-file-managed'
                 )
              }}
    - mode: 644
    - user: root
    - group: {{ k3s.rootgroup }}
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        k3s: {{ k3s | json }}
