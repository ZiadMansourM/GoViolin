ARG GO_VERSION=1.21.5
FROM --platform=$BUILDPLATFORM golang:${GO_VERSION} AS builder

WORKDIR /app

COPY go.mod go.sum /app/

RUN go mod download

COPY . .

ARG TARGETOS TARGETARCH

RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o main

ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    scratchuser

FROM --platform=$TARGETPLATFORM scratch

WORKDIR /app
COPY --from=builder /app/ /app/

COPY --from=builder /etc/passwd /etc/passwd
USER scratchuser

LABEL org.opencontainers.image.tags="ziadmmh/goviolin:v0.0.2"
LABEL org.opencontainers.image.authors="ziadmansour.4.9.2000@gmail.com"

EXPOSE 8080

CMD ["/app/main"]
