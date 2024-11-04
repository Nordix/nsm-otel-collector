ARG OTEL_VERSION=0.88.0

FROM golang:1.22-alpine3.20 as ocb
RUN set -ex && \
    apk --update add git wget
ENV GO111MODULE=on
RUN go install go.opentelemetry.io/collector/cmd/builder@v0.111.0
WORKDIR /gen
ARG COC_VERSION
COPY ./otel-collector-builder.yaml /gen/otel-collector-builder.yaml
ARG OTEL_VERSION
RUN sed -i -e 's/OTEL_VERSION/'${OTEL_VERSION}'/' otel-collector-builder.yaml
CMD builder --skip-compilation --config=otel-collector-builder.yaml
