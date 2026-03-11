#!/bin/bash

WG_INTERFACE="wg0"
WG_CONFIG="/etc/wireguard/${WG_INTERFACE}.conf"

if ip link show "${WG_INTERFACE}" &>/dev/null; then
    sudo wg-quick down "${WG_INTERFACE}"
    PUBLIC_IP=$(curl -s --max-time 5 ifconfig.co)
    notify-send "WireGuard 🔒(DOWN)" "VPN disconnected\nCurrent IP: ${PUBLIC_IP}" -u critical
else
    sudo wg-quick up "${WG_INTERFACE}"
    sleep 1
    VPN_IP=$(curl -s --max-time 5 ifconfig.co)
    WG_IP=$(grep -oP '(?<=Address = )[^/,]+' "${WG_CONFIG}" | head -1)

    if [ -n "${WG_IP}" ] && [ -n "${VPN_IP}" ]; then
	    notify-send "WireGuard 🔐(UP)" "VPN connected ✅\nPublic IP: ${VPN_IP}\nWG addr: ${WG_IP}" -u low
    else
	    notify-send "WireGuard 🔐(UP)" "VPN connected ✅\nPublic IP: ${VPN_IP:-unknown}" -u low
    fi
fi
