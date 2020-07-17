FROM alpine:3

ENV SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/download/v0.1.9/supercronic-linux-amd64 \
    SUPERCRONIC=supercronic-linux-amd64 \
    SUPERCRONIC_SHA1SUM=5ddf8ea26b56d4a7ff6faecdd8966610d5cb9d85

RUN apk add --update --no-cache bash curl git openssh-client tzdata && \
  addgroup -g 6697 -S bot && \
  adduser -u 6697 -S bot -G bot && \
  mkdir /etc/bot && \
  chown -R bot:bot /etc/bot && \
  curl -fsSLO "$SUPERCRONIC_URL" && \
  echo "$SUPERCRONIC_SHA1SUM  $SUPERCRONIC" | sha1sum -c - && \
  chmod +x "$SUPERCRONIC" && \
  mv "$SUPERCRONIC" "/usr/local/bin/$SUPERCRONIC" && \
  ln -s "/usr/local/bin/$SUPERCRONIC" /usr/local/bin/supercronic && \
  ssh-keyscan -t rsa github.com > /etc/ssh/ssh_known_hosts

COPY bot.sh entrypoint.sh /etc/bot/

WORKDIR /etc/bot
USER bot

ENV TZ=Europe/Stockholm
ENTRYPOINT ["/etc/bot/entrypoint.sh"]
CMD ["0 7 * * *", "run", "--log", "debug", "--ssh-key", "/etc/bot/bot_ed25519"]
