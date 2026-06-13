#!/bin/bash
# Instalador do Porco TTS — Arch Linux / CachyOS

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BINDIR="${HOME}/.local/bin"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/porco-tts"
DESKTOP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/applications"
VOICE_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/piper"

echo "=== Porco TTS — instalação ==="

if ! command -v pacman >/dev/null; then
    echo "Este instalador requer pacman (Arch Linux ou derivado)."
    exit 1
fi

echo "[1/5] Dependências (repositórios oficiais)..."
sudo pacman -S --needed \
    ffmpeg xdotool xclip tesseract tesseract-data-por tesseract-data-eng \
    imagemagick python3 libnotify alsa-utils wl-clipboard \
    --noconfirm

echo "[2/5] Piper TTS (AUR)..."
if ! command -v piper-tts >/dev/null; then
    if command -v paru >/dev/null; then
        paru -S --needed piper-tts-bin --noconfirm
    elif command -v yay >/dev/null; then
        yay -S --needed piper-tts-bin --noconfirm
    else
        echo "Instale piper-tts-bin manualmente (AUR) e execute este script novamente."
        exit 1
    fi
fi

echo "[3/5] Diretórios..."
mkdir -p "$BINDIR" "$CONFIG_DIR" "$DESKTOP_DIR" "$VOICE_DIR"

echo "[4/5] Script e configuração..."
install -m 755 "$ROOT/bin/piper_read.sh" "$BINDIR/piper_read.sh"

if [[ ! -f "$CONFIG_DIR/config" ]]; then
    install -m 644 "$ROOT/config/config.example" "$CONFIG_DIR/config"
    echo "Config criada em: $CONFIG_DIR/config"
else
    echo "Config existente mantida: $CONFIG_DIR/config"
fi

echo "[5/5] Atalho KDE..."
sed "s|@BINDIR@|$BINDIR|g" "$ROOT/desktop/porco-tts.desktop.in" \
    > "$DESKTOP_DIR/net.local.porco-tts.desktop"

# Compatibilidade com atalhos já configurados (ex.: Meta+S)
cp "$DESKTOP_DIR/net.local.porco-tts.desktop" \
    "$DESKTOP_DIR/net.local.piper_read.sh.desktop"

echo ""
echo "=== Instalação concluída ==="
echo "Script:  $BINDIR/piper_read.sh"
echo "Config:  $CONFIG_DIR/config"
echo "Atalho:  $DESKTOP_DIR/net.local.porco-tts.desktop"
echo ""
echo "Próximos passos:"
echo "  1. Baixe um modelo Piper pt-BR (.onnx + .json) em:"
echo "     https://github.com/rhasspy/piper/blob/master/voices/pt/pt_BR/cadu/medium/pt_BR-cadu-medium.onnx.json"
echo "  2. Coloque os arquivos em: $VOICE_DIR/"
echo "  3. Configure Meta+S em: Configurações → Atalhos → Atalhos personalizados"
echo "     Comando: $BINDIR/piper_read.sh"
echo ""
