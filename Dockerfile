FROM oraclelinux:9-slim

USER root

RUN microdnf install -y wget \
&& wget -q -O grafana.rpm https://dl.grafana.com/oss/release/grafana-8.2.2-1.x86_64.rpm \
&& microdnf install -y grafana.rpm && \
&& rm grafana.rpm \
&& grafana-cli plugins install alexanderzobnin-zabbix-app

# Configuração do serviço e reinício do Grafana Server
RUN systemctl enable grafana-server.service \
&& systemctl stop grafana-server.service \
&& systemctl start grafana-server.service

# Porta exposta para acessar o Grafana
EXPOSE 3000

# Comando de inicialização do Grafana Server
CMD ["/usr/sbin/grafana-server", "--config=/etc/grafana/grafana.ini", "--homepath=/usr/share/grafana"]
