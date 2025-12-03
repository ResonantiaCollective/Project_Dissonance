# PLAYER ENGINE CODEX v3.0  
## SECTION 06 — CORRUPTION INTERACTION LAYER  
*The Pulse is order. Corruption is distortion.*

---

## 6.0 Purpose

Corruption is the **chaos axis** of Project Dissonance.

It influences:

- stats  
- rhythm windows  
- targeting  
- movement  
- resource systems  
- transformation triggers  
- instability  
- player survivability  

This section defines how corruption affects *Operatives specifically*.

The Combat Engine has its own corruption layer — this is the PERSONAL layer.

---

## 6.1 Corruption Types

There are 3 fundamental forms:

### **1. Personal Corruption (PC)**  
The Operative’s internal corruption value.  
A personal meter that rises/falls based on gameplay.

### **2. Environmental Corruption (EC)**  
Corruption present in the zone/world.  
Affects all actors inside it.

### **3. Corruption Events (CE)**  
Sudden spikes (enemy attacks, zone anomalies, SOD effects).  
Short bursts or instant distortions.

---

## 6.2 Personal Corruption Model

Stored as:

```jsonc
CorruptionState {
  current: float,
  max: float,
  stability: float,
  instability: float,
  corruption_level: int,   // tiered thresholds
  last_spike_time: float
}
Where:

current = raw corruption

stability = resistance to corruption

instability = how volatile corruption is

corruption_level = tier: 0, 1, 2, 3, “Breach”

6.3 Corruption Thresholds
Each tier has increasingly severe distortions:

Level 0 — Clean
Minimal corruption. No effects.

Level 1 — Distorted
small rhythm shrink

tiny chance of ability corruption

Level 2 — Unstable
jittered movement

increased late → miss conversion

corruption variants of abilities possible

Level 3 — Fractured
corrupted abilities default

movement drift

targeting distortions

increased instability gain

Level 4 — BREACH
forced Shadow Overdrive

massive instability

cannot stabilize naturally

must purge or die

6.4 Corruption Gain Sources
Operatives gain corruption from:

taking corruption-type damage

standing in corrupted zones

receiving corruption statuses

using corruption-aligned abilities

being affected by corruption storms

SOD interactions

late rhythm inputs (chance-based)

6.5 Corruption Loss Sources
Corruption can be reduced by:

purge abilities

environmental cleanses

narrative sanctuaries

perfect rhythm streaks

OD stability (during OD only)

6.6 Instability System
Instability determines whether corruption remains manageable or spikes out of control.

Instability increases when:

corruption rises too quickly

MISS rhythm inputs at high corruption

enemy corruption spike attacks

SOD instability effects

environmental anomalies

Instability decreases when:

perfect rhythm chains

OD stabilizers

specific abilities or cards

6.7 Corruption → Rhythm Interaction
Corruption distorts rhythm:

window compression

timing drift

inversion (GOOD → LATE)

ghost windows (false PERFECTs)

rhythm floor spikes (miss unless timed perfectly)

Severity depends on corruption_level and instability.

6.8 Corruption → Movement Interaction
slight drift (Level 2+)

jittered dash

delayed acceleration

corrupted burst movement (random micro-teleport events)

input inversion (rare, high-level corruption only)

All effects must have audiovisual cues.

6.9 Corruption → Stat Interaction
Stats are temporarily distorted:

Low corruption:
FCS distortion (precision loss)

RHM distortion (window shrink)

High corruption:
PWR spikes

SPD jitter

RSL_OP collapse

VIT_OP may dip (corrupted self-harm chance)

These distortions stabilize when corruption drops below threshold.

6.10 Corruption → Abilities
Corruption can:

mutate abilities into corrupted variants

increase variance of damage

cause ability duplication

force ability misfires

empower certain dark archetypes

Corrupted ability variants must remain readable and intentional.

6.11 Corruption → Resource Engines
Energy:
regen may flicker

heavy corruption: regen inversion

Overdrive:
increased gain

decreased stability

Shadow Overdrive:
may trigger early

duration modified

collapse risk increased

6.12 Corruption → Transformations
Corruption determines SOD activation and behavior.

Examples:

OD at high corruption → instant SOD

high instability → forced SOD collapse

breach level → transformation lock

6.13 Environmental Corruption (EC)
Zones may apply EC that stacks additively with Personal Corruption.

Levels of EC:

Ambient — subtle distortion

Bleeding Pulse — rhythm drift

Fracture Field — movement distortion

Corruption Storm — rapid corruption gain

Abyss — forced Breach state

Zone Engine defines sources; Player Engine applies effects.

6.14 Purification & Cleansing
Operatives may remove corruption through:

abilities (Cleanse Pulse)

sanctuaries

OD stabilization

rhythm mastery feats

environmental purifiers

rare items/cards

Purification must be deliberate, not automatic.

6.15 Integrity Rules
Corruption must never permanently alter stats without explicit design.

Corruption distortions must always have clear patterns.

Instability cannot instantly kill the player (unless Breach design).

Corruption-driven transformations must follow defined thresholds.

Corruption must interact with rhythm predictably.

Corruption events must be logged with timestamps.

Environmental corruption cannot override personal corruption caps.

Corruption variants of abilities must remain readable.

Purification must always reset distortions correctly.

Corruption effects must be deterministic on replay.

