FROM eugenmayer/unison:2.51.3-4.12.0-AMD64 as unison

FROM alpine:3
LABEL maintainer="maximilian@schmailzl.net"

RUN apk add --no-cache bash

COPY --from=unison /usr/local/bin/unison /usr/local/bin/unison
COPY --from=unison /usr/local/bin/unison-fsmonitor /usr/local/bin/unison-fsmonitor

ENV HOME="/root" \
    UNISON_USER="root" \
    UNISON_GROUP="root" \
    UNISON_UID="0" \
    UNISON_GID="0"

# Copy the bg-sync script into the container.
COPY sync.sh /usr/local/bin/bg-sync
RUN chmod +x /usr/local/bin/bg-sync

CMD ["bg-sync"]
