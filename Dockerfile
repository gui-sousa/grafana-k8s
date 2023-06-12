FROM grafana/grafana:latest

ENV GF_INSTALL_PLUGINS=alexanderzobnin-zabbix-app

#EXPOSE 3000

# Comando de inicialização do Grafana Server
CMD ["/usr/sbin/grafana-server", "--config=/etc/grafana/grafana.ini", "--homepath=/usr/share/grafana"]
