# Debian Squeezed

A lightweight script that streamlines a fresh Debian KDE installation by: installing essential packages, removing unnecessary ones and configuring the OS.

### Running the script

```sh
sudo apt update
sudo apt install curl -y
bash <(curl -fsS https://raw.githubusercontent.com/HHACarvalho/debian-squeezed/refs/heads/main/setup.sh)
```

### Downloading the script

```sh
sudo apt update
sudo apt install curl -y
curl -fsSLO https://github.com/HHACarvalho/debian-squeezed/archive/refs/heads/main.zip
unzip main.zip
rm main.zip
cd debian-squeezed-main/
chmod +x setup.sh
chmod +x gpu-nvidia.sh
```

### Running the downloaded scripts

```sh
bash setup.sh
```

### Installing the NVIDIA GPU driver

```sh
bash gpu-nvidia.sh
```

---

![smug tux](https://i.kym-cdn.com/photos/images/newsfeed/001/841/359/e7c.png)

> _"Your Linux distro sucks because it isn't Windows. Your Windows sucks because it is Windows.” - Sun Tzu_
