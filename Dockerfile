# Use Ubuntu as the base image
FROM ubuntu:latest

# Install dependencies
RUN apt-get update && \
    apt-get install -y wget tar

# Download and extract LunarDB
RUN wget -O lunardb.tar.gz "https://github.com/Kazooki123/LunarDB/archive/refs/tags/v0.1.6.tar.gz" && \
    tar -xzf lunardb.tar.gz -C /usr/local/bin --strip-components=1 && \
    rm lunardb.tar.gz

# Set the entrypoint to LunarDB
ENTRYPOINT ["lunar"]