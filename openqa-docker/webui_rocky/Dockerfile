FROM openqa_webui

RUN zypper -n install python3 python3-jsonschema
# SSL not needed so disable it
RUN a2disflag SSL
