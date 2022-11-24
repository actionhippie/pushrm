FROM alpine:3.17 as build

# renovate: datasource=github-releases depName=christian-korneck/docker-pushrm
ENV PUSHRM_VERSION=1.9.0

ARG TARGETARCH

RUN apk add --no-cache curl && \
    case "${TARGETARCH}" in \
    'amd64') \
        curl -sSLo /tmp/docker-pushrm https://github.com/christian-korneck/docker-pushrm/releases/download/v${PUSHRM_VERSION}/docker-pushrm_linux_amd64; \
        ;; \
    'arm64') \
        curl -sSLo /tmp/docker-pushrm https://github.com/christian-korneck/docker-pushrm/releases/download/v${PUSHRM_VERSION}/docker-pushrm_linux_arm64; \
        ;; \
    'arm') \
        curl -sSLo /tmp/docker-pushrm https://github.com/christian-korneck/docker-pushrm/releases/download/v${PUSHRM_VERSION}/docker-pushrm_linux_arm; \
        ;; \
    *) echo >&2 "error: unsupported architecture '${TARGETARCH}'"; exit 1 ;; \
    esac && \
    chmod 755 /tmp/docker-pushrm

FROM alpine:3.17

RUN apk add --no-cache bash
ENTRYPOINT ["/usr/local/bin/entrypoint"]
COPY overlay /

COPY --from=build /tmp/docker-pushrm /usr/bin/docker-pushrm
