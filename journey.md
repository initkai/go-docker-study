This is a study of writing docker files for go development. 
Starting from naivest approaches to getting better. 


Version 1: Building a simple go server with a naive docker file 


touch main.go 


main.go 

package main

import (
	"fmt"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, world!")
}

func main() {
	http.HandleFunc("/", handler)
	http.ListenAndServe(":8080", nil)
}


touch Dockerfile 

FROM golang:1.22

WORKDIR /app
COPY . .
RUN go run .
EXPOSE 8080
CMD ["go", "run", "."]


sudo docker build -t go-server . 

sudo docker run -p 8080:8080 go-server 

curl http://localhost:8080/
