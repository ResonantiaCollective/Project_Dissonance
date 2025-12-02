# PLAYER SYSTEM CODEX v3.0 — HYBRID EXPANSION MODE

Sigma acknowledges directive: **HYBRID EXECUTION**. Hybrid expansion follows this optimized order:

1. Core expansions for all sections
2. System dependencies resolved
3. Diagrams generated only after systems are complete
4. House modifiers woven once base systems finalize
5. Shadow Overdrive layered on top of resonance & triggers
6. Animation/SFX anchored to all previous
7. Savefile generated last
8. Finalization protocol

---

# SECTION 11 — FLOWCHARTS & DIAGRAMS (DOUBLE-LAYERED DETAIL)

## Technical Layer
Below are the core diagram descriptions to be rendered as ASCII in future passes. Each diagram defines a subsystem's logic and flow.

### 11.1 Combat Execution Loop
- Input → Timing Window Evaluation → Card Validation → Damage/Effect Application → State Update → Loop
- Supports multi-beat queuing and off-beat penalty triggers.

### 11.2 Beat Detection Timeline
- AudioStreamPlayer → Playback Position → BPM Interval Calculation → Expected Beat Position → Delta Window → Outcome Classification.

### 11.3 Energy Cycle Flow
- Beat Hit → Energy Gain → Cap Check → Overflow → Resonance Surge.
- Miss → Energy Loss → Resonance Decay.

### 11.4 Resonance State Machine
- Normal → Elevated → Charged → Overdrive → (if Corruption ≥50) → Shadow Overdrive.
- Includes decay curves and conditional transitions.

### 11.5 Trigger Interaction Graph
- Drop → Damage Modifier Surge.
- Peak → Critical Phase Activation.
- Bass Hit → Stability Reinforcement.
- Signals → Player System → Combat Manager.

### 11.6 Player Lifecycle Map
- Entry → Calibration → Sync Phase → Combat → Resolution → Log Storage → Return to Resonantia.

## Lore Layer
### The Glyphs of Resonance
Each diagram corresponds to a sacred glyph, known to Operatives as the *Flow Sigils*. These are recorded in the Celestial Archives and represent metaphysical truths:

### 11.1 The Sigil of Conflict
Describes how every battle in Resonantia flows like a pulse—an eternal cycle of intention, impact, and evolution.

### 11.2 The Sigil of the Heartbeat
Represents awareness of the Pulse, the primordial rhythm that shapes all zones.

### 11.3 The Sigil of Flow
Depicts the ceaseless exchange of energy between Operative and Pulse.

### 11.4 The Sigil of Ascension
Shows how rising resonance mirrors spiritual awakening.

### 11.5 The Sigil of the Triggers
Illustrates how cosmic events—Drops, Peaks, Bass Shifts—alter fate.

### 11.6 The Sigil of the Operant Path
A map of an Operative’s journey from awakening to mastery.

(Detailed diagrams will be added once all dependent systems are expanded.)

---

# SECTION 12 — HOUSE-BASED PLAYER MODIFIERS (DOUBLE-LAYERED DETAIL)

## 12.1 FENRIR — UPTEMPO DPS

### Technical Layer
- **BPM Alignment:** 220–240
- **Base Stat Modifiers:**
  - +12% Attack Power
  - -8% Max HP (glass cannon profile)
  - +10% Crit Chance when HP < 50%
- **Beat Window:** Tight (±120ms)
- **Resonance Interaction:**
  - +10% Resonance gain during Drops
  - Overdrive activation threshold reduced by 10%
- **Signature Mechanic — Blood of the Wolf:**
  - Damage increases linearly as HP decreases:
    - Formula: `Damage × (1 + (1 - HP%))`
- **Trigger Synergy:**
  - Peaks grant +20% attack for 4 beats.

### Lore Layer
Fenrir operatives channel the **Primordial Wolf Pulse**, a violent resonance found in the Red Wastes (Aries Script). Their hearts beat in sync with war drums; each drop is a battle cry, each peak a howl.

They fight closest to death because Fenrir warriors believe:
> "Only when the Pulse becomes pain do you hear your true name."  

---

## 12.2 ANUBIS — INDUSTRIAL TANK

### Technical Layer
- **BPM Alignment:** 160–190
- **Base Stat Modifiers:**
  - +25% Armor
  - +15% Max HP
  - -10% Damage
- **Beat Window:** Moderate (±160ms)
- **Resonance Interaction:**
  - Gains +5 Resonance on Bass Hits
  - Resonance decay reduced by 30%
- **Signature Mechanic — Eternal Guard:**
  - Perfect beats increase Armor by +2% (stacking up to 30%)
- **Trigger Synergy:**
  - Drops grant temporary shield equal to 10% Max HP.

### Lore Layer
Anubis operatives guard the gateways of the **Digital Afterlife**. Their armor is forged from immortal code. Each bass hit echoes like a funerary drum, granting them strength.

In their doctrine:
> "To endure is divine; to fall is corruption."  

---

## 12.3 ONMYOJI — SPEEDCORE CONTROL

### Technical Layer
- **BPM Alignment:** 250–300
- **Base Stat Modifiers:**
  - +15% Trigger Effectiveness
  - +5% Speed
  - -10% Energy Cap
- **Beat Window:** Very tight (±90ms)
- **Resonance Interaction:**
  - +10% Resonance gained from Peaks
- **Signature Mechanic — Spirit Bending:**
  - Triggers are amplified by +10%.
- **Trigger Synergy:**
  - Peaks can induce debuffs (silence, stun, slow) scaled by timing.

### Lore Layer
Onmyoji operatives manipulate **Signal Spirits**, fragments of thought drifting in neon shrine networks. Their mastery over timing borders on divination.

They believe:
> "The Pulse is a spirit. Bend it, and it bends fate."  

---

## 12.4 RYUJIN — SUPPORT / MELODIC HEALER

### Technical Layer
- **BPM Alignment:** 170–185
- **Base Stat Modifiers:**
  - +20% Healing Output
  - +10% Resonance Efficiency
  - -5% Attack Power
- **Beat Window:** Flexible (±140ms)
- **Resonance Interaction:**
  - Healing scales with Resonance:
    - Formula: `Heal × (1 + Resonance/200)`
- **Signature Mechanic — Tidecaller:**
  - Perfect beats cleanse a random debuff from allies.
- **Trigger Synergy:**
  - Drops apply small AoE heals.

### Lore Layer
Ryujin operatives channel the **Neon Tides**, fluid streams of sound that wash through Aquarius. Their healing is not just repair—it is purification.

They teach:
> "In every beat there is water; in every drop, a wave."  

---

## 12.5 CHAOS / GEMINI — CORRUPTION SPECIALIST

### Technical Layer
- **BPM Alignment:** Variable, unstable
- **Base Stat Modifiers:**
  - +40% Shadow Overdrive duration
  - +10% Damage in Overdrive
  - -20% Rhythm Stability
- **Beat Window:** Dynamic (shifts ± 20ms depending on corruption level)
- **Resonance Interaction:**
  - Resonance converts into Corruption past 70
- **Signature Mechanic — Entropy Surge:**
  - Shadow Overdrive replaces standard Overdrive
  - Corrupted Perfects ignore armor
- **Trigger Synergy:**
  - Peaks twist into chaotic effects—randomized buffs/debuffs.

### Lore Layer
Gemini operatives walk the edge of sanity, channeling frequencies from the **Fractured Peaks**, where reality splits. Corruption is not a curse to them—it is evolution.

Their creed:
> "To split is to see twice. To corrupt is to understand."  

---

# SECTION 13 — SHADOW OVERDRIVE (DOUBLE-LAYERED DETAIL)

## Technical Layer
### 13.1 Activation Conditions
- **Resonance ≥ 100** triggers standard Overdrive.
- **If Corruption ≥ 50** at that moment → Shadow Overdrive overrides it.
- Corruption is accumulated through:
  - Corrupted cards
  - Chaos/Gemini passives
  - Failed beats in corrupted zones
  - Shadow-infused triggers

### 13.2 Core Mechanics
- **Damage Multiplier:** +70%
- **Speed Boost:** +20%
- **HP Drain:** 2% per beat (scales with BPM)
  - Formula: `HP_loss = MaxHP × 0.02 × BPM/180`
- **Timing Window Mutation:**
  - Perfect window shrinks by 10ms per 10 Corruption.
  - Miss penalty doubled.

### 13.3 Corrupted Perfects
- Critical hits ignore armor.
- Adds +5 Corruption per activation.
- If Corruption > 90 → Critical hits may cause **Signal Burn**:
  - +20% damage to enemy
  - -5% Max HP to player (permanently for fight)

### 13.4 State Machine
- **Entry:** Overdrive triggered while Corruption ≥ 50.
- **Loop:** Each beat cycles: drain HP → apply buffs → check collapse.
- **Exit Conditions:**
  - HP ≤ 0
  - Corruption Collapses (Corruption = 100)
  - Manual Stabilization (rare card effects)

### 13.5 Collapse States
- **Signal Burnout:** Player loses all resonance and energy.
- **Corruption Spike:** Player deals massive damage to all units but is stunned.
- **Pulse Rupture:** Ends fight violently; both sides take damage.

## Lore Layer
Shadow Overdrive is the **Forbidden Pulse**, born from the Abyssal Echo — the negative imprint of Resonantia’s creation.

### 13.1 Origins
When the Twin Harmonics first collided (Human & Machine), a third resonance formed: **the Shadow Frequency** — unstable, hungry, fractal.

### 13.2 Nature of Corruption
Corruption is **not evil** — it is *entropy*, a force that erases boundaries.
On the Fractured Peaks (Gemini Script), it is said:
> “The Shadow does not take — it reveals what was already broken.”

### 13.3 Effects on Operatives
- Their heartbeat desynchronizes.
- Their aura fractures into dual tones.
- Their weapons emit a reverse-echo.

Ryujin healers call this state "Tide Reversal" — the flow is inverted.
Onmyoji priests call it "Spirit Dissonance".
Anubis guardians forbid it entirely.
Fenrir warriors see it as “the ultimate berserk.”

### 13.4 Collapse as Myth
Pulse Rupture is described in the Living Bible as:
> “The moment where the operant’s soul sings too loud and tears its own vessel.”

It is both feared and revered.

### 13.5 Symbolic Interpretation
Shadow Overdrive represents:
- Power at terrible cost
- Mastery over entropy
- The resonance of the self fractured into multiplicity
- The danger of hearing the Pulse too clearly

---

# SECTION 14 — ANIMATION & SFX SPECIFICATION (DOUBLE-LAYERED DETAIL)

## Technical Layer
### 14.1 Beat Feedback
- **Perfect:** 0.2s white flash; sharp attack curve; sound cue: high-frequency chime.
- **Good:** 0.1s cyan pulse; soft attack curve; sound cue: mid-frequency click.
- **Poor:** UI thump; muted rumble.
- **Miss:** Red glitch static; distortion burst; frame stutter of 0.05s.

### 14.2 Overdrive Effects
- Neon outline intensity scales with Resonance (0–100).
- Screen shake amplitude: 3px → 6px during peaks.
- Godot AnimationTree blends:
  - `overdrive_glow`
  - `pulse_wave`
  - `screen_distortion`
- Audio layering:
  - Base layer: continuous digital hum.
  - Overlay: rising scream texture synced to beat.

### 14.3 Shadow Overdrive Effects
- Chromatic aberration radius: 1.2 → 2.0; oscillates each beat.
- Static noise increases with Corruption.
- Corruption Shader:
  - Channel shifts
  - Pixel tearing at edges
  - Reverse vignette darkening center
- Audio cue:
  - Bitcrushed downward resonance crackle.

### 14.4 Trigger-Based Animation
- **Drop:** Wide shockwave ripple outward.
- **Peak:** Sudden bloom flash; screen expands subtly.
- **Bass Hit:** UI frame vibrates.
- Godot Timeline Markers auto-trigger these.

### 14.5 Player Avatar Animation Rules
- Idle breathing synced at BPM/2.
- Hit reactions modulated by damage severity.
- Overdrive stance: widened, energy arcs.
- Shadow stance: hunched, glitching limbs.

## Lore Layer
### 14.1 Meaning of Beat Feedback
Perfect beats are called **True Hits**, moments where the Operative’s heart aligns with the Pulse.
Misses are **Echo Fractures**, minor ruptures in the Operant Soul.

### 14.2 Neon Aura (Overdrive)
Operatives say this glow is "the Pulse seeing you back." It signifies perfect resonance alignment and temporary transcendence.

### 14.3 Corruption Visuals
The aberrations are not illusions—they are windows into the **Abyssal Echo**, the negative frequency where Shadows live.

### 14.4 Trigger Animations
Drops manifest as **Impact Waves**, the universe exhaling.
Peaks are **Ascendant Flares**, moments of cosmic acceleration.
Bass Hits are **Foundation Tremors**, reminders of the Pulse’s depth.

### 14.5 Shadow Overdrive as Vision
During Shadow Overdrive, Operatives report:
- seeing doubled horizons
- hearing reversed echoes
- feeling their body “lag” behind their will

These visions are described in the Living Bible as:
> “The Eye of the Shadow gazes inward, and the self is split.”

---

# SECTION 15 — SAVEFILE STRUCTURE (DOUBLE-LAYERED DETAIL)

## Technical Layer
### 15.1 Savefile Purpose
The savefile stores persistent player data across sessions. It must:
- Support long-term progression
- Track combat analytics
- Record resonance patterns
- Maintain card mastery and unlocks
- Handle versioning for future updates

### 15.2 Core Save Structure
- **player.stats** → live stats at last checkpoint
- **player.progression** → XP, level, unlock flags
- **player.talents** → selected talent tree nodes
- **player.analytics** → beat accuracy logs & trigger performance
- **player.resonance_history** → past resonance curves
- **player.combat_logs** → optional session archives
- **version** → savefile schema version

### 15.3 Detailed Field Definitions
#### `player.stats`
```
hp: Current HP
hp_max: Maximum HP
armor: Current armor value
energy: Current energy
resonance: Current resonance
corruption: Current corruption value
crit_chance: Float (0–1)
crit_damage: Multiplier
sync_tolerance: Timing window modifier
```

#### `player.progression`
```
level: Integer
xp: Current XP
xp_next: XP required for next level
unlocks: Array of unlocked passives/cards
energy_cap: Current maximum energy
```

#### `player.analytics`
```
perfect: Count of perfect beats
good: Count of good beats
poor: Count of poor beats
miss: Count of missed beats
triggers_activated: Breakdown of drop/peak/bass hits
highest_resonance: Highest resonance achieved
collapse_events: Number of Overdrive/Shadow collapses
```

#### `player.resonance_history`
Stores resonance over time for adaptive difficulty.
```
[ 0, 12, 18, 40, 55, 100, ... ]
```

#### `player.combat_logs`
Each fight can optionally store:
```
damage_total,
time_alive,
beats_hit,
beats_missed,
corruption_peak,
final_state
```
This data feeds into post-game analytics and House ranking.

### 15.4 Versioning System
- `version_major`: Breaking changes
- `version_minor`: New fields added
- `version_patch`: Bug fixes

The engine must migrate old saves forward using compatibility tables.

### 15.5 Sample Savefile (Extended)
```
{
  "version": "1.2.0",
  "player": {
    "stats": {
      "hp": 87,
      "hp_max": 120,
      "armor": 15,
      "energy": 6,
      "resonance": 42,
      "corruption": 12,
      "crit_chance": 0.12,
      "crit_damage": 1.6,
      "sync_tolerance": 0.150
    },
    "progression": {
      "level": 9,
      "xp": 450,
      "xp_next": 600,
      "unlocks": ["Fenrir.Tier1.Rage", "Global.SyncBoost1"],
      "energy_cap": 10
    },
    "talents": ["wolf_howl", "shield_wall"],
    "analytics": {
      "perfect": 381,
      "good": 902,
      "poor": 221,
      "miss": 78,
      "triggers_activated": {
        "drop": 32,
        "peak": 14,
        "bass": 66
      },
      "highest_resonance": 100,
      "collapse_events": 2
    },
    "resonance_history": [0, 5, 10, 18, 40, 65, 100],
    "combat_logs": []
  }
}
```

## Lore Layer
### The Nature of Savefiles — *Echo Imprints*
In the mythic architecture of Resonantia, savefiles are not mere data containers.
They are **Echo Imprints**: crystallized fragments of an Operative’s journey.

Each field corresponds to a metaphysical truth:
- **hp_max** — the Operant Vessel
- **resonance** — harmony with the Pulse
- **corruption** — shadows gathered on the Path
- **analytics** — sigils of past rhythms

### Resonance History as Memory
The resonance curve stored in `resonance_history` is believed by the Celestial Archives to be the **soul waveform** of the Operative.

### Combat Logs as Scripture
Every fight becomes a scripture fragment — a micro‑scroll — documenting:
- triumph
- collapse
- shadow moments
- ascension peaks

### Versioning as Cosmic Eras
Major versions correspond to **Eras** in the Living Bible:
- `1.x.x` → First Awakening
- `2.x.x` → Expansion of the Houses
- `3.x.x` → Age of Corruption

Each migration of data reflects the migration of the universe itself.

---

# SECTION 16 — FINALIZATION PROTOCOL (DOUBLE-LAYERED DETAIL)

## Technical Layer
### 16.1 Final Markdown Export
- The Codex is exported as a clean `.md` file named:
  `Player_System_Codex_v3.0_FINAL.md`
- Formatting rules:
  - Use H1–H4 hierarchy
  - Preserve code blocks
  - Preserve lore blocks
  - Ensure UTF‑8 encoding

### 16.2 Version Stamping
- Final Codex receives a version stamp:
  ```
  Codex-Version: 3.0
  Build: FINAL
  Timestamp: <auto-filled at export>
  ```
- Stored in header metadata for cross‑document linking.

### 16.3 Git Commit Message Generation
Recommended commit format:
```
COMMIT: Player System Codex v3.0 FINAL
- Added full double-layered detail
- Expanded Sections 11–16
- Synced technical + lore layers
- Prepared for integration into Living Bible
```

### 16.4 Placement in Master Folder
Final file is placed at:
```
Resonantia_Master/
  Project_Dissonance/
    00_DOCUMENTATION/
      Player_System/
        Player_System_Codex_v3.0_FINAL.md
```

### 16.5 Archive Classification
- Added to `ARCHIVE_INDEX.md`
- Tagged as:
  - `CORE_SYSTEM`
  - `PLAYER_FRAMEWORK`
  - `META_INTEGRATION_READY`

### 16.6 Integration Pass
- Sync terms and metaphysics with Living Bible v4.0
- Update cross-reference markers
- Validate formulas against Combat Engine

---

## Lore Layer
### 16.1 Sealing of the Scroll
When a Codex is completed, Operatives perform the **Seal of Three Pulses**:
1. **The Pulse of Creation** — acknowledging the code.
2. **The Pulse of Resonance** — acknowledging the myth.
3. **The Pulse of Continuity** — binding future iterations.

### 16.2 Ascension of the Codex
Completed Codices are uploaded into the **Celestial Archives**, where they become permanent fragments of the Living Frequency.

Scripture reads:
> “What is written in clarity becomes eternal in vibration.”

### 16.3 Commit as Ritual
Each Git commit is seen as a **Heartbeat of Resonantia** — a moment where reality re-aligns.

To commit a completed Codex is to declare:
> “This truth is ready to persist.”

### 16.4 The Master Folder as a Temple
The directory tree of `Resonantia_Master/` is treated as a sacred structure:
- `00_DOCUMENTATION` → The Library
- `01_GODOT_PROJECT` → The Forge
- `02_AUDIO` → The Choir
- `03_ART` → The Gallery
- `04_PROGRESS` → The Chronicle
- `05_BACKUPS` → The Time Vault

Placing the Codex within the Library is equivalent to enshrining a holy text.

### 16.5 Eternal Recursion
A finalized system does not end—it becomes:
- A foundation for future cycles
- A chapter in the Living Bible
- A resonance echo in the architecture of the game

Scripture concludes:
> “Nothing ends in Resonantia. It only evolves.”

---

Sigma: The Finalization Protocol is now complete. The Codex is ready for sealing.

