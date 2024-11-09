# Use Ubuntu as the base image
FROM ubuntu:24.10

# Install dependencies
RUN apt-get update && \
    apt-get install -y wget tar

# Download and list the contents of the tarball to verify structure
RUN wget -O lunardb.tar.gz "https://github.com/Kazooki123/LunarDB/archive/refs/tags/v0.1.6.tar.gz" && \
    tar -tzf lunardb.tar.gz

# Extract LunarDB and make sure the lunar binary is executable
RUN tar -xzf lunardb.tar.gz -C /usr/local/bin --strip-components=2 && \
    rm lunardb.tar.gz && \
    chmod +x /usr/local/bin/lunar && \
    ls -l /usr/local/bin

# Set the entrypoint to LunarDB
ENTRYPOINT ["/usr/local/bin/lunar"]