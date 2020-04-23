# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.service.clean' %}
{%- from tplroot ~ "/map.jinja" import k3s with context %}

include:
  - {{ sls_service_clean }}

k3s-config-clean-file-absent:
  file.absent:
    - name: {{ k3s.config }}
    - require:
      - sls: {{ sls_service_clean }}
