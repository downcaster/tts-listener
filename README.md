# listen-live

Real-time speech-to-text transcription tool for macOS using OpenAI's Whisper model via `whisper.cpp`.

## Features

- 🎤 **Two modes**: Continuous listening or Push-to-Talk (PTT)
- 🔴 **Push-to-Talk**: Hold `Cmd+\` to record, release to auto-copy to clipboard
- 🔄 **Continuous**: Always listening, auto-copies after 5s of silence
- 🎯 **Real-time display**: See transcription update live as you speak
- 🔇 **Noise filtering**: Filters out music, ambient sounds, and annotations
- 📋 **Clipboard integration**: Seamless copy to system clipboard
- 🎛️ **Audio device selection**: Choose from available input devices
- ⚡ **Local processing**: Runs entirely on your Mac using Whisper (no cloud API needed)

## Prerequisites

### 1. Install Homebrew dependencies

```bash
brew install whisper-cpp
```

### 2. Download Whisper model

```bash
mkdir -p ~/.whisper-models
# Download the small model (recommended for balance of speed/accuracy)
curl -L https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-small.bin -o ~/.whisper-models/ggml-small.bin
```

### 3. Install Hammerspoon (for global hotkeys)

```bash
brew install --cask hammerspoon
```

## Installation

1. **Install the script:**

```bash
mkdir -p ~/.local/bin
curl -L https://raw.githubusercontent.com/downcaster/listen-live/main/listen-live -o ~/.local/bin/listen-live
chmod +x ~/.local/bin/listen-live
```

2. **Add to PATH** (add to your `~/.zshrc` or `~/.bashrc`):

```bash
export PATH="$HOME/.local/bin:$PATH"
```

3. **Setup Hammerspoon:**

```bash
# Copy the Hammerspoon config
curl -L https://raw.githubusercontent.com/YOUR_USERNAME/listen-live/main/hammerspoon-init.lua >> ~/.hammerspoon/init.lua

# Reload Hammerspoon
open -a Hammerspoon
```

Grant Hammerspoon accessibility permissions when prompted (System Settings > Privacy & Security > Accessibility).
Reload Hammerspoon config by clicking on the Hammerspoon top menu icon > "Reload Config"

## Usage

### Run the tool

```bash
listen-live
```

### Mode Selection

1. **Select audio input device** from the list (or choose system default)
2. **Choose mode:**
   - **Continuous (1)**: Always listening, auto-copies accumulated text after 5s of silence
   - **Push-to-Talk (2)**: Hold `Cmd+\` to record, release to copy

### Tips

- For PTT mode, the hotkey works globally (even when terminal is not focused)
- Whisper runs locally, so first-time startup may be slower
- Small model is recommended for real-time performance
- Avoid background music for better accuracy

## How it works

- Uses `whisper-stream` from `whisper.cpp` for real-time transcription
- Processes audio in chunks with progressive updates
- Hammerspoon provides global hotkey detection for PTT mode
- Text extraction filters ANSI codes and takes the longest/most complete line
- Accumulates text segments intelligently to avoid duplications

## Troubleshooting

**No speech detected:**
- Check your microphone permissions for Terminal/iTerm
- Try selecting a different audio input device
- Speak louder or closer to the microphone

**Hotkey not working:**
- Ensure Hammerspoon has accessibility permissions
- Reload Hammerspoon configuration: `hs.reload()` in Hammerspoon console

**Text duplications:**
- This is a known minor issue with the first word in continuous mode
- We're working on improving the segment detection logic

## License

MIT

## Credits

- Built with [whisper.cpp](https://github.com/ggerganov/whisper.cpp)
- OpenAI's [Whisper](https://github.com/openai/whisper) model
