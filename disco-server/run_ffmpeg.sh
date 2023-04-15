#!/bin/bash

# Start nginx in the background
nginx -g "daemon on;"

# Set the input RTMP stream URL
INPUT_URL="rtmp://localhost:1935/live/test"

# Set the output HLS stream URL
OUTPUT_URL="/tmp/hls/test.m3u8"

# Use FFmpeg to convert the RTMP stream to HLS
ffmpeg -i $INPUT_URL -c:a aac -ac 2 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 5 -hls_list_size 0 -f hls $OUTPUT_URL


# Stop nginx when ffmpeg exits
killall nginx
