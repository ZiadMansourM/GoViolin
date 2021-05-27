FROM golang:1.16-alpine3.13 AS builder

RUN mkdir /go/src/app
ADD . /go/src/app
WORKDIR /go/src/app
RUN go build -o server.o .

FROM alpine
WORKDIR /app
COPY --from=builder /go/src/app/ /app/

EXPOSE 8080

CMD ["./server.o"]

# docker build -t ziad-goviolin .
# docker run -p 8080:8080 ziad-goviolin
# docker run -d -p 8080:8080 ziad-goviolin