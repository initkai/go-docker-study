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
		fmt.Println("Error", err)
	}
}
