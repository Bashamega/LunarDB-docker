# Use Ubuntu as the base image
FROM ubuntu:24.10

# Install dependencies, including Lua 5.4
RUN apt-get update && \
    apt-get install -y wget tar lua5.4 liblua5.4-0

# Download and extract LunarDB based on the specified version
RUN wget -O lunardb.tar.gz "https://github.com/Kazooki123/LunarDB/archive/refs/tags/v0.1.6.tar.gz" && \
    tar -xzf lunardb.tar.gz -C /usr/local/bin --strip-components=2 && \
    rm lunardb.tar.gz && \
    chmod +x /usr/local/bin/lunar && \
    ls -l /usr/local/bin

# Set the entrypoint to LunarDB
ENTRYPOINT ["/usr/local/bin/lunar"]