FROM docker.io/library/alpine:latest@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf

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

CMD [ "rsync", "-uhavz", "--delete-after", "-e", "ssh -i /secrets/ssh-privatekey", "-M--fake-super", "--exclude-from=/excludes", "/data/", "zh6484@zh6484.rsync.net:cluster-data" ]
