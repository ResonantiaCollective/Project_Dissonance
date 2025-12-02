# COMBAT ENGINE CODEX v1  
## SECTION 06 — ABILITY SYSTEM  
*Identity → Action → Power*

---

## 6.0 Purpose of the Ability System

The Ability System defines how special actions behave:

- Player skills  
- Enemy skills  
- Card abilities  
- Passive triggers  
- Transformations  
- Overdrive / Shadow Overdrive abilities  

Abilities are **rule sets** layered on top of the Action Framework.

Every ability:

1. Generates an action  
2. Passes through the Resolution Pipeline  
3. Creates outcome packets  
4. Integrates cleanly with rhythm and corruption

---

## 6.1 Ability Categories

### **A) Offensive Abilities**
Directly cause damage or apply harmful statuses.

Examples:
- Sonic Slash  
- Pulse Burst  
- Glitch Lance  
- Burning Rift  
- Corrosion Needle  
- Frequency Shot  

---

### **B) Defensive Abilities**
Mitigate, shield, or cleanse.

Examples:
- Barrier Field  
- Rhythm Guard  
- Cleanse Pulse  
- Harmonic Shell  
- Resonant Shield  

---

### **C) Utility Abilities**
Movement, repositioning, setup, resource manipulation.

Examples:
- Phase Step  
- Void Dash  
- Drop Amplifier  
- Bass Anchor  
- Overdrive Convert  

---

### **D) Special / Transformative Abilities**
Shift the rules temporarily.

Examples:
- Shadow Overdrive  
- Pulse Ascension  
- Fearbreak  
- Corruption Surge  
- Time Fracture  

These often introduce temporary abilities or statuses.

---

## 6.2 Ability Data Model

All abilities use a shared schema to ensure compatibility with the engine:

```jsonc
Ability {
  id: string,
  name: string,
  category: string,            // offensive, defensive, utility, special
  description: string,
  ability_type: string,        // projectile, melee, ranged, aura, etc.
  cost: {
    energy: int,
    hp: int,
    cooldown: float
  },
  base_scaling: {
    stat: string,              // ATK, FCS, VIT
    multiplier: float
  },
  range: float,
  area: object|null,           // cones, circles, rays
  statuses_applied: [string],  // references Status IDs
  rhythm_affinity: string,     // perfect/good/late scaling bias
  corruption_affinity: string, // how corruption distorts the ability
  tags: [string],              // e.g., "bleed", "fire", "burst", "drop"
  metadata: object             // free-form for scripting
}
Even complex abilities break down into this structure.

6.3 Ability Lifecycle
Abilities follow a lifecycle inside the Combat Engine:

Select
Player presses button / Enemy AI chooses

Validate
Resources, cooldowns, states

Generate Action
Using the Action Framework

Bind to Rhythm
Makes the ability timing-sensitive

Resolve
Uses Resolution Pipeline (damage, healing, statuses, etc.)

Finalize & Propagate
Ability effects are sent to VFX/SFX/AI/UI

Cooldown/Aura Management
Modify or set cooldown timers, durations, aura state

No ability bypasses this sequence.

6.4 Scaling Rules
Primary Scaling
Matches the stat chosen in base_scaling.stat.

Examples:

ini
Copy code
damage = ATK * multiplier
damage = FCS * multiplier
healing = VIT * multiplier
Secondary Scaling
Some abilities scale with:

SPD (projectile speed or tick frequency)

RHM (timing forgiveness)

RESOLVE (resistance / immunity effects)

Secondary scaling provides advanced tuning.

6.5 Rhythm Affinity
Each ability has a rhythm_affinity that changes how it responds to rhythm.

Example values:

precision → large boost on PERFECT

flex → even bonuses across GOOD/PERFECT

chaos → benefits from LATE

null → rhythm determines crit only

Example:

nginx
Copy code
if rhythm_affinity == "precision" and rhythm_quality == PERFECT:
    damage *= 1.35
Abilities can invert quality under corruption.

6.6 Corruption Affinity
Abilities can behave wildly under corruption.

Examples:

“Glitch” → may fire twice

“Void” → changes damage element

“Chaos” → damage oscillates heavily

“Stable” → lower corruption impact

“Reactive” → triggers corruption-based effects

This affinity is read in Stage 5 of the Resolution Pipeline.

6.7 Cooldowns
Cooldowns are tracked per ability instance:

start on ability use

modified by:

SPEED

statuses

corruption

minimum cooldown (safety limit)

maximum cooldown (rare, for transformations)

Cooldown formula (example):

ini
Copy code
effective_cd = base_cd * (100 / (100 + SPD))
Cooldowns never drop below 10% of their base unless a special mechanic overrides.

6.8 Area & Targeting Rules
Abilities define:

single target

multi-target

area-of-effect

ground-target

directional cone

piercing ray

self-only

The Ability System handles intention,
the Combat Engine handles resolution.

Example:

go
Copy code
if ability.area.type == "cone":
    targets = actors_in_cone(actor, target_position, area_angle, area_range)
6.9 Status Application Rules
Statuses applied by abilities reference the Status System:

Multiple statuses can apply

Chance modified by FCS and rhythm quality

Target can resist via RESOLVE

Corruption mutates statuses into variants

Example:

makefile
Copy code
bleed_chance = ability_base_chance + (FCS * 0.1)
if rhythm_quality == PERFECT:
    bleed_chance += 10%
6.10 Special / Transformative Abilities
These abilities temporarily override game rules.

Examples:

Shadow Overdrive
massively boosts SPD, FCS

shrinks LATE window

increases corruption interactions

applies corruption aura status

replaces basic attack with corrupted variant

Pulse Ascension
expands PERFECT window

boosts crit chance

generates rhythm sync status

grants temporary invulnerability on PERFECT guard

All special abilities are implemented using:

one or more statuses

modified cooldown rules

conditional triggers

scripted metadata

6.11 Ability Failure Modes
Abilities can fail early due to:

insufficient resources

invalid target

actor stunned / frozen

conflict with another action

corruption backlash

Failures return a result packet with:

vbnet
Copy code
type: "ability_fail"
reason: "INVALID_TARGET" | "INSUFFICIENT_RESOURCES" | ...
No other pipeline stages execute.

6.12 Ability System Integrity Rules
Abilities must always map to an Action Framework type.

Abilities cannot bypass cooldown rules.

Special abilities must use statuses, not engine hacks.

Damage formulas must use Resolution Pipeline stages.

Rhythm affinity must never create infinite crit loops.

Corruption affinity must never bypass defense entirely.

Cooldowns must remain deterministic after replays.

These keep the Ability System clean, stable, and future-proof.