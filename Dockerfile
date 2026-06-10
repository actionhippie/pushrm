FROM alpine:3.24@sha256:a2d49ea686c2adfe3c992e47dc3b5e7fa6e6b5055609400dc2acaeb241c829f4 AS build

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
    *) echo >&2 "error: unsupported architecture '${TARGETARCH}'"; exit 1 ;; \
    esac && \
    chmod 755 /tmp/docker-pushrm

FROM alpine:3.24@sha256:a2d49ea686c2adfe3c992e47dc3b5e7fa6e6b5055609400dc2acaeb241c829f4

RUN apk add --no-cache bash
ENTRYPOINT ["/usr/local/bin/entrypoint"]
COPY overlay /

COPY --from=build /tmp/docker-pushrm /usr/bin/docker-pushrm
