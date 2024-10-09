# Step 1: Build the Go application
FROM golang:1.20-alpine AS build
WORKDIR /app
COPY go.mod ./
COPY go.sum ./
RUN go mod download
COPY . ./
RUN go build -o /streaming-app

# Step 2: Set up FFmpeg and other runtime dependencies
FROM alpine:3.18
RUN apk add --no-cache ffmpeg nginx

# Copy over the built Go app
COPY --from=build /streaming-app /usr/local/bin/streaming-app

# Copy Nginx configuration (for RTMP, HLS, etc.)
COPY nginx.conf /etc/nginx/nginx.conf

# Expose necessary ports
EXPOSE 8080 1935 80

# Start both Nginx and the Go application
CMD ["sh", "-c", "nginx && streaming-app"]