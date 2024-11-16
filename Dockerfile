FROM alpine:latest
LABEL authors="ZKWolf"
COPY run.sh /run.sh
RUN apk add --no-cache bash curl jq
RUN chmod +x /run.sh
CMD ["/run.sh"]