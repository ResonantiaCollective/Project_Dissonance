# COMBAT ENGINE CODEX v1  
## SECTION 02 — ACTION FRAMEWORK

---

## 2.0 Purpose of the Action Framework

The **Action Framework** defines how any intention in Resonantia becomes a
gameplay event.

Whenever an Operative attacks, guards, moves, plays a card, or an enemy
casts an ability, the engine creates an **Action**.

The Action Framework answers:

- What kinds of actions exist?  
- How are they represented in data?  
- In what order do they resolve?  
- How do timing and rhythm attach to them?

The Action Framework feeds into the **Resolution Pipeline** (Section 05).

---

## 2.1 Action Types

At engine level, all gameplay behaviors are normalized into a small set of
action types:

- **basic_attack**  
  Standard player or enemy strike. No special resource cost.

- **ability_cast**  
  A skill or spell defined in the Ability System (Section 06).

- **card_play**  
  A card being activated from the deck / hand.

- **guard / block**  
  Defensive timing action that reduces or nullifies incoming damage.

- **movement**  
  Position change, dash, sidestep, teleport, etc.

- **system_trigger**  
  Engine-level actions such as Round Start, Round End, Phase Change.

- **status_tick**  
  Periodic application from an existing status (bleed, regen, burn).

- **environmental**  
  Hazards or zone-based events (spikes, lasers, collapsing tiles).

Each concrete move in the game maps to one of these types internally.

---

## 2.2 Action Lifecycle

Every action follows the same lifecycle:

1. **Create**  
   - Input or AI decision requests an action.  
   - Required data is assembled (actor, target, ability id, etc.).

2. **Queue**  
   - Action is placed into the Combat Engine queue for the current beat /
     frame.

3. **Validate**  
   - Engine checks:  
     - Is the actor alive and allowed to act?  
     - Are resources (energy, cooldown, ammo) available?  
     - Are targeting rules satisfied?  
   - If validation fails, the action is discarded with a failure reason.

4. **Bind to Rhythm**  
   - Timing offset and beat index are attached.  
   - Quality (PERFECT / GOOD / LATE / MISS) is determined.

5. **Resolve**  
   - The Resolution Pipeline transforms the action into concrete results  
     (damage, shields, status effects, meters, etc.).

6. **Propagate**  
   - Results are broadcast to:  
     - Animation system  
     - Audio system  
     - VFX  
     - AI / State machines

7. **Log**  
   - The action and its outcome are written into a combat log for analytics,
     replays, and debugging.

No action is allowed to bypass this lifecycle.

---

## 2.3 Action Data Model

At minimum, every action shares a common schema.

Example (conceptual):

```jsonc
Action {
  id: string,              // unique per action instance
  type: string,            // basic_attack, ability_cast, etc.
  actor_id: string,        // who performs the action
  target_ids: [string],    // one or more targets, may be empty
  source_position: Vector, // position at action creation
  target_position: Vector, // aim point or primary target pos
  ability_id: string|null, // reference into Ability data (if any)
  card_id: string|null,    // reference into Card data (if any)
  cost: {
    energy: int,
    hp: int,
    other: object
  },
  rhythm: {
    beat_index: int,       // which beat in the loop
    offset: float,         // time delta from ideal beat
    quality: string        // PERFECT, GOOD, LATE, MISS
  },
  tags: [string],          // e.g. "melee", "projectile", "finisher"
  metadata: object         // free-form, for systems to attach context
}
Sub-systems (Cards, Abilities, Triggers) extend this structure through
metadata or additional typed wrappers, but the Combat Engine always
sees an action in this normalized shape.

2.4 Rhythm Binding

The Action Framework connects directly to the Rhythm system.

When an action is queued for the current frame / beat:

The engine queries the rhythm module for:

current beat index

time since last beat

time until next beat

It computes the offset and classifies timing:

|offset| <= perfect_window → PERFECT

|offset| <= good_window → GOOD

|offset| <= late_window → LATE

else → MISS

This quality is stored in action.rhythm.quality and is later used by:

damage formulas

crit calculations

status application chances

Overdrive gain

enemy AI reactions (e.g. DESYNC punishments)

In this way:

No action is “timeless.”
Every action carries its beat.

2.5 Priority & Conflict Resolution

Multiple actions often occur in the same timestep / beat.
The Action Framework orders them with a priority system so that
resolution is deterministic.

Each action computes:

priority_layer — broad category, e.g.:

0: System actions (round start/end, phase change)

1: Defensive actions (guard, shield)

2: Offensive actions (attacks, abilities)

3: Status ticks and environmental

initiative_value — fine-grained ordering inside the layer.
Derived from:

actor speed

action type

corruption effects

special modifiers

Sorting rule:

Sort by priority_layer ascending

If tie, sort by initiative_value descending

If still tied, break by a stable rule (actor id) to keep replays
consistent.

This ensures:

System-level changes happen before damage

Guards can apply before incoming strikes

The same situation always produces the same resolution order.

2.6 Failure Modes

Not all actions succeed. The framework defines clear failure reasons
so other systems can react:

Common failure codes:

INVALID_TARGET — target dead, out of range, or no longer valid.

INSUFFICIENT_RESOURCES — energy, HP, or other cost missing.

INTERRUPTED — actor was staggered / stunned before resolution.

CONFLICT — mutually exclusive action already resolved this tick.

RULE_BLOCKED — engine-level rule prevents the action (e.g. global
silence).

On failure:

No Resolution Pipeline processing occurs.

A lightweight failure event is sent instead (for UI feedback,
sound cues, AI learning).

Because of this, errors do not corrupt combat — they are formalized.

2.7 Integration with Other Systems

The Action Framework connects to other codices as follows:

Player System Codex

Defines how player inputs generate actions and how stats modify
initiative and priority.

Enemy System Codex

Defines how AI state machines request actions, and how rhythm
sensitivity impacts their timing.

Ability System (Section 06)

Defines how ability data translates into action parameters (damage,
range, tags, costs).

Trigger Engine

Listens to actions and their rhythm quality to fire Drops, Peaks,
and Bass events.

The Combat Engine itself remains agnostic about who created an action.
It only cares about what the action is and how it should resolve.