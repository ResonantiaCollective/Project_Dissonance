
---
# COMBAT ENGINE CODEX v1.0  
## SECTION 4 — STATUS EFFECTS & CONDITION SYSTEM

### Technical Layer

Statuses govern buffs, debuffs, DoTs, corruption effects, and control (CC).

All statuses use a unified data structure.

---

### 4.1 Status Data Structure

```json
{
  "id": "slow",
  "type": "buff | debuff | dot | corruption | control",
  "duration_beats": 4,
  "stacking_rule": "replace | override | accumulate",
  "tick_behavior": "per_beat | per_second | on_trigger",
  "modifiers": { }
}

4.2 Status Categories

Buff

Power Surge, Harmony Blessing, Flow Amplifier, Armor Up…

Debuff

Vulnerable, Armor Break, Weakness, Resonance Seal, Disrupted Beat…

DoT

Burn (physical), Resonance Bleed, Corruption Rot…

Corruption

Rift Infection, Shadow Leak, Entropy Sickness, Fracture Mark…

Control

Stun, Root, Snare, Silence, Confusion, Phase Lock, Stagger…

4.3 Stacking Rules

replace — new instance replaces old

override — stronger replaces weaker

accumulate — numeric accumulation

Example (accumulate):
Burn stack 1 → 3 dmg / beat  
Burn stack 2 → 6 dmg / beat  
Burn stack 3 → 9 dmg / beat

4.4 Duration Model

Most statuses use beat-based durations:
duration_beats = 4
tick_behavior  = per_beat
Corruption Rot may be per-second for entropy flavor.

4.5 Rhythm-linked Behavior

Beat quality can modify status:
Perfect: double duration or strength
Good:    normal
Poor:    reduced
Offbeat: may invert or interact with Dissonance

4.6 Trigger-linked Behavior

Triggers (Drop, Peak, Bass) can:

apply statuses

evolve existing ones

cleanse or nullify them

Example:

Drop → “Fury Mark” (damage up)

Peak → “Phase Overload” (boss phase shift)

Bass → “Pulse Armor” (armor up)

4.7 Corruption Status Interactions

Corruption stacks may:

increase entropy damage

push towards Shadowborn state

invert rhythms

Example:
entropy_mult = 1 + (Dissonance * 0.05)
if corruption_units >= 100:
    enter_shadow_state()

4.8 Dispel Types

Cleanse → removes debuffs & DoTs

Purify → removes corruption statuses

Nullify → removes buffs / positive statuses

4.9 Godot Implementation (StatusController)

A dedicated component:
StatusController.gd
├ apply_status()
├ remove_status()
├ tick_statuses()
├ calculate_modifiers()
├ serialize_statuses()
└ sync_to_combat_log()
Tick driven by BeatBus events.

Lore Layer

4.1 Status as Echo Imprints

“A status is a memory etched into a being’s waveform.”

Buffs = blessings of Pulse
Debuffs = fractures of rhythm
Corruption = whisper of the Rift

4.2 Three Forms of Harm

Harm of Flesh → physical

Harm of Tone → resonance

Harm of Void → corruption

4.3 Control as Spiritual Paralysis

“When the inner beat falters, the body forgets to move.”

4.4 Triggers as Heavenly Decrees

Drops / Peaks / Bass are omens in scripture; statuses shifting with them reflects divine influence.

4.5 Corruption as Entropy Truth

“Entropy is the honesty of broken things.”

4.6 Dispel as Purification

“To cleanse is to return to the first tone.”