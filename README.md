# Porco TTS

An intelligent screen reader for Arch Linux based on Piper TTS, featuring Computer Vision (OCR) support and optimized voice filters.

## 🚀 Features

- **Selection Reading**: Instantly reads any selected text (X11/Wayland).
- **Screen Reading (OCR)**: If no text is selected, the script takes a snapshot of the window under the mouse and uses OCR (`tesseract`) to identify content.
- **Intelligent Filtering**: Distinguishes useful content (sentences/paragraphs) from UI noise (menus, button names).
- **High-Quality Voice**: Integrated FFmpeg filters to remove muffled sounds and increase speech clarity.
- **Toggle Mode**: Press the shortcut again to stop reading instantly.

## 🛠️ Dependencies (Arch Linux)

The installer will attempt to install these dependencies automatically:

- `piper-tts-bin` (AUR)
- `ffmpeg`
- `xdotool`
- `xclip`
- `tesseract` + `tesseract-data-afr`
- `imagemagick`
- `python3`
- `libnotify`
- `alsa-utils` (for `aplay`)

## 📦 Installation

1.  Clone this repository:

    ```bash
    git clone https://github.com/jporco/porco-tts.git
    cd porco-tts
    ```

2.  Run the installer:

    ```bash
    chmod +x install.sh
    ./install.sh
    ```

3.  Place your `.onnx` voice model and the corresponding `.json` file in:
    `$HOME/.config/piper/pt-BR-cadu-medium.onnx`

## ⌨️ Keyboard Shortcut (KDE/GNOME/i3)

Configure a key (e.g., `Meta + S`) to execute the following command:

```bash
$HOME/.local/bin/porco_read.sh 1.6
```

_(The number 1.6 is the speech speed, adjust as preferred)._

## 📄 License

MIT
