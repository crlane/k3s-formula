# -*- coding: utf-8 -*-
# vim: ft=sls
{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import k3s with context %}

{%- set quickstart = salt['pillar.get']('k3s:install:quickstart:enabled', k3s['install']['quickstart']['enabled']) %}
{%- set version = salt['pillar.get']('k3s:version') %}

{%- set use_docker = salt['pillar.get']('k3s:server:agent:runtime:use_docker', False) %}

{% if quickstart %}
{%- set url = pillar.get('k3s:quickstart:install:download_url', k3s['install']['quickstart']['download_url']) %}
{%- set options = pillar.get('k3s:install:quickstart:options', k3s['install']['quickstart']['options']) %}
quickstart.download:
  file.managed:
    - name: /tmp/k3s_install.sh
    - source: {{ url }}

quickstart.install:
  cmd.run:
    - name: /tmp/k3s_install.sh
    {% for k, v in options.items() -%}
    {% if loop.first -%}
    - env:
    {%- endif %}
      - {{k}}: {{v}}
    {%- endfor %}
 {% endif %}
