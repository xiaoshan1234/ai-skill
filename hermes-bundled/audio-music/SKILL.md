---
name: audio-music
description: "Unified skill for AI music and audio generation: songwriting + Suno-like generation (HeartMuLa), audio generation via AudioCraft/MusicGen/AudioGen, and lyrics-first songwriting craft. Covers the full pipeline from creative brief to finished track."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [audio, music-generation, songwriting, audiocraft, musicgen, suno, heartmula, generative-audio]
    category: creative
---

# Audio & Music Generation

Unified skill for AI-assisted music and audio generation workflows.

## Sub-skills (absorbed — see .archive for full packages)

The following narrow skills have been absorbed into this class-level umbrella.
Each absorbed skill's full package is preserved at `~/.hermes/skills/.archive/<skill-name>/`.

| Absorbed Skill | Category | Archives At |
|----------------|----------|------------|
| `heartmula` | Suno-like song generation from lyrics + tags | `.archive/heartmula/` |
| `audiocraft-audio-generation` | AudioCraft: MusicGen text-to-music, AudioGen text-to-sound | `.archive/audiocraft/` |
| `songwriting-and-ai-music` | Lyrics-first songwriting craft + Suno prompt techniques | `.archive/songwriting-and-ai-music/` |

## When to Use

- **Want a full song from lyrics?** → HeartMuLa (`heartmula` workflow)
- **Want to generate music from text prompts?** → AudioCraft (`audiocraft-audio-generation`)
- **Want to generate sound effects from text?** → AudioCraft AudioGen
- **Want help writing lyrics?** → Songwriting craft (`songwriting-and-ai-music`)
- **Want to compose in a specific style?** → AudioCraft + songwriting combination

## Quick Reference

### HeartMuLa (lyrics → full song)
```bash
# Generate a song from lyrics
python3 scripts/generate_song.py --lyrics "..." --tags "pop, upbeat" --output ./song
```

### AudioCraft (text → music/sound)
```bash
# Text-to-music
python3 scripts/musicgen.py --prompt "lo-fi beat, chill, relaxing" --duration 30

# Text-to-sound
python3 scripts/audiogen.py --prompt "door creaking" --duration 2
```

### Songwriting
- Start with a mood/theme
- Use the songwriting workflow: verse → chorus → bridge structure
- Tag generation with genre, mood, tempo, instruments
