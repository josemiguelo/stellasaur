FROM busybox AS ctx

COPY build_files /

COPY services/*.service /usr/lib/systemd/user/
COPY ujust/60-custom.just /usr/share/ublue-os/just/60-custom.just
RUN chmod +x /*.sh

FROM ghcr.io/ublue-os/bluefin-dx-nvidia-open:stable

## Make /opt immutable and be able to be used by the package manager.
RUN rm /opt && mkdir /opt

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/00_build.sh

## Verify if final image and contents are correct.
RUN bootc container lint
