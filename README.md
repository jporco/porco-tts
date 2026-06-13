# Porco TTS

Local screen reader for Arch Linux using Piper TTS, with OCR support and voice filters.

## Features

- **Selection reading**: reads selected text (X11/Wayland)
- **OCR**: if nothing is selected, captures the window under the mouse (X11 only)
- **Content filter**: ignores menus and UI noise
- **Voice pipeline**: FFmpeg filters for clarity and speed
- **Toggle**: press the shortcut again to stop

## Dependencies (Arch Linux)

Installed automatically by `install.sh`:

- `piper-tts-bin` (AUR, via paru/yay)
- `ffmpeg`, `xdotool`, `xclip`, `wl-clipboard`
- `tesseract`, `tesseract-data-por`, `tesseract-data-eng`
- `imagemagick`, `python3`, `libnotify`, `alsa-utils`

## Installation

```bash
git clone https://github.com/jporco/porco-tts.git
cd porco-tts
chmod +x install.sh
./install.sh
```

Place the Piper voice model (`.onnx` + `.json`) in:

```
~/.config/piper/pt-BR-cadu-medium.onnx
```

Optional settings: `~/.config/porco-tts/config`

## Keyboard shortcut (KDE / GNOME / i3)

Assign a key (e.g. **Meta+S**) to:

```bash
$HOME/.local/bin/piper_read.sh
```

Speed can be passed as an argument: `piper_read.sh 1.6`

## License

MIT

---

# Porco TTS (pt-BR)

Leitor de tela local para Arch Linux com Piper TTS, OCR e filtros de voz.

## Recursos

- **Leitura de seleção**: lê texto selecionado (X11/Wayland)
- **OCR**: sem seleção, captura a janela sob o mouse (somente X11)
- **Filtro de conteúdo**: ignora menus e ruído de interface
- **Pipeline de voz**: filtros FFmpeg para clareza e velocidade
- **Toggle**: pressione o atalho de novo para parar

## Dependências (Arch Linux)

Instaladas automaticamente pelo `install.sh`:

- `piper-tts-bin` (AUR, via paru/yay)
- `ffmpeg`, `xdotool`, `xclip`, `wl-clipboard`
- `tesseract`, `tesseract-data-por`, `tesseract-data-eng`
- `imagemagick`, `python3`, `libnotify`, `alsa-utils`

## Instalação

```bash
git clone https://github.com/jporco/porco-tts.git
cd porco-tts
chmod +x install.sh
./install.sh
```

Coloque o modelo Piper (`.onnx` + `.json`) em:

```
~/.config/piper/pt-BR-cadu-medium.onnx
```

Configuração opcional: `~/.config/porco-tts/config`

## Atalho de teclado (KDE / GNOME / i3)

Atribua uma tecla (ex.: **Meta+S**) para:

```bash
$HOME/.local/bin/piper_read.sh
```

Velocidade opcional: `piper_read.sh 1.6`

## Licença

MIT
