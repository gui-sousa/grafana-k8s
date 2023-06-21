FROM grafana/grafana:latest

ENV GF_INSTALL_PLUGINS: alexanderzobnin-zabbix-app
ENV GF_PLUGINS_ENABLE_ALPHA=true
ENV GF_PLUGINS_PLUGIN_ADMIN_ENABLED=false
#RUN grafana-cli --pluginsDir "/var/lib/grafana/plugins" plugins install $GF_INSTALL_PLUGINS

#EXPOSE 3000

COPY apps.yaml /etc/grafana/provisioning/plugins/

ENTRYPOINT [ "/run.sh" ]
# Comando de inicialização do Grafana Server
#CMD ["/usr/sbin/grafana-server", "--config=/etc/grafana/grafana.ini", "--homepath=/usr/share/grafana"]
