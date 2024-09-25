# Build stage
FROM rust:1.72-alpine as builder

# Install build dependencies
RUN apk add --no-cache musl-dev openssl-dev pkgconfig

WORKDIR /usr/src/app

# Copy the entire project
COPY . .

# Build the application
RUN cargo build --release

# Runtime stage
FROM alpine:3.18

# Install runtime dependencies
RUN apk add --no-cache libgcc curl

# Create a non-root user
RUN addgroup -S myapp && adduser -S myapp -G myapp

# Copy the binary from the build stage
COPY --from=builder /usr/src/app/target/release/zero2prod /usr/local/bin/zero2prod

# Expose the port the app runs on
EXPOSE 8000

# Switch to non-root user
USER myapp

# Run the binary
CMD ["RustO11y"]