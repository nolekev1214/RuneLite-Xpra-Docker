# Docker image for Xpra Runelite Client

This docker images allows for hosting a website running the RuneLite client.

The `make build` command turns the Dockerfile into a dockerimage titled "xpra-html5"
The `make run` command launches a detached Docker container with port 10000 exposed to port 80 locally. This allows for connection to the Xpra Webclient with the address using localhost.
