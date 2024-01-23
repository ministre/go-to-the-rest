FROM golang:1.21-alpine3.19 AS builder

LABEL stage=gobuilder

ENV CGO_ENABLED 0

ENV GOOS linux

RUN apk update --no-cache && apk add --no-cache tzdata

WORKDIR /build

ADD go.mod .

# ADD go.sum .

RUN go mod download

ADD main.go .

RUN go build -ldflags="-s -w" -o /app/go-to-the-rest ./main.go

FROM alpine:3.19

RUN apk update --no-cache && apk add --no-cache ca-certificates

COPY --from=builder /usr/share/zoneinfo/Europe/Moscow /usr/share/zoneinfo/Europe/Moscow

ENV TZ Europe/Moscow

WORKDIR /app

COPY --from=builder /app/go-to-the-rest /app/go-to-the-rest

ENV URL=URL
ENV METHOD=METHOD
ENV TOKEN=TOKEN

RUN echo '{' >> /app/config.json && \
    echo '  "url": "$URL",' >> /app/config.json && \
    echo '  "method": "$METHOD",' >> /app/config.json && \
    echo '  "token": "$TOKEN"' >> /app/config.json && \
    echo '}' >> /app/config.json

# CMD [". /go-to-the-rest"]