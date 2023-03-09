FROM golang:1.14.6

WORKDIR /go
RUN go get -v github.com/labstack/echo/... \
  && go get -v github.com/pilu/fresh

# Downloading Go Modules
COPY . /app
WORKDIR /app
ENV GO111MODULE=on
# RUN go mod download

EXPOSE 8080
