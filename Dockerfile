# Build Stage
FROM golang:alpine AS build-env
RUN apk --no-cache add build-base git mercurial gcc
RUN go get -u github.com/gorilla/mux && \
    go get -u github.com/jinzhu/gorm 
ADD . /build
RUN cd /build && go build -o hello

# Final Stage
FROM alpine
WORKDIR /app
COPY --from=build-env /build/ /app/
EXPOSE 9000
ENTRYPOINT ./hello


