FROM grafana/grafana:latest

RUN grafana-cli --pluginsDir /grafana-plugins plugins install alexanderzobnin-zabbix-app

#ENTRYPOINT ["/run.sh"]
CMD ["grafana-server", "--config=/etc/grafana/grafana.ini"]