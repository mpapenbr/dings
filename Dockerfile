# This file is used by goreleaser
ARG BUILDPLATFORM
FROM --platform=$BUILDPLATFORM alpine:3.22

ARG TARGETPLATFORM


ENTRYPOINT ["/dings"]
HEALTHCHECK --interval=2s --timeout=2s --start-period=5s --retries=3 CMD [ "/thc" ]
RUN apk add --no-cache ca-certificates
COPY $TARGETPLATFORM/dings /
COPY ext/healthcheck/$TARGETPLATFORM/thc /thc


# in case we need to add the grpc healthcheck
# COPY ext/healthcheck/$TARGETPLATFORM/grpc_health_probe /grpc_health_probe
