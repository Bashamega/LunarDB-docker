# Use Ubuntu as the base image
FROM ubuntu:24.10

# Install dependencies, including Lua, Node.js, and wget
RUN apt-get update && \
    apt-get install -y wget tar lua5.4 liblua5.4-0 nodejs npm && \
    rm -rf /var/lib/apt/lists/*

# Create a directory for the LunarDB CLI binary
RUN mkdir -p /usr/local/bin/lunar-cli

# Download and extract LunarDB based on the specified version
RUN wget -O lunardb.tar.gz "https://github.com/Kazooki123/LunarDB/archive/refs/tags/v0.1.6.tar.gz" && \
    tar -xzf lunardb.tar.gz -C /usr/local/bin/lunar-cli --strip-components=1 && \
    rm lunardb.tar.gz

# Set the permissions on the 'lunar' binary if needed
RUN chmod +x /usr/local/bin/lunar-cli/lunar

# Add the lunar binary to the PATH
ENV PATH="/usr/local/bin/lunar-cli:$PATH"

# Create a simple API server to accept requests
WORKDIR /usr/local/bin/lunar-cli

# Copy API server code into the container (create this code separately)
COPY api-server.js .

# Install any required npm packages (like `express`)
RUN npm install express lunardb-js-sdk

# Expose the port where the server will listen
EXPOSE 3000

# Run the API server when the container starts
CMD ["node", "api-server.js"]