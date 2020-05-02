# -*- coding: utf-8 -*-
# vim: ft=sls
{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import k3s with context %}

{%- set use_docker = salt['pillar.get']('k3s:server:agent:runtime:use_docker', False) %}
{%- set url = pillar.get('k3s:quickstart:download_url', k3s['quickstart']['download_url']) %}
{%- set options = pillar.get('k3s:quickstart:options', k3s['quickstart']['options']) %}
{%- set role = salt['grains.get']('k3s-role', default='agent') %}
{%- set args = pillar['k3s'][role]['args'] %}

quickstart.download:
  file.managed:
    - name: /tmp/k3s_install.sh
    - source: {{ url }}
    - mode: 744
    - skip_verify: true

quickstart.install:
  cmd.run:
    - name: /tmp/k3s_install.sh {{ args | join(' ') }}
    {% for k, v in options.items() -%}
    {% if loop.first -%}
    - env:
    {%- if role == 'agent' %}
      - INSTALL_K3S_EXEC: 'agent'
    {%- endif %}
    {%- endif %}
      - {{k}}: {{v}}
    {%- endfor %}
