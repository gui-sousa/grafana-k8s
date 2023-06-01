FROM grafana/grafana:latest

RUN echo test

ENTRYPOINT ["/run.sh"]