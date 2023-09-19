# Use an official Golang runtime as the build stage
FROM golang:1.21.1 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Go application source code into the container
COPY . .

# Build the Go application
RUN make build

# Start a new stage for the final image
# FROM alpine:3.18.3
FROM golang:1.21.1

# Set the working directory inside the container
WORKDIR /app

# Copy the compiled binary from the build stage to the final image
COPY --from=build /app/demo.bin .

# RUN apk update && apk add --no-cache go netcat-openbsd net-tools

# Expose the port on which your Go application listens
EXPOSE 8080

# Set environment variables
ENV DEMO_APP_ADDR="0.0.0.0:8080"
ENV DEMO_REDIS_ADDR="redis:6379"

# Command to run your Go application
CMD ["./demo.bin"]
