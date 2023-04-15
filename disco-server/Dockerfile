# FROM ubuntu:latest

# RUN apt-get update && \
#     apt-get install -y nginx ffmpeg && \
#     rm -rf /var/lib/apt/lists/*

# COPY nginx.conf /etc/nginx/nginx.conf

# COPY dist /usr/share/nginx/html/disco-app

# RUN mkdir /usr/share/nginx/html/hls

# # Add shell script to run ffmpeg in a loop
# COPY run_ffmpeg.sh /run_ffmpeg.sh
# RUN chmod +x /run_ffmpeg.sh

# EXPOSE 1935
# EXPOSE 8080

# CMD ["/bin/bash", "-c", "/run_ffmpeg.sh & nginx -g 'daemon off;'"]

# ---

# Stage 1 - Build nginx with RTMP module
# FROM ubuntu:latest AS builder

# # Update packages and install dependencies
# RUN apt-get update && apt-get install -y wget build-essential libpcre3 libpcre3-dev libssl-dev zlib1g-dev

# # Download the nginx-rtmp module source
# RUN wget https://github.com/arut/nginx-rtmp-module/archive/master.zip && unzip master.zip

# # Download the nginx source code
# RUN wget http://nginx.org/download/nginx-1.20.0.tar.gz && tar -zxvf nginx-1.20.0.tar.gz

# # Build nginx with the RTMP module
# RUN cd nginx-1.20.0 && ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-master && make && make install

# # Cleanup
# RUN rm -rf nginx-1.20.0.tar.gz nginx-rtmp-module-master.zip nginx-1.20.0 nginx-rtmp-module-master

# # Stage 2 - Build final image with nginx and the app
# FROM ubuntu:latest

# # Install nginx
# RUN apt-get update && apt-get install -y nginx

# # Create HSL directory
# # RUN mkdir -p /var/hls

# # Copy the nginx configuration file
# COPY nginx.conf /etc/nginx/nginx.conf

# # Copy the app
# # COPY disco-app /usr/share/nginx/html

# # Copy the run_ffmpeg script
# # COPY run_ffmpeg.sh /usr/bin/run_ffmpeg.sh
# # RUN chmod +x /usr/bin/run_ffmpeg.sh

# # Install supervisor and copy configuration files
# # RUN apt-get update && apt-get install -y supervisor
# # COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# # Expose ports for RTMP and HTTP
# EXPOSE 1935
# EXPOSE 8080

# # Start supervisord
# CMD ["/bin/bash", "-c", "nginx -g 'daemon off;'"]

# ---

# Start with the official nginx image
FROM nginx

# Update packages and install dependencies
RUN apt-get update && apt-get install -y wget build-essential libpcre3 libpcre3-dev libssl-dev zlib1g-dev ffmpeg

# Download the nginx-rtmp module source
RUN wget https://github.com/arut/nginx-rtmp-module/archive/master.tar.gz && tar -zxvf master.tar.gz

# Download the nginx source code
RUN wget http://nginx.org/download/nginx-1.20.0.tar.gz && tar -zxvf nginx-1.20.0.tar.gz

# Build nginx with the RTMP module
RUN cd nginx-1.20.0 && ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-master && make && make install

# Copy the nginx configuration file
COPY nginx.conf /usr/local/nginx/conf/nginx.conf

# Copy the run_ffmpeg.sh script and make it executable
# COPY run_ffmpeg.sh /usr/local/bin/
# RUN chmod +x /usr/local/bin/run_ffmpeg.sh

# Create HSL directory
RUN mkdir -p /var/hls/live

# Remove unnecessary files and clean up
RUN rm -rf /var/lib/apt/lists/* && rm -rf nginx-1.20.0 && rm -rf nginx-1.20.0.tar.gz && rm -rf master.tar.gz

COPY dist /usr/local/nginx/html

# Expose ports for RTMP and HTTP
EXPOSE 1935
EXPOSE 8080

# Start nginx
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
