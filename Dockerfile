# Use an old, potentially vulnerable base image
FROM ubuntu:18.04

# DANGEROUS: Running as the root user by default is a security risk.
# If an attacker compromises the container, they have root privileges inside it.
USER root

WORKDIR /app

# DANGEROUS: Copying secrets directly into the image.
# The secret file will be stored in a layer of the container image, making it accessible.
COPY secrets.txt /app/secrets.txt

# DANGEROUS: Using curl to download and pipe directly to bash is risky.
# If the download URL is compromised, malicious code can be executed.
RUN apt-get update && apt-get install -y curl && \
    curl -sSL https://example.com/install.sh | bash

COPY . .

CMD ["./start-app.sh"]
