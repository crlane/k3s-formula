# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import k3s with context %}

k3s-service-clean-service-dead:
  service.dead:
    - name: {{ k3s.service.name }}
    - enable: False
