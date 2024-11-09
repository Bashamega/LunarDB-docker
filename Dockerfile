# Use Ubuntu as the base image
FROM ubuntu:latest

# Define build argument for the LunarDB version
ARG LUNAR_VERSION=0.1.6

# Install dependencies
RUN apt-get update && \
    apt-get install -y wget tar

# Download and extract LunarDB based on the specified version
RUN wget -O lunardb.tar.gz "https://github.com/Kazooki123/LunarDB/archive/refs/tags/v${LUNAR_VERSION}.tar.gz" && \
    tar -xzf lunardb.tar.gz -C /usr/local/bin --strip-components=1 && \
    rm lunardb.tar.gz

# Set the entrypoint to LunarDB
ENTRYPOINT ["lunar"]