# FEN-01 — SURGE (Production Notes)

## Canon Identity

- Card Name: SURGE
- Card ID: FEN-01
- House: Fenrir
- Track Title: SURGE
- Track ID: FEN-01_SURGE

## Musical Parameters

- BPM: 202 (fixed)
- Energy Role: Burst Aggression
- Tempo Law: No tempo automation in v1.0

## System Intent

SURGE converts perfect timing into decisive force.
The track must feel immediate, confrontational, and precise.

- Triggers enemy ALERT state
- PERFECT timing shatters resistance
- Punishes hesitation

## Production Constraints

- No extended intro
- First impact within 2 bars
- Clear drop definition
- Rhythmic clarity above all

## Version

- v1.0 — Initial canon binding

## Fenrir Arc (Concept)

- FEN-01 — SURGE: inevitability
- FEN-02 — FRACTURE: instability
- FEN-03 — RECLAIM: disciplined control
- FEN-04 — DOMINION: absolute authority

---

## Arrangement Blueprint — FEN-01_SURGE (Draft v0.1)

### Global Parameters

- **Tempo:** 202 BPM  
- **Time Signature:** 4/4  
- **Target Length:** ~1:00 – 1:20  
- **Design Intent:** Assertion of force. No release-driven storytelling.

SURGE is not a journey.  
It is a statement.

---

### SECTION I — PRESSURE BUILD  

**Bars:** 1–8  

**Purpose:** Establish inevitability without relief.

**Active Elements:**

- KICK_SURGE (reduced weight or filtered)
- SUB_SURGE (minimal, restrained)
- NOISE_SURGE (very subtle, mechanical)

**Rules:**

- No groove development
- No fills
- No melodic material
- Pressure increases through density, not brightness

**Emotional Intent:**  
> “Something has started and will not stop.”

---

### SECTION II — DROP_01  

**Bars:** 9–16  

**Purpose:** First full assertion of Fenrir force.

**Active Elements:**

- Full KICK_SURGE
- SUB_SURGE + BASS_SURGE locked
- LEAD_SURGE introduced (minimal motif)
- IMPACT_SURGE at bar 9

**Rules:**

- No new ideas after bar 10
- Repetition is dominance
- FX only on structural points

**Emotional Intent:**  
> “This is the rule now.”

---

### SECTION III — PEAK_01  

**Bars:** 17–24  

**Purpose:** Maximum density, zero mercy.

**Active Elements:**

- KICK_SURGE
- SUB_SURGE
- BASS_SURGE
- LEAD_SURGE + STAB_SURGE interplay
- NOISE_SURGE (gated, rhythmic)

**Rules:**

- No breakdowns
- No energy dips
- No variation tricks
- Sustain pressure through consistency

**Emotional Intent:**  
> “There is no escape.”

---

### SECTION IV — RELEASE_01  

**Bars:** 25–32  

**Purpose:** Controlled withdrawal, not relief.

**Active Elements:**

- KICK_SURGE remains active
- BASS_SURGE simplified
- FX elements stripped back

**Rules:**

- No emotional resolution
- No comfort fade
- Authority remains until the end

**Emotional Intent:**  
> “The force leaves, but the mark remains.”

---

### Hard Arrangement Laws (SURGE)

- No breakdown section
- No melodic bridge
- No DJ-friendly intro
- No fake tension–release cycles

SURGE is assertion, not conversation.

---

---

## Sound Design — KICK_SURGE (Canon Build)

### Objective

Design the canonical KICK_SURGE sound that defines timing, impact, and authority
for FEN-01_SURGE and all future Fenrir assets.

This kick must obey A1 — KICK_SURGE LAW in full.

---

### Target Characteristics

- Aggressive, force-driven impact
- Fast transient, no softness
- Short to medium tail
- Resolves fully before next hit at 202 BPM
- Feels inevitable, not musical

---

### Forbidden Traits

- No groove bounce
- No long decay or 909-style tail
- No EDM roundness
- No stereo width
- No reverb on main body

---

### Design Checklist

- [ ] Mono, center
- [ ] Dominates low-end timing
- [ ] Subordinate bass interaction
- [ ] Unpleasant when soloed
- [ ] Stable at full repetition

---

### Validation Question

> “Does this kick feel like it cannot be stopped?”

If the answer is not an immediate **yes**, the kick is rejected.

---

*End of KICK_SURGE sound design brief*---

### KICK_SURGE — Canon Lock

- Base sample selected and validated
- Channel fader fixed at **0.0 dB**
- Peak level ≈ **-3 dBFS**
- No compression
- No saturation
- No limiting
- Mono, center

KICK_SURGE is the loudness reference.
All other elements must yield to it.

Status: **CANON LOCKED**

## SUB_SURGE — Canon Lock (v1.0)

- Instrument: 3xOSC (single sine)
- Envelope: ATT 0 ms / DEC ~100 ms / SUS 0 / REL 0
- Routing: Channel Rack → BUS_DRUMS
- Polarity: Checked and locked (stronger position retained)
- Timing: Micro-aligned to KICK_SURGE (±2–5 ms max, final locked)
- Gain stage: Channel Rack trim used (no bus compensation)
- Peak behavior: Kick ≈ -3 dB / Kick+Sub ≈ -2 dB
- Status: **LOCKED — Do not modify without version bump**

## CLAP_SURGE — Canon Lock (v1.0)

- Source: Short, dry clap sample
- Placement: Beats 2 and 4 only
- Timing: Grid-aligned (micro-nudge only if needed)
- Stereo: Mono / centered
- Gain stage: Channel Rack trim (no bus compensation)
- FX: None
- Role: Backbeat articulation, not impact

Status: **LOCKED**

### HAT_SURGE — Canon Locked

- Role: Micro-energy / perceived speed
- Source: Short closed hat (dry, mono)
- Pattern: Straight 8th notes @ 202 BPM
- Processing: None (no EQ, no FX)
- Level: Subtle (-12 to -18 dB range)
- Routing: BUS_DRUMS
- Note: Felt when muted, not noticed when present

### PERC_SURGE — Canon Locked

- Role: Transient reinforcement / groove pressure
- Source: Very short percussive click or rim
- Pattern: Sparse off-beat accents
- Processing: None
- Envelope: Trimmed short (no tail)
- Level: Very low (felt, not heard)
- Routing: BUS_DRUMS
- Note: Removes flatness when muted

### DRIVE_SURGE — Canon Locked

- Source: 3xOSC mid-range oscillator stack
- Function: Aggression / pressure layer (no sub)
- Envelope: Fast attack, short decay, zero sustain
- EQ: Sub removed, mid emphasis
- Routing: BUS_BASS
- Status: Canon-locked, no further tweaks unless mix-stage conflict

### BASS_SURGE — Canon Locked

- Source: 3xOSC (sine + triangle)
- Role: Low-end body (between SUB and DRIVE)
- Envelope: Fast attack, medium decay, no sustain
- EQ: HP ~50Hz, body emphasis ~100Hz
- Routing: BUS_BASS
- Gain: Controlled via Channel Rack knob
- Status: Canon-locked
- Drum element processing: EQ → saturation on individual inserts only

### LEAD_SURGE — Canon Design

- Instrument: 3xOSC (dual saw)
- Function: rhythmic identity signal
- Envelope: instant attack, short release
- Pattern: off-beat, kick-locked, single-note
- Routing: LEAD_SURGE → BUS_SYNTH → PRE_MASTER

# STAB_SURGE — Canon Entry

**Status:** CANON LOCKED  
**Role:** Harmonic impact / rhythmic chord stab  
**Context:** SURGE System — FEN-01

---

## Sound Source

- **Instrument:** 3xOSC
- **Oscillator Configuration:**
  - OSC 1: Saw (primary body)
  - OSC 2: Square (harmonic bite)
  - OSC 3: Phase-modulated / widened layer
- **Detune:** Subtle (controlled, no chorus drift)
- **Phase:** Aligned (no random phase for transient consistency)

---

## Envelope (Volume)

- **Attack:** Very short (near-instant)
- **Hold:** Minimal
- **Decay:** Short–medium (defines stab length)
- **Sustain:** Low / near zero
- **Release:** Short (clean cut, no tail smear)

Purpose:  
> Create a sharp, percussive harmonic hit that locks to groove without overlapping bass or lead.

---

## Filter

- **Type:** Low Pass (LP)
- **Cutoff:** Mid–high (removes harsh top, keeps presence)
- **Resonance:** Low
- **Modulation:** Static (no envelope modulation)

---

## Processing Chain (Insert 3 — STAB_SURGE_CANON)

1. **Fruity Parametric EQ 2**
   - HP @ ~150–250 Hz (remove low conflict with bass)
   - Gentle dip if needed in harsh midrange
2. **Fruity Blood Overdrive**
   - Low drive
   - Used for harmonic density, not distortion

---

## Routing

- **Channel Rack → Insert 3 (STAB_SURGE_CANON)**
- **Insert 3 → BUS_SYNTH**
- **BUS_SYNTH → PRE_STER → MASTER**

---

## Pattern Role

- Off-beat / syncopated placement
- Reinforces rhythmic tension during DROP and PEAK sections
- Doe

# FX_SURGE — Canon Entry

**Status:** CANON LOCKED  
**Role:** Transitional energy / motion layer  
**Context:** SURGE System — FEN-01

---

## Sound Source

- **Instrument:** 3xOSC / Sampler (Noise-based)
- **Waveform:** Noise or high-frequency waveform
- **Phase:** Controlled (no random smear)

---

## Envelope (Volume)

- **Attack:** Short–medium
- **Hold:** 0
- **Decay:** Medium
- **Sustain:** 0
- **Release:** Medium–short

Purpose:  
> Create movement and tension without percussive impact.

---

## Filter

- **Type:** LP or BP
- **Cutoff:** Mid-range (automatable)
- **Resonance:** Low–medium
- **Modulation:** Slow movement (manual or LFO)

---

## Processing Chain (FX_SURGE_CANON)

1. **Fruity Parametric EQ 2**
   - HP @ 300–500 Hz
   - Shape harsh highs if needed
2. **Fruity Blood Overdrive**
   - Very low drive
   - Texture only
3. *(Optional)* Short reverb (controlled tail)

---

## Routing

- **Channel Rack → FX_SURGE_CANON insert**
- **Insert → BUS_SYNTH**
- **BUS_SYNTH → PRE_STER → MASTER**

---

## Pattern Role

- Transitional layer
- Used before drops, fills, and phrase changes
- Never constant — placement is intentional

---

## Canon Notes

- Must not dominate mix
- Supports tension, not melody
- Keep mono-safe core
- Automate sparingly

**Canon Lock Date:** 2025-12-20  
**Engineer:** Echo//Forge  
**System:** SURGE

### FX_SURGE (Mech Growl)

- Role: Transitional / tension accent
- Placement: Pre-drop or post-stab only
- Density: Sparse (1 per 4–8 bars)
- Routing: BUS_SYNTH
- Gain staged low to preserve kick dominance

### RISE_SURGE

- Role: Transitional energy / pre-impact tension
- Source: Noise (3xOSC)
- Envelope: Slow attack, zero tail
- Filter: LP with rising cutoff automation
- Placement: Pre-drop / pre-peak only
- Routing: BUS_FX

## A4 — IMPACT_SURGE (Canon Build)

**Project:** FEN-01_SURGE_TEMPLATE_CANON  
**BPM:** 202  
**Date:** 2025-12-20

### IMPACT_SURGE_CANON

- **Role:** Transition slam (Drop / Peak / Release punctuation)
- **Routing:** IMPACT_SURGE_CANON → IMPACT insert → BUS_FX → PRE_MASTER → MASTER
- **Insert chain:** EQ2 → Blood Overdrive → (Optional) Reverb 2
- **Placement:** 
  - Main hits: DROP_01 / PEAK_01 / RELEASE_01
  - Pre-hit: 1 bar before DROP_01 (lower velocity)

### Mix Headroom Snapshot

- BUS_DRUMS: ~-8 dB
- BUS_SYNTH: ~-7 dB
- RISE_SURGE: ~-14 dB
- Master target: peak ≤ -3 dB during writing

SURGE — Production Notes
BPM: 202
Structure: Intro → Build → Drop → Peak → Release → Drop → Outro
Core Elements: Kick/Sub Canon locked
Automation: Bus-level energy sculpting only
Status: Arrangement locked, automation in progress
