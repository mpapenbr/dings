# This file is used by goreleaser
ARG BUILDPLATFORM
FROM --platform=$BUILDPLATFORM alpine:3.22
ARG ARCH

ENTRYPOINT ["/dings"]
HEALTHCHECK --interval=2s --timeout=2s --start-period=5s --retries=3 CMD [ "/thc" ]
RUN apk add --no-cache ca-certificates
COPY dings /
COPY ext/healthcheck/thc.$ARCH /thc

# in case we need to add the grpc healthcheck
# COPY ext/healthcheck/grpc_health_probe.$ARCH /grpc_health_probe
