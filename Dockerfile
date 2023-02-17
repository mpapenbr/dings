# This file is used by goreleaser
FROM scratch
ENTRYPOINT ["/dings"]
COPY dings /
