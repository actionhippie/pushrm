FROM alpine:3.14 as build

# renovate: datasource=github-releases depName=christian-korneck/docker-pushrm
ENV PUSHRM_VERSION="1.8.0"

ARG TARGETARCH

RUN apk add -U curl bash && \
    curl -sSLo /tmp/docker-pushrm https://github.com/christian-korneck/docker-pushrm/releases/download/v${PUSHRM_VERSION}/docker-pushrm_linux_${TARGETARCH} && \
    chmod 755 /tmp/docker-pushrm

FROM alpine:3.14

ENTRYPOINT ["/usr/local/bin/entrypoint"]
COPY overlay /

COPY --from=build /tmp/docker-pushrm /usr/bin/docker-pushrm
