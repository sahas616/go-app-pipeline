FROM golang:1.22.5 AS buildstage
WORKDIR /app
COPY . .
RUN go mod download
RUN go build -o main .

FROM gcr.io/distroless/base
WORKDIR /app
COPY --from=buildstage /app/main .
COPY --from=buildstage /app/static ./static
EXPOSE 8080
CMD [ "./main" ]