FROM alpine:3

RUN apk add --update --no-cache bash curl git openssh-client && \
  addgroup -g 6697 -S bot && \
  adduser -u 6697 -S bot -G bot && \
  mkdir /etc/bot && \
  chown -R bot:bot /etc/bot && \
  ssh-keyscan -t rsa github.com > /etc/ssh/ssh_known_hosts

COPY bot.sh /etc/bot/

WORKDIR /etc/bot
USER bot

ENTRYPOINT ["/etc/bot/bot.sh"]
CMD ["run", "--log", "debug", "--ssh-key", "/etc/bot/bot_ed25519"]
