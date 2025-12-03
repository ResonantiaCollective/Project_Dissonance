# PLAYER ENGINE CODEX v3.0  
## SECTION 05 — RHYTHM INTERACTION LAYER  
*The Pulse is not a background — it is a law.*

---

## 5.0 Purpose

Rhythm is a **core mechanic** of the Player Engine.  
It influences nearly every action the Operative takes:

- attacks  
- abilities  
- guards  
- movement bursts  
- resource generation  
- transformations  
- corruption stability  

This section defines how rhythm is measured, interpreted, and used inside the Player Engine.

---

## 5.1 Timing Windows

There are four canonical rhythm qualities:

1. **PERFECT**  
2. **GOOD**  
3. **LATE**  
4. **MISS**

Timing windows are influenced by:

- **RHYTHM MASTERY (RHM_OP)**  
- **statuses** (Sync, Desync, Tempo Shift, etc.)  
- **transformations** (OD/SOD)  
- **corruption effects**  

---

## 5.2 Timing Window Structure

Each window has:

```jsonc
TimingWindow {
  perfect: float,   // ms or beats
  good: float,
  late: float,
  miss: float
}
Example baseline values:

ini
Copy code
perfect = 40ms
good    = 100ms
late    = 80ms
MISS is anything outside all other windows.

5.3 Window Modification
RHM_OP increases:
perfect window

good window

reduces harshness of late penalties

OD modifies:
slightly expands perfect

slightly expands good

reduces late

stabilizes rhythm timing (less jitter from corruption)

SOD modifies:
expands perfect massively

collapses good

heavily penalizes late

removes late → MISS forgiveness

may invert timing drift under high corruption

Statuses can:
temporarily expand (Sync)

temporarily shrink (Desync)

lock windows to a very small value (Pulse Shock)

5.4 Rhythm Input Processing
Whenever the player performs an action affected by rhythm, the Player Engine:

Receives timestamp of input

Fetches the current beat timing from the Rhythm Engine

Computes delta to nearest beat

Compares delta to timing windows

Returns quality: PERFECT, GOOD, LATE, or MISS

Sends timing result to the Action Framework

Applies timing-based effects (bonuses, penalties)

This is deterministic and synced with the audio/metronome system.

5.5 Action Effects by Rhythm Quality
Rhythm influences:

ATTACKS:
PERFECT: +25% damage, +crit chance

GOOD: +10% damage

LATE: −20% damage

MISS: zero damage / whiff

ABILITIES:
PERFECT: enhanced scaling (varies by ability)

GOOD: stable performance

LATE: increased corruption chance

MISS: ability fizzles (depending on ability rules)

MOVEMENT (Dash/Burst):
PERFECT: extended distance, i-frames

GOOD: slight speed boost

LATE: reduced distance

MISS: stumble or reduced acceleration

GUARD:
PERFECT: massive mitigation + reflect

GOOD: solid block

LATE: reduced block

MISS: no block

5.6 Rhythm → Resource Effects
Energy:
PERFECT: small refund

LATE: increased energy cost (optional mechanic)

Overdrive:
PERFECT: large OD gain (+20–40%)

GOOD: moderate OD gain

LATE: low OD gain

MISS: potential OD loss

Shadow Overdrive:
PERFECTs inside SOD stabilize corruption.
MISS during SOD destabilizes and accelerates collapse.

5.7 Rhythm → Corruption Interaction
Corruption distorts rhythm in three ways:

1. Timing Drift
Actual response window is shifted slightly forward or backward.

2. Window Compression
Good/Late shrink unpredictably.

3. Inversion Events
A GOOD becomes LATE, or LATE becomes MISS.

The stronger the corruption, the more frequent and severe these effects.

5.8 Rhythm States & Statuses
Rhythm-aligned statuses:

Sync
Expands windows

Improves resource gain

Stabilizes OD

Desync
Shrinks windows

Increases corruption interactions

Reduces crit sync bonuses

Pulse Echo
Next PERFECT window is doubled

Pulse Lock
Next action must land PERFECT or is forced to MISS

5.9 Rhythm Snapshots
Before every action is resolved, the Player Engine generates a Rhythm Snapshot:

jsonc
Copy code
RhythmSnapshot {
  rhythm_quality: string,   // PERFECT, GOOD, LATE, MISS
  delta_ms: float,
  window_perfect: float,
  window_good: float,
  window_late: float,
  corruption_offset: float
}
This snapshot is passed to:

Action Framework

Combat Engine (for scaling)

Resource systems

Transformation systems

5.10 Integrity Rules
Rhythm evaluation must be deterministic for the same input.

Corruption cannot randomize windows beyond safe caps.

Timing windows must always be calculable from Operative stats.

Rhythm modifiers must never multiply infinitely.

Rhythm must never cause actions to become unpredictable without signal.

SOD rhythm alterations must remain readable and reactable.

Rhythm effects must not bypass the Resolution Pipeline.

PERFECT windows must be attainable but never trivial.

Rhythm must never override input priority.

Rhythm logs must be preserved for debugging and analytics.

