FROM oraclelinux:9-slim

USER root

RUN microdnf install -y yum \
&& yum install -y https://dl.grafana.com/enterprise/release/grafana-enterprise-9.5.3-1.x86_64.rpm \
&& grafana-cli --pluginsDir "/data/grafana/plugins" plugins install alexanderzobnin-zabbix-app

# Configuração do serviço e reinício do Grafana Server
#RUN systemctl enable grafana-server.service
#&& systemctl stop grafana-server.service \
#&& systemctl start grafana-server.service

# Porta exposta para acessar o Grafana
EXPOSE 3000

# Comando de inicialização do Grafana Server
CMD ["/usr/sbin/grafana-server", "--config=/etc/grafana/grafana.ini", "--homepath=/usr/share/grafana"]
