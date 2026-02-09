FROM scratch AS ctx
COPY build_files /
COPY post-install-checker /post-install-checker
COPY ujust /ujust/

FROM ghcr.io/ublue-os/bluefin-dx-nvidia-open:stable

### [IM]MUTABLE /opt
## Some bootable images, like Fedora, have /opt symlinked to /var/opt, in order to
## make it mutable/writable for users. However, some packages write files to this directory,
## thus its contents might be wiped out when bootc deploys an image, making it troublesome for
## some packages. Eg, google-chrome, docker-desktop.
##
## Uncomment the following line if one desires to make /opt immutable and be able to be used
## by the package manager.
# RUN rm /opt && mkdir /opt

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh

### Custom ujust tasks
COPY --from=ctx /ujust/60-custom.just /usr/share/ublue-os/just/60-custom.just

### Post-install checker (clones repo on first login for ujust do-post-install)
COPY --from=ctx /post-install-checker/post-install-checker.service /usr/lib/systemd/user/post-install-checker.service
RUN systemctl --global enable post-install-checker.service

### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
