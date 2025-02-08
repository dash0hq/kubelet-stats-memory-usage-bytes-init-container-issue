FROM alpine:3.21.2
COPY copy-files.sh /

RUN mkdir -p /init-container-files
RUN head -c 104857600 </dev/urandom > /init-container-files/large_file

WORKDIR /
CMD ["/copy-files.sh"]
