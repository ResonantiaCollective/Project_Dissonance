# Canon Inventory — Audio Assets vs Codex Requirements

This inventory maps declared canon tracks and the Music Canon obligations to actual files in `Project_Dissonance/02_AUDIO` and `Resonantia_Records`.

## Scan date
- 2025-12-21

## Summary (prototype phase)
- Declared prototype Card Tracks: 16 (4 Houses × 4 cards) per Music Canon v1.0.
- Found canonical production material for Fenrir: `FEN-01_SURGE`.

## Discovered items
- FEN-01_SURGE
  - `00_PROJECT/FEN-01_SURGE_v1.0.flp` — FOUND
  - `00_PROJECT/FEN-01_SURGE_TEMPLATE_CANON.flp` — FOUND
  - `01_AUDIO/STEMS/` — placeholder (.gitkeep) — export required
  - `01_AUDIO/RENDERS/` — placeholder — renders required
  - `02_EXPORT/MASTER/` — placeholder (.gitkeep) — master export missing
  - `02_EXPORT/SYSTEM_EDIT/` — placeholder (.gitkeep) — system edit missing
  - `03_NOTES/FEN-01_SURGE_Production_Notes.md` — FOUND (canon-locked)

## Other audio assets (prototype)
- `Project_Dissonance/01_GODOT_PROJECT/resonantia-prototype/resources/audio/` contains a few engine/demo WAVs (Dojo_Loop, IQUP kick loop, breakcore sample) — suitable for prototype testing but not declared canon card tracks.
- `Resonantia_Records/03_SETS/Echo_Forge/Resonantia_First_Pulse/` contains a continuous mix master and artwork (canon event 001).

## Gaps vs Codex obligations (per Music Canon Section 6.1–6.3)
- Stems: missing (export into `01_AUDIO/STEMS/`)
- Master: missing (export into `02_EXPORT/MASTER/` with naming `FEN-01_SURGE_MASTER_v1.0.wav`)
- System edit: missing (export into `02_EXPORT/SYSTEM_EDIT/`)
- Artwork for single: missing (use Echo_Forge set art or create new under `01_ARTWORK/`)

## Recommended immediate tasks (ordered)
1. Export stems from FLP → `01_AUDIO/STEMS/` with a README describing channel routing and mix decisions. (Owner: audio operative)
2. Export master (24-bit, 48 kHz recommended) → `02_EXPORT/MASTER/FEN-01_SURGE_MASTER_v1.0.wav` and commit.
3. Create system edit (trim/loop-safe) → `02_EXPORT/SYSTEM_EDIT/FEN-01_SURGE_SYSTEM_v1.0.wav`.
4. Add artwork placeholder under `02_AUDIO/…/01_ARTWORK/` or copy Echo_Forge set artwork to `Resonantia_Records/01_ARTISTS/Fenrir/01_RELEASES/`.
5. Complete `Resonantia_Records/01_ARTISTS/Fenrir/FEN-01_SURGE_Release_Checklist.md` (already added) and fill `02_METADATA/soundcloud.txt`.

## Longer-term (prototype phase)
- Repeat above process for FEN-02..FEN-04 and for all four Houses (16 tracks). Ensure each track follows folder structure in Music Canon Section 6.2.
- Create a canonical `00_DOCUMENTATION/02_TECHNICAL_CODEX/AUDIO_CANON/Track_Status_Table.csv` for machine-readable tracking.

## Notes
- This inventory is generated from the repository snapshot. Perform exports locally (FL Studio) and commit the resulting audio files; FLP files are present but binary exports cannot be produced by this script.
