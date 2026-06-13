# Porco TTS

Leitor de tela local para Linux (X11) com **Piper TTS**, leitura de seleção e OCR opcional.

Pressione o atalho configurado (ex.: **Meta+S**) para ler o texto selecionado. Se nada estiver selecionado, captura a janela sob o cursor e usa OCR. Pressione novamente para interromper.

## Recursos

- Leitura instantânea de texto selecionado (X11 e Wayland)
- OCR da janela sob o mouse quando não há seleção (somente X11)
- Filtro de conteúdo para ignorar menus e botões de interface
- Pipeline de áudio com FFmpeg (tom, velocidade, clareza)
- Modo toggle: mesmo atalho para parar a leitura

## Requisitos

| Componente | Pacote (Arch) | Função |
|---|---|---|
| Piper TTS | `piper-tts-bin` (AUR) | Síntese de voz |
| FFmpeg | `ffmpeg` | Filtros de áudio |
| xdotool | `xdotool` | Janela sob o mouse (X11) |
| xclip | `xclip` | Seleção primária (X11) |
| wl-clipboard | `wl-clipboard` | Seleção (Wayland) |
| Tesseract | `tesseract`, `tesseract-data-por`, `tesseract-data-eng` | OCR |
| ImageMagick | `imagemagick` | Captura de janela |
| Python 3 | `python3` | Filtro inteligente de OCR |
| libnotify | `libnotify` | Notificações |
| ALSA | `alsa-utils` | Reprodução (`aplay`) |

**Modelo de voz:** arquivo `.onnx` + `.json` do Piper (pt-BR recomendado).

## Instalação

### 1. Clonar o repositório

```bash
git clone https://github.com/jporco/porco-tts.git
cd porco-tts
```

### 2. Executar o instalador

```bash
chmod +x install.sh
./install.sh
```

O instalador:

- Instala dependências via `pacman`
- Instala `piper-tts-bin` via `paru` ou `yay` (AUR)
- Copia `bin/piper_read.sh` para `~/.local/bin/`
- Cria `~/.config/porco-tts/config` a partir do exemplo
- Registra atalho KDE em `~/.local/share/applications/`

### 3. Baixar modelo de voz

Baixe o par `.onnx` + `.json` do repositório oficial do Piper:

- [pt-BR-cadu-medium](https://huggingface.co/rhasspy/piper-voices/tree/main/pt/pt_BR/cadu/medium)

Coloque os arquivos em:

```
~/.config/piper/pt-BR-cadu-medium.onnx
~/.config/piper/pt-BR-cadu-medium.onnx.json
```

Outros modelos pt-BR funcionam — ajuste `VOICE_NAME` no arquivo de configuração.

### 4. Configurar atalho de teclado

**KDE Plasma**

1. Configurações do Sistema → Atalhos → Atalhos personalizados
2. Adicionar → Comando: `~/.local/bin/piper_read.sh`
3. Atribuir tecla (ex.: **Meta+S**)

Ou use o `.desktop` instalado automaticamente (`net.local.porco-tts.desktop`) na mesma tela de atalhos.

**Outros ambientes (i3, sway, GNOME)**

Adicione ao seu arquivo de atalhos:

```bash
~/.local/bin/piper_read.sh
```

## Configuração

Arquivo: `~/.config/porco-tts/config`

```bash
VOICE_DIR="$HOME/.config/piper"
VOICE_NAME="pt-BR-cadu-medium.onnx"
OCR_LANG="por+eng"
SPEED="1.6"
VOLUME="1.0"
```

| Variável | Descrição | Padrão |
|---|---|---|
| `VOICE_DIR` | Pasta dos modelos Piper | `~/.config/piper` |
| `VOICE_NAME` | Arquivo `.onnx` | `pt-BR-cadu-medium.onnx` |
| `OCR_LANG` | Idiomas Tesseract | `por+eng` |
| `SPEED` | Velocidade da fala | `1.6` |
| `VOLUME` | Volume FFmpeg | `1.0` |

A velocidade também pode ser passada na linha de comando:

```bash
~/.local/bin/piper_read.sh 1.4
```

## Uso

1. Selecione texto em qualquer aplicativo → pressione o atalho
2. Sem seleção (X11): posicione o mouse sobre a janela → pressione o atalho (OCR)
3. Pressione o atalho novamente para parar

## Estrutura do projeto

```
porco-tts/
├── bin/piper_read.sh       # Script principal
├── config/config.example   # Configuração de exemplo
├── desktop/                # Template de atalho KDE
├── install.sh
├── uninstall.sh
└── README.md
```

## Desinstalação

```bash
./uninstall.sh
```

Remove script e atalhos. Modelos de voz e configuração permanecem (remova manualmente se quiser).

## Limitações

- OCR disponível apenas em **X11** (requer `xdotool` e `import`)
- Wayland: apenas leitura de texto selecionado
- Modelos de voz não são incluídos no repositório (tamanho/licença)

## Licença

MIT — veja [LICENSE](LICENSE).
