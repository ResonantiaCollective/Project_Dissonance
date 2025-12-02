
---
# COMBAT ENGINE CODEX v1.0  
## SECTION 2 — ACTION TYPES & RESOLUTION LAYER

### Technical Layer

The Combat Engine recognizes three **primary** action classes and two **secondary** layers.

---

### 2.1 Primary Action Classes

#### A) Strike Actions

Direct offensive actions:

- Light / Heavy attacks
- Pulse strikes
- Corruption-infused slashes
- Ranged resonance shots

Key fields:

```text
base_damage
damage_type          # physical | resonance | corruption
cast_time
recovery_time
beat_sync_behavior   # requires beat? any time?
status_on_hit
can_crit
stagger_on_perfect
B) Ability Actions

Non-basic actions triggered by:

cards

talent unlocks

Overdrive / Shadow Overdrive

boss scripts

Key fields:

ability_id
cooldown_beats
activation_condition
beat_tier_bonus
resource_cost
corruption_gain
aoe_shape
range
visual_event_id

C) Movement Actions

Positioning-related:

dodge / dash / slide

blink / teleport

phase-walk

shadow shift

Key fields:

invuln_frames
distance
direction_mode     # stick / target-lock / camera
beat_cancel_timing
flow_scaling       # affects distance and recovery


Movement can cancel certain recovery frames depending on Flow.

2.2 Secondary Layers
1) Status Application Layer

Statuses may be applied by:

strikes

abilities

triggers

corruption events

auras

They are handled by the Status System (Section 4).

2) Resource Action Layer

Every action may modify:

Energy / stamina

Resonance buildup

Overdrive bar

Shadow corruption meter

Flow rhythm modulation

Enemy corruption_level

Updates happen after damage resolution.

2.3 Action Execution Timeline

All actions follow this pattern:

1. Input → Action identification
2. Beat window evaluation
3. Pre-hit conditions (range, LOS, resources)
4. Cast / windup
5. Hit frame
6. Damage calculation
7. Status application
8. Post-action recovery
9. Resource adjustments
10. Combat log event

2.4 Beat-linked Global Cooldown (GCD)

Instead of a classic MMO GCD, Resonantia uses a beat-based GCD:

if Flow < FLOW_GCD_THRESHOLD:
    gcd = 1 beat
else:
    gcd = 0.5 beat


This preserves rhythm precision while remaining fluid.

2.5 Queued Action System

To avoid input frustration, the system supports one queued action:

stored during cast/recovery/hitstop

executed on the next valid frame that satisfies:

GCD ready

cancel rules satisfied

Priority of queued actions:

Movement (dodge)

Card / Ability

Basic Strikes

Repeats (spam-protected)

2.6 Hitstop & Impact Rhythm

Hitstop = small time pause on impact.

Example tuning:

Perfect hit: 6 ms + Impact scaling
Good hit:    3 ms
Poor hit:    0 ms
Critical:    +4 ms
Boss targets: hitstop * 0.5


Hitstop reinforces:

feeling of impact

clarity of timing

rhythm pattern readability

Lore Layer
2.1 The Three Movements

Scripture mirrors the three primary actions:

“To strike is to speak.
To move is to breathe.
To invoke is to shape the world.”

Strike → speech

Movement → breath

Ability → reshaping reality

2.2 Beat Windows as Spiritual Timing

Perfect → The True Tone

Good → The Heard Tone

Poor → The Lost Tone

Off-beat → The Broken Tone

2.3 Windup & Recovery

Cast time:

“Before a blow is struck, purpose is forged.”

Recovery:

“Every act leaves an echo.”

2.4 Queued Actions as Premonition

“The Operative knows their next motion
before the first concludes.”

2.5 GCD as Breath Between Beats

Beat GCD:

“The space where rhythm inhales.”