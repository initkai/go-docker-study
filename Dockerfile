# Stage 1: Build the Go binary
FROM golang:1.22 AS builder

WORKDIR /app

# Copy go.mod and go.sum files first to leverage Docker caching
COPY go.mod go.sum ./

# Download dependencies first (avoids re-downloading on every build)
RUN go mod download

# Clean up go.mod and go.sum (optional step, can be omitted if you are confident)
RUN go mod tidy

COPY . .

# Build the Go binary
RUN go build -o app .

# Stage 2: Final image with the binary
FROM debian:bullseye-slim

WORKDIR /root/

COPY --from=builder /app/app .

EXPOSE 8080

CMD ["./app"]
