FROM       ruby:3.0.1-slim-buster
RUN        apt-get update && \
           apt-get install -y --no-install-recommends git=1:2.20.1-2+deb10u3 && \
           groupadd -r ruby_worker && \
           useradd --no-log-init -r -g ruby_worker ruby_worker && \
           rm -rf /var/lib/apt/lists/*
RUN        git clone https://github.com/sawasy/http_server.git /opt/http_server
WORKDIR    /opt/http_server
EXPOSE     80 
USER       ruby_worker
ENTRYPOINT ["ruby", "http_server.rb"]

