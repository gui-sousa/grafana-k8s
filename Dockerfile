FROM grafana/grafana:latest

ENV GF_INSTALL_PLUGINS=alexanderzobnin-zabbix-app
RUN grafana-cli --pluginsDir "/var/lib/grafana/plugins" plugins install $GF_INSTALL_PLUGINS

#EXPOSE 3000

# Comando de inicialização do Grafana Server
CMD ["/usr/sbin/grafana-server", "--config=/etc/grafana/grafana.ini", "--homepath=/usr/share/grafana"]
