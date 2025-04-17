# Use the official Golang image as a base image
FROM golang:1.22

# Set the working directory inside the container
WORKDIR /app

# Copy the Go source code into the container
COPY . .

# Build the Go application
RUN go build -o server .

# Expose the port the Go app is listening on
EXPOSE 8080

# Run the Go application when the container starts
CMD ["go", "run", "."]
