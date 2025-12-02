# COMBAT ENGINE CODEX v1  
## SECTION 04 — STATUS SYSTEM

---

## 4.0 Purpose of the Status System

The Status System governs all persistent effects that modify an actor over
time:

- buffs  
- debuffs  
- damage-over-time (DoT)  
- heal-over-time (HoT)  
- corruption effects  
- shields  
- stuns, freezes, fears  
- rhythm modifiers  
- conditional triggers  

Status effects are one of the primary bridges between:

- the **Action Framework** (Section 02)
- **Combat Stats** (Section 03)
- the **Resolution Pipeline** (Section 05)

Statuses change the rules — temporarily or conditionally.

---

## 4.1 Status Categories

Every status belongs to exactly one of these categories:

### **A) Harmful Statuses**  
Effects that negatively impact the actor.

Examples:
- Burn  
- Bleed  
- Corruption Spike  
- Weaken  
- Armor Break  
- Rhythm Desync  
- Fear  
- Slow  
- Poison  

---

### **B) Beneficial Statuses**  
Effects that empower the actor.

Examples:
- Strength Up  
- Defense Up  
- Rhythm Sync  
- Crit Boost  
- Regen  
- Overdrive Surge  
- Cleanse Aura  

---

### **C) Conditional Modifiers**  
Statuses that watch for conditions and fire additional actions.

Examples:
- “Next PERFECT hit deals double damage”  
- “Next time actor is struck, apply burn”  
- “If HP drops below 30%, trigger shield”  
- “On rhythm MISS, reduce SPD for 2s”  

These are the programmable glue of the system.

---

### **D) Special States**  
Transformation states or hard locks.

Examples:
- Stun  
- Freeze  
- Silence  
- Shadow Overdrive  
- Invulnerability  
- Phase Shift  

Special states override parts of the Action Framework.

---

## 4.2 Status Data Model

Every status effect follows a shared schema so the Combat Engine can treat
them uniformly.

```jsonc
Status {
  id: string,              // unique identifier
  category: string,        // harmful, beneficial, conditional, special
  stacks: int,             // current stack count
  max_stacks: int,         // optional
  duration: float,         // seconds or beats
  tick_rate: float,        // how often DoT/HoT ticks occur
  source_actor: string,    // who applied the status
  modifiers: object,       // stat or rule modifications
  flags: [string],         // e.g. "undispellable", "persistent"
  metadata: object         // custom fields for abilities/cards/scripts
}
Statuses may have custom logic, but they must obey this shape.

4.3 Tick Logic

Tick logic applies to any status with an ongoing effect.

Examples:

Bleed → damage tick

Regen → healing tick

Burn → damage tick with variance

Corruption Pulse → distortion tick

Rhythm Sync → timing window adjustment tick

Formula (conceptual):
on_tick:
  apply_effect()
  reduce_duration(tick_rate)
  if duration <= 0:
      expire()
Tick rate can be influenced by SPD or RHYTHM MASTERY (RHM).

4.4 Stacking Rules

Statuses stack according to one of three modes:

1. Additive

Each stack increases power linearly.
e.g. Bleed dealing +2 damage per stack.

2. Multiplicative

Stacks amplify the effect exponentially.
Used sparingly for powerful mechanics.

3. Refresh

Effect does not stack — duration resets instead.

Examples:

Poison → additive

Harmony Sync → refresh

Weaken → multiplicative

Burn → additive

Slow → refresh

Stacking rules prevent status effects from spiraling out of control.

4.5 Status Modifiers

Statuses modify actor stats or engine rules.

Common modifiers include:

ATK_UP / ATK_DOWN

DEF_UP / DEF_DOWN

FCS_UP / FCS_DOWN

SPD_UP / SPD_DOWN

RHM_UP / RHM_DOWN

Special modifiers:

window_expand (rhythm GOOD/PERFECT enlarged)

window_shrink

crit_boost

corruption_amplify

damage_redirection

shield

invulnerability

stun_lock

Modifiers follow:

additive stacking

multiplicative stacking

exclusive overrides (for special states)

4.6 Status Interaction with Rhythm

Statuses can modify rhythm, or be triggered by rhythm.

Examples:

Burn → stronger on LATE attacks

Rhythm Sync → bigger PERFECT window

Desync → harsher MISS penalties

Drop Fever → massive crit bonus on PERFECT

Bass Resonance → shield pulses on alternating beats

Statuses and timing interact constantly — this is a core identity of the game.

4.7 Status Interaction with Corruption

Corruption is the wild variable of the status system.

Examples of corruption-driven behavior:

Bleed ticks may glitch and hit twice

DEF buffs may fracture (stop working)

RHM buffs may invert (shrink timing windows)

Burn may spike into “Abyss Burn”

Fear may escalate into “Panic”

Poison may mutate into “Corrosion”

Corruption never replaces a status — it distorts it.

4.8 Status Expiration

When a status reaches duration 0, it expires cleanly:

Remove modifiers

Remove flags

Trigger any “on_expire” effects

Clear from actor status list

Statuses must never linger after expiration.
This is a rule enforced to prevent “ghost statuses.”

4.9 Status Priority

When multiple statuses apply at once, priority is:

Special States

Beneficial Buffs

Harmful Debuffs

Conditional Modifiers

This determines which modifiers override or persist.

Example:
Invulnerability (special state) always overrides damage ticks.

4.10 Cleansing & Immunity

Actors may have:

partial cleanses

full cleanses

status-specific immunities

corruption immune phases

lockouts (cannot receive certain buffs/debuffs)

Cleanses remove:

harmful statuses

conditional modifiers

Special states can be immune or partially immune.

4.11 Status System Integrity Rules

To maintain stability, the Status System follows these laws:

Status effects must not stack infinitely.

Special states override buffs/debuffs unless explicitly allowed.

Corruption cannot delete a status — only distort.

Duration cannot go negative.

Status resolution cannot break Action order.

Expired statuses must immediately disappear.

Tick logic must never produce recursive actions (infinite loops).

These rules are mandatory to prevent engine instability.