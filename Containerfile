FROM ubuntu:26.04 AS source

ADD --checksum=sha256:0a2704ead7217b7d0014f3fb5d09043dd0a00a41a8da845c7c58d21c8afb03f0 \
    https://github.com/trzy/Supermodel/releases/download/v0.3a-20260726-git-b7d8acd/supermodel-0.3a-20260726-git-b7d8acd-linux.tar.gz \
    /tmp/supermodel.tar.gz

FROM ghcr.io/containerpak/mesa:main

COPY --from=source /tmp/supermodel.tar.gz /tmp/supermodel.tar.gz
COPY supermodel /usr/bin/supermodel
COPY net.retro.supermodel.desktop /usr/share/applications/net.retro.supermodel.desktop

RUN apt update && \
    apt install -y --no-install-recommends libglew2.2 libsdl2-2.0-0 && \
    mkdir -p /opt/supermodel && \
    tar -xzf /tmp/supermodel.tar.gz --strip-components=1 -C /opt/supermodel && \
    chmod 0755 /opt/supermodel/supermodel /usr/bin/supermodel && \
    rm /tmp/supermodel.tar.gz && \
    cpak-clean-junk
