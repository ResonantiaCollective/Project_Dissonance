# PLAYER ENGINE CODEX v3.0  
## SECTION 04 — TRANSFORMATION STATES  
*Power is not static. It is a phase.*

---

## 4.0 Purpose

Transformation States are **temporary forms** that alter the Operative’s rules:

- stats  
- abilities  
- movement  
- rhythm windows  
- corruption sensitivity  
- resource consumption  
- action privileges  

They are the most powerful tools available to an Operative—and the most dangerous.

Transformations can be:

- controlled  
- reactive  
- corruption-triggered  
- temporary  
- unstable  

This section defines how they work and how the Player Engine manages them.

---

## 4.1 Transformation Categories

### **A) Overdrive (OD)**  
Controlled transformation triggered by the player.  
Predictable, stable, enhances performance.

### **B) Shadow Overdrive (SOD)**  
Corruption-triggered transformation.  
Unstable, extremely powerful, risky.

### **C) Form Shifts**  
Alternate ability sets or stances (future expansions).  
e.g. gun form ↔ blade form.

### **D) Environmental States**  
Triggered by zones, world events, or boss effects.  
e.g. Gravity Flux, Time Distortion, Pulse Echo.

---

## 4.2 Transformation Data Model

All transformations share a unified structure:

```jsonc
TransformationState {
  type: string,                // OD, SOD, FORM_SHIFT, ENV_STATE
  active: bool,
  duration: float,
  max_duration: float,
  stat_modifiers: object,      // ATK_UP, SPD_UP, etc.
  ability_overrides: object,   // replaces certain abilities temporarily
  movement_modifiers: object,  // dash distance, speed changes, i-frames
  rhythm_modifiers: object,    // window_expand/shrink
  corruption_modifiers: object, // stability changes
  entry_conditions: [string],
  exit_conditions: [string],
  on_enter_events: [string],
  on_exit_events: [string]
}
The Player Engine is responsible for running and updating these.

4.3 Overdrive (OD)
OD is a stable transcendence state.

Activation Requirements:
OD resource must be ≥ max

can_transform == true

Player presses the Overdrive button

OD Effects:
+ATK (moderate)

+SPD (moderate)

+FCS (slight, for crit consistency)

+RHM (expanded PERFECT window)

reduced Energy cost

reduced OD decay during PERFECT hits

upgraded basic attacks

visual enhancements (FX handled by external systems)

OD Decay:
While active:

nginx
Copy code
current_od -= od_decay_rate * delta_time
Decay pauses briefly after PERFECT rhythm events.

4.4 Shadow Overdrive (SOD)
SOD is the corrupted transcendence state.
It is NOT activated manually.

Trigger Conditions (any of):
OD reaches max under corruption ≥ threshold

corruption spike event

specific SOD-flagged abilities in a combo

corruption storm in the environment

boss corruption blast

SOD Properties:
ultra-high ATK/FCS spike

significantly increased SPD

drastically narrowed GOOD/LATE windows

expanded PERFECT window (but harder to achieve due to speed)

altered movement (drift, teleport-like bursts)

corrupted variants of abilities

HP drain or OD drain over time

high corruption instability (risk of collapse)

SOD Risk:
may prematurely collapse (forced exit)

may cause self-damage if instability spikes

movement may jitter under severe corruption

targeting may distort slightly

SOD Termination Events:
duration expires

instability > threshold

HP reaches critical

enviromental corruption stabilizes

manual purge action (if unlocked)

4.5 Form Shifts (Future-Proof)
These are controlled stances or modes.

Examples:

Sword ↔ Gun

Light Form ↔ Heavy Form

Rhythm Form ↔ Chaos Form

Form Shifts modify:

ability sets

action privileges

resource consumption

rhythm interaction

Can be combined with OD, NOT with SOD (unless supported by design).

4.6 Environmental Transformations
Zones may impose temporary states:

Gravity Flux

Pulse Storm

Rhythm Echo

Corruption Fog

They modify:

movement

rhythm windows

status resistances

corruption stability

Environmental states are external and have higher priority than OD.

4.7 Transformation Lifecycle
Transformations follow this lifecycle:

Check Entry Conditions

Apply stat modifiers

Override abilities (if any)

Modify action privileges

Modify rhythm windows

Modify corruption stability

Tick duration

Check Exit Conditions

Revert all changes

Trigger exit events

This lifecycle repeats every frame/beat.

4.8 Transformation Priority
When multiple transformations attempt to activate:

Priority order:

Environmental States

Shadow Overdrive (SOD)

Overdrive (OD)

Form Shifts

Only one transformation of each layer may be active at once.

4.9 Stat Modifiers in Transformations
Stat modifiers are applied as temporary statuses:

additive first

multiplicative second

override final (for special conditions)

Example OD modifiers:

makefile
Copy code
ATK_UP: +25%
SPD_UP: +15%
RHM_UP: +10%
Example SOD modifiers:

makefile
Copy code
ATK_UP: +60%
SPD_UP: +40%
RHM_UP: +25%
RSL_DOWN: -50% (instability)
4.10 Transformation Integrity Rules
Transformations must always revert cleanly.

OD cannot be activated inside SOD.

SOD override priority must always be respected.

Transformations must update the Combat Stat snapshot.

No transformation may bypass the Action Framework.

Rhythm modifiers must remain within safe bounds.

SOD instability must never instantly kill the player (unless extreme design).

Environmental states override but do not delete transformation effects.

Transformation logs must be saved with timestamps.

Transformations must remain deterministic on replay.

