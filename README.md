# Kalitainer

Containerized Kali-Linux with a desktop environment, vnc and no-vnc.

## Usage

````bash
docker run -it \
	-p 127.0.0.1:5900:5900 -p 127.0.0.1:6080:6080 \
	-e RESOLUTION="1280x800x24" \
	-e PASSWORD="password" \
	-v /mounted-home:/home/kali \
	wowmuchname/kalitainer-kde
````

Point your VNC viewer to `localhost:5900` or navigate your browser to `localhost:6080`. Note that either way the connection is **unencrypted**. If you work with kalitainer over a public network it should be run behind a reverse-proxy supporting websockets or be used through an ssh-tunnel.

### Environment-Variables

| Variable      | Description                                                  |
| ------------- | ------------------------------------------------------------ |
| RESOLUTION    | Resolution of the desktop. Defaults to `1280x800x24`         |
| PASSWORD      | If set the password of the user `kali` is reset to the supplied value. If not any previously existing password is retained. |
| PASSWORD_FILE | Obtains `PASSWORD` from the specified file. Primarily for used with docker's secret api. |
| USER          | The services required for this container to work (Desktop, VNC etc.) are orchestrated by the `s6` process-manager. `s6` runs as `root` by default. The services themselves drop privileges and run as the user `kali`. If the `USER` variable is set `s6` can be run as non root also. **This is an experimental setting** and using any value other than `kali` is unlikely to work as it interferes with privilege dropping. Furthermore the `PASSWORD` and `PASSWORD_FILE` variable cannot be used when this is set. |

### Additional information

#### Running as root

The `kali` user is in the `admin` group an can become `root` with sudo.

````bash
sudo su
````

### Privileged mode

To run certain operation the container must be started with the `--privileged` flag. This should be a last resort.

## Images and Tags

| Image                       | Description                                           |
| --------------------------- | ----------------------------------------------------- |
| wowmuchname/kalitainer-base | Kali-Linux + VNC + NoVNC (**No Desktop Environment**) |
| wowmuchname/kalitainer-kde  | Base + KDE                                            |

