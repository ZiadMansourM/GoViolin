FROM --platform=$BUILDPLATFORM golang:1.21.5 AS builder

WORKDIR /app

COPY go.mod go.sum /app/

RUN go mod download

COPY . .

ARG TARGETOS TARGETARCH

RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o main

FROM --platform=$TARGETPLATFORM scratch
WORKDIR /app
COPY --from=builder /app/ /app/

EXPOSE 8080

# Add tags for docker/metadata-action
LABEL org.opencontainers.image.tags="v0.0.1,latest"
LABEL org.opencontainers.image.authors="ziadmansour.4.9.2000@gmail.com"

CMD ["/app/main"]
