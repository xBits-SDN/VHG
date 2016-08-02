dngroup/adapted-video-frontend:
  docker.pulled:
    - tag: latest
    - name: dngroup/adapted-video-frontend


{%- set minealias = salt['pillar.get']('hostsfile:alias', 'network.ip_addrs') %}
{%- set addrs = salt['mine.get']('roles:broker', minealias,"grain") %}
{%- set broker_ip= addrs.items()[0][1][0] %}


{%- set addrs = salt['mine.get']('roles:swift_proxy', minealias,"grain") %}
{%- set swift_proxy_ip= addrs.items()[0][1][0] %}



core-frontend:
  docker.running:
    - image: dngroup/adapted-video-frontend
    - ports:
      - "8080/tcp":
          HostIp: "0.0.0.0"
          HostPort: "5000"  
    - volumes:
      - "/root:/root:ro" 
    - environment:
      - "AMQP_PORT_5672_TCP_ADDR" : "{{ broker_ip }}"
      - "AMQP_PORT_5672_TCP_PORT" : "5672"
      - "STREAMER_URL" : " http://{{ pillar['ips']['Frontend']['Floating_IP'] }}:8080/v1/AUTH_admin/"
      - "SWIFT_URL" : "http://{{ pillar['ips']['Frontend']['data_in'] }}:8080"
      - "TRANSCOD_PARAM_FILE" : "~/transcodeParam.json"
    - require: 
      - docker: dngroup/adapted-video-frontend
