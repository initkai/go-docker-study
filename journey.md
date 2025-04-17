This is a study of writing docker files for go development. 
Starting from naivest approaches to getting better. 


Version 2: Separate addition of go.mod, go.sum and running go.download.. then separately copy code  


touch main.go 


package main

import (
	"fmt"
	"github.com/gorilla/mux"
	"net/http"
)

func main() {
	// Create a new router
	r := mux.NewRouter()

	// Define a simple route
	r.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Hello, Docker World with Gorilla Mux!")
	})

	// Start the HTTP server
	fmt.Println("Server is running on port 8080")
	err := http.ListenAndServe(":8080", r)
	if err != nil {
		fmt.Println("Error starting server:", err)
	}
}



touch Dockerfile 

# Stage 1: Build the Go binary
FROM golang:1.22 AS builder

WORKDIR /app

# Copy go.mod and go.sum files first to leverage Docker caching
COPY go.mod go.sum ./

# Download dependencies first (avoids re-downloading on every build)
RUN go mod download

# Clean up go.mod and go.sum (optional step, can be omitted if you are confident)
<!-- RUN go mod tidy can be run with a removal container when the need is felt --> 

COPY . .

# Build the Go binary
RUN go build -o app .

# Stage 2: Final image with the binary
FROM debian:bullseye-slim

WORKDIR /root/

COPY --from=builder /app/app .

EXPOSE 8080

CMD ["./app"]



sudo docker run -v$(pwd):/app -w /app golang:1.22 go get -u github.com/gorilla/mux
go: downloading github.com/gorilla/mux v1.8.1


sudo docker build -t go-server . 

sudo docker run -p 8080:8080 go-server 

curl http://localhost:8080/
