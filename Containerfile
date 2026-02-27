FROM busybox AS ctx

# main path scripts
COPY build_files /
RUN chmod +x /*.sh

FROM ghcr.io/ublue-os/bluefin-dx-nvidia-open:stable

## Make /opt immutable and be able to be used by the package manager.
RUN rm /opt && mkdir /opt

# copy files as defined
COPY system_files /
RUN chmod +x /usr/bin/*

# systemd services
COPY services /usr/lib/systemd/user/

# just files
COPY ujust/60-custom.just /usr/share/ublue-os/just/60-custom.just

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/00_build.sh

## Verify if final image and contents are correct.
RUN bootc container lint
