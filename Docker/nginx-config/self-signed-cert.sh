#!/bin/bash

# Configuration
CERT_NAME="server"                  # Base name for certificate files (without file extensions)
CERT_DIR="./nginx-config/ssl"                    # Directory to store the certificate files
DAYS_VALID="365"                    # Number of days the certificate is valid

# Ensure the output directory exists
mkdir -p "$CERT_DIR"

# Generate a private key (unencrypted)
openssl genpkey -algorithm RSA -out "$CERT_DIR/$CERT_NAME.key"

# Generate a certificate signing request (CSR)
openssl req -new -key "$CERT_DIR/$CERT_NAME.key" -out "$CERT_DIR/$CERT_NAME.csr"  -subj "/CN=$CERT_NAME"

# Generate a self-signed certificate using the CSR
openssl x509 -req -days "$DAYS_VALID" -in "$CERT_DIR/$CERT_NAME.csr" -signkey "$CERT_DIR/$CERT_NAME.key" -out "$CERT_DIR/$CERT_NAME.crt"

# Optional: Secure the private key (set appropriate file permissions)
chmod 600 "$CERT_DIR/$CERT_NAME.key"

echo "Self-signed certificate '$CERT_NAME.crt' and private key '$CERT_NAME.key' have been created in the '$CERT_DIR' directory."

# Optional: Clean up the CSR file
rm "$CERT_DIR/$CERT_NAME.csr"