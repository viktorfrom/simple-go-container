FROM golang:latest as builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download 
COPY . ./
RUN go build -o main .
#EXPOSE 8080
#ENTRYPOINT [ "./main" ]

# Decrease image size
FROM gcr.io/distroless/base-debian11
COPY --from=builder /app/main . 
EXPOSE 8080
CMD ["/main"]



