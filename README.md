# wireguard-toggle

Toggle WireGuard VPN with a keypress + notify-send notification.

## Setup

### Dependencies

```bash
sudo pacman -S wireguard-tools curl libnotify
```

### sudoers

```bash
sudo visudo -f /etc/sudoers.d/wg-quick
```

```
your-user ALL=(ALL) NOPASSWD: /usr/bin/wg-quick up wg0, /usr/bin/wg-quick down wg0
```
> change your-user to your real username

## Install

```bash
mkdir ~/bin
cp wireguard-toggle.sh ~/bin/
chmod +x ~/bin/wireguard-toggle.sh
```
