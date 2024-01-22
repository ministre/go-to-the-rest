FROM golang:1.21-alpine3.19 AS builder

LABEL stage=gobuilder

ENV CGO_ENABLED 0

ENV GOOS linux

RUN apk update --no-cache && apk add --no-cache tzdata

WORKDIR /build

ADD go.mod .

# ADD go.sum .

RUN go mod download

COPY . .

RUN go build -ldflags="-s -w" -o /app/go-to-the-rest ./main.go

FROM alpine:3.19

RUN apk update --no-cache && apk add --no-cache ca-certificates

COPY --from=builder /usr/share/zoneinfo/Europe/Moscow /usr/share/zoneinfo/Europe/Moscow

ENV TZ Europe/Moscow

WORKDIR /app

COPY --from=builder /app/go-to-the-rest /app/go-to-the-rest

CMD [". /go-to-the-rest"]
