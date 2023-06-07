FROM grafana/grafana:latest

USER root
RUN mkdir -p /var/lib/grafana/plugins && chown -R grafana:grafana /var/lib/grafana/plugins

USER grafana
RUN grafana-cli --pluginsDir /grafana-plugins plugins install alexanderzobnin-zabbix-app

#ENTRYPOINT ["/run.sh"]
CMD ["grafana-server", "--config=/etc/grafana/grafana.ini"]