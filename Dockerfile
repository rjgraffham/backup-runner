FROM docker.io/library/alpine:latest@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6

LABEL org.opencontainers.image.source=https://github.com/rjgraffham/backup-runner
LABEL org.opencontainers.image.description="rsync.net backup runner (alpine + rsync + ssh)"
LABEL org.opencontainers.image.licenses=MIT

RUN apk update && apk add rsync openssh

RUN mkdir -p /secrets
RUN mkdir -p /root/.ssh
RUN chmod go-rwx /root/.ssh
COPY excludes /excludes
COPY known_hosts.preload /root/.ssh/known_hosts
RUN chmod go-rwx /root/.ssh/known_hosts

CMD [ "rsync", "-uhavz", "--delete-after", "-e", "ssh -i /secrets/ssh_key", "-M--fake-super", "--exclude-from=/excludes", "/data/", "zh6484@zh6484.rsync.net:cluster-data" ]
