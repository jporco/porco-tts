#!/bin/bash
# Leitura de texto selecionado ou OCR via Piper TTS (X11).

set -euo pipefail

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/porco-tts"
CONFIG_FILE="$CONFIG_DIR/config"
VOICE_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/piper"
VOICE_NAME="pt-BR-cadu-medium.onnx"
OCR_LANG="por+eng"
SPEED="1.6"
VOLUME="1.0"
RATE=22050
LOGFILE="/tmp/piper_read.log"

if [[ -f "$CONFIG_FILE" ]]; then
    # shellcheck source=/dev/null
    source "$CONFIG_FILE"
fi

VOICE="$VOICE_DIR/$VOICE_NAME"

if [[ ! -f "$VOICE" ]]; then
    notify-send "Porco TTS" "Modelo de voz não encontrado: $VOICE"
    exit 1
fi

SPEED="${1:-$SPEED}"
VOLUME="${3:-$VOLUME}"

if pgrep -f "piper-tts.*$VOICE_NAME" >/dev/null; then
    pkill -f "piper-tts.*$VOICE_NAME" || true
    pkill -u "$USER" -x aplay || true
    echo "$(date): leitura interrompida (toggle)" >> "$LOGFILE"
    exit 0
fi

if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    TEXT=$(wl-paste -p 2>/dev/null || wl-paste 2>/dev/null || true)
else
    TEXT=$(xclip -o -selection primary 2>/dev/null || xclip -o -selection clipboard 2>/dev/null || true)
fi

if [[ -z "$TEXT" && "$XDG_SESSION_TYPE" != "wayland" ]]; then
    WINDOW_UNDER_MOUSE=$(xdotool getmouselocation --shell 2>/dev/null | grep WINDOW | cut -d= -f2 || true)

    if [[ -n "$WINDOW_UNDER_MOUSE" ]]; then
        notify-send "Porco TTS" "Analisando conteúdo..." -i scanner -t 1500
        TMP_IMG="/tmp/porco_tts_ocr.png"
        import -window "$WINDOW_UNDER_MOUSE" "$TMP_IMG" 2>/dev/null || true

        if [[ -f "$TMP_IMG" ]]; then
            RAW_OCR=$(tesseract "$TMP_IMG" stdout -l "$OCR_LANG" 2>/dev/null || true)
            rm -f "$TMP_IMG"

            TEXT=$(python3 -c "
import sys, re, unicodedata

def is_useful(line):
    line = line.strip()
    words = line.split()
    if len(words) < 3:
        return False
    ui_noise = {
        'file', 'edit', 'view', 'history', 'bookmarks', 'tools', 'help',
        'arquivos', 'editar', 'ajuda', 'pesquisar', 'search', 'ok',
        'cancel', 'close', 'fechar',
    }
    if len(words) < 5 and any(w.lower() in ui_noise for w in words):
        return False
    return True

lines = sys.stdin.read().split('\n')
useful = []
seen = set()
for line in lines:
    if not is_useful(line):
        continue
    line = ''.join(
        c for c in line
        if unicodedata.category(c)[0] != 'C' and unicodedata.category(c) != 'So'
    )
    line = re.sub(
        r'[^\w\s.,?!;ÁÉÍÓÚáéíóúÂÊÎÔÛâêîôûÀÈÌÒÙàèìòùÃÕãõÇç]',
        ' ',
        line,
    )
    line = re.sub(r'\s+', ' ', line).strip()
    if line and line not in seen:
        useful.append(line)
        seen.add(line)
print(' '.join(useful))
" <<< "$RAW_OCR")
        fi
    fi
fi

if [[ -n "$TEXT" && "$XDG_SESSION_TYPE" != "wayland" ]]; then
    echo -n "" | xclip -selection primary 2>/dev/null || true
fi

if [[ -z "$TEXT" ]]; then
    TEXT="${2:-}"
fi

if [[ -z "$TEXT" ]]; then
    notify-send "Porco TTS" "Nenhum texto relevante encontrado."
    exit 1
fi

echo "$(date): iniciando leitura" >> "$LOGFILE"

FILTER="asetrate=$RATE*0.88,atempo=$SPEED,highpass=f=200,equalizer=f=4000:t=q:w=1:g=5,equalizer=f=8000:t=q:w=1:g=3,volume=$VOLUME"

(
    echo "$TEXT" | /usr/bin/piper-tts --model "$VOICE" --output_raw |
        /usr/bin/ffmpeg -f s16le -ar "$RATE" -ac 1 -i - -af "$FILTER" -f wav - 2>>"$LOGFILE" |
        /usr/bin/aplay -q
) &

notify-send "Porco TTS" "Lendo texto..." -i audio-speakers
