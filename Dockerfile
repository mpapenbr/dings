# This file is used by goreleaser
FROM scratch
ARG ARCH

ENTRYPOINT ["/dings"]
HEALTHCHECK --interval=2s --timeout=2s --start-period=5s --retries=3 CMD [ "/thc" ]
COPY dings /
COPY ext/healthcheck/thc.$ARCH /thc
# in case we need to add the grpc healthcheck
# COPY ext/healthcheck/grpc_health_probe.$ARCH /grpc_health_probe
