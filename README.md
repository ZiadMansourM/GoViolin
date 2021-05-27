# GoViolin

[GoViolin](https://github.com/Rosalita/GoViolin) is a web app written in Go that helps with violin practice.

Currently hosted on Heroku at https://go-violin.herokuapp.com/

GoViolin allows practice over both 1 and 2 octaves.

Contains:
* Major Scales
* Harmonic and Melodic Minor scales
* Arpeggios
* A set of two part scale duet melodies by Franz Wohlfahrt

# Tasks
- [X] How to build a Go application locally
- [X] How to dockerize a Go app properly 
- [X] Optmize Image
- [X] Build and Test Jenkins PipLine 
- [ ] Make Sure you followed industry best practices 

## How to build a Go application locally 🛠

After, a some searching I found a useful [article](https://www.digitalocean.com/community/tutorials/how-to-build-and-install-go-programs). But, you can run:
```bash
go build -o server.o .
```

## How to dockerize a Go app properly 🐳

Questions ?
- Which base image shall I use ?

  > Found golang:1.16-alpine3.13 a good choice recommended in many articles.

- What are the dependencies that needs to exist on the image ?
  
  > No external but only the necessary folders

I started with this:

```docker
FROM golang:1.16-alpine3.13
RUN mkdir /go/src/app
ADD . /go/src/app
WORKDIR /go/src/app
RUN go build -o server.o .

EXPOSE 8080

CMD ["./server.o"]
```

FeedBack:
> Size were 453 MB 🚩

## Optmize Image ⚡

I found this amazing [video](https://www.youtube.com/watch?v=KLOdisHW8rQ) Discussing the problem I noticed in the previous step.

So Modified the Dockerfile to be:
```docker
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
```

FeedBack:
> Went from 453 MB to 110 MB ✔

## Build and Test Jenkins PipLine
Steps:
- [X] Build Image
- [X] Push to docker Hub 
- [X] Report
