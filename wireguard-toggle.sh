#!/bin/bash

WG_INTERFACE="wg0"
WG_CONFIG="/etc/wireguard/${WG_INTERFACE}.conf"

if ip link show "${WG_INTERFACE}" &>/dev/null; then
    sudo wg-quick down "${WG_INTERFACE}"
    PUBLIC_IP=$(curl -s --max-time 5 ifconfig.co)
    notify-send "WireGuard 🔒(ВИМКНЕНО)" "VPN відключено\nПоточний IP: ${PUBLIC_IP}" -u normal
else
    # VPN неактивний — вмикаємо
    sudo wg-quick up "${WG_INTERFACE}"

    # Чекаємо трохи поки маршрути підніммуться
    sleep 1

    VPN_IP=$(curl -s --max-time 5 ifconfig.co)
    WG_IP=$(grep -oP '(?<=Address = )[^/,]+' "${WG_CONFIG}" | head -1)

    if [ -n "${WG_IP}" ] && [ -n "${VPN_IP}" ]; then
	    notify-send "WireGuard 🔐(УВІМКНЕНО)" "VPN підключено ✅\nPublic IP: ${VPN_IP}\nWG addr: ${WG_IP}" -u low
    else
	    notify-send "WireGuard 🔐(УВІМКНЕНО)" "VPN підключено ✅\nPublic IP: ${VPN_IP:-невідомо}" -u low
    fi
fi
