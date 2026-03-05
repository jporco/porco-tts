#!/bin/bash

# Instalador para Porco TTS
# Autor: Porco

echo "--- Instalando Porco TTS ---"

# 1. Instalar dependências no Arch Linux
echo "[1/3] Verificando dependências..."
sudo pacman -S --needed piper-tts-bin ffmpeg xdotool xclip tesseract tesseract-data-afr imagemagick python3 libnotify alsa-utils --noconfirm

# 2. Criar diretórios necessários
echo "[2/3] Criando diretórios..."
mkdir -p "$HOME/.config/piper"
mkdir -p "$HOME/.local/bin"

# 3. Copiar script e dar permissão
echo "[3/3] Instalando script..."
cp piper_read.sh "$HOME/.local/bin/porco_read.sh"
chmod +x "$HOME/.local/bin/porco_read.sh"

echo ""
echo "--- Instalação Concluída! ---"
echo "O script foi instalado em: $HOME/.local/bin/porco_read.sh"
echo ""
echo "DICA: Para usar, configure um atalho de teclado (ex: Meta+S) para executar:"
echo "      $HOME/.local/bin/porco_read.sh 1.6"
echo ""
echo "Certifique-se de colocar seu modelo .onnx em $HOME/.config/piper/pt-BR-cadu-medium.onnx"
