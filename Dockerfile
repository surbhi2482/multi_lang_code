# Vulnerable Dockerfile with multiple security issues

FROM ubuntu:latest

# Vulnerable: Running as root (no USER directive)
# Vulnerable: Using latest tag

# Hard-coded credentials
ENV DB_PASSWORD=admin123 \
    API_KEY=sk_live_abc123xyz789 \
    SECRET_TOKEN=ghp_abc123xyz789 \
    AWS_ACCESS_KEY=AKIAIOSFODNN7EXAMPLE \
    AWS_SECRET_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

# Vulnerable: Not using specific package versions
RUN apt-get update && \
    apt-get install -y curl wget git

# Vulnerable: Downloading and executing script from internet
RUN curl -fsSL https://get.docker.com | sh

# Vulnerable: Exposing sensitive directories
VOLUME /etc
VOLUME /root

# Vulnerable: World-writable directory
RUN mkdir /data && chmod 777 /data

# Vulnerable: Exposing all ports
EXPOSE 1-65535

# Vulnerable: Storing secrets in image layers
RUN echo "admin123" > /app/password.txt
RUN echo "sk_live_abc123xyz789" > /app/api_key.txt

# Vulnerable: Using ADD instead of COPY for URLs
ADD https://example.com/config.json /app/config.json

# Vulnerable: Installing unnecessary packages
RUN apt-get install -y netcat telnet

# Vulnerable: No health check
# HEALTHCHECK is missing

# Vulnerable: Running shell commands with user input
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["echo Starting application with credentials: $DB_PASSWORD"]
