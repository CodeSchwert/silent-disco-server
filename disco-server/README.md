# RTMP to HLS Streaming Server

This is a Docker container that runs an NGINX server with RTMP and HLS streaming capabilities. It allows RTMP streamers to output their streams to the server, which can then generate HLS files on the fly for playback on web and mobile devices.

## Building the Docker Container

To build the Docker container, first make sure that Docker is installed on your system. Then run the following command from the root of the project directory:

```bash
docker build -t disco-server .
```

This will build the Docker image and tag it as disco-server.

## Starting the Docker Container

To start the Docker container, run the following command:

```bash
docker run -d --name disco-server -p 1935:1935 -p 8080:80 -m 4g -v /path/to/config:/etc/nginx/nginx.conf -v /path/to/hls:/usr/share/nginx/html/hls disco-server
```

Replace `/path/to/config` with the path to your `nginx.conf` file and `/path/to/hls` with the path to your HLS output directory. This command will start the container in detached mode, name it `disco-server`, map port 1935 to the RTMP input port, map port 8080 to the HTTP output port, and mount the `nginx.conf` file and HLS output directory as volumes.

## Streaming to the Server

To stream to the server, use an RTMP streaming client such as OBS or FFmpeg, and configure it to output to `rtmp://<server-ip>:1935/live/<stream-key>`. Replace `<server-ip>` with the IP address of your server and `<stream-key>` with a unique stream key that you choose. The stream key will be used as the name of the HLS output directory.

## Connecting to the HLS Output

To connect to the HLS output, open a web browser and navigate to `http://<server-ip>:8080/hls/<stream-key>/output.m3u8`. This will play the HLS stream in the browser using a video player.

## Connecting to the RTMP Output

To connect to the RTMP output, use an RTMP player such as VLC or FFmpeg, and configure it to input from `rtmp://<server-ip>:1935/live/<stream-key>`. Replace `<server-ip>` with the IP address of your server and `<stream-key>` with the same stream key that you used when streaming to the server.

That's it! You now have an RTMP to HLS streaming server that can be used for live streaming on the web.
