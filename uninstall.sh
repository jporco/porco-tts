#!/bin/bash
# Remove arquivos instalados pelo install.sh (não remove modelos de voz).

set -euo pipefail

BINDIR="${HOME}/.local/bin"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/porco-tts"
DESKTOP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/applications"

echo "=== Porco TTS — desinstalação ==="

rm -f "$BINDIR/piper_read.sh"
rm -f "$DESKTOP_DIR/net.local.porco-tts.desktop"
rm -f "$DESKTOP_DIR/net.local.piper_read.sh.desktop"
rm -f "$DESKTOP_DIR/net.local.piper_read.sh-2.desktop"

echo "Script e atalhos removidos."
echo "Config em $CONFIG_DIR mantida (remova manualmente se quiser)."
echo "Modelos Piper em ~/.config/piper/ não foram alterados."
