# Porco TTS

Um leitor de tela inteligente para Arch Linux baseado no Piper TTS, com suporte a Visão Computacional (OCR) e filtros de voz otimizados.

## 🚀 Funcionalidades

- **Leitura de Seleção**: Lê instantaneamente qualquer texto selecionado (X11/Wayland).
- **Leitura de Tela (OCR)**: Se nada estiver selecionado, o script tira um snapshot da janela sob o mouse e usa OCR (`tesseract`) para identificar o conteúdo.
- **Filtro Inteligente**: Diferencia conteúdo útil (sentenças/parágrafos) de ruídos de interface (menus, nomes de botões).
- **Voz de Alta Qualidade**: Filtros FFmpeg integrados para remover sons abafados e aumentar a clareza da voz.
- **Toggle Mode**: Aperte o atalho novamente para parar a leitura instantaneamente.

## 🛠️ Dependências (Arch Linux)

O instalador tentará instalar estas dependências automaticamente:

- `piper-tts-bin` (AUR)
- `ffmpeg`
- `xdotool`
- `xclip`
- `tesseract` + `tesseract-data-afr`
- `imagemagick`
- `python3`
- `libnotify`
- `alsa-utils` (para `aplay`)

## 📦 Instalação

1.  Clone este repositório:

    ```bash
    git clone https://github.com/SEU_USUARIO/porco-tts.git
    cd porco-tts
    ```

2.  Execute o instalador:

    ```bash
    chmod +x install.sh
    ./install.sh
    ```

3.  Coloque seu modelo de voz `.onnx` e o arquivo `.json` correspondente em:
    `$HOME/.config/piper/pt-BR-cadu-medium.onnx`

## ⌨️ Atalho de Teclado (KDE/GNOME/i3)

Configure uma tecla (ex: `Meta + S`) para executar o seguinte comando:

```bash
$HOME/.local/bin/porco_read.sh 1.6
```

_(O número 1.6 é a velocidade da fala, ajuste como preferir)._

## 📄 Licença

MIT
