---
# COMBAT ENGINE CODEX v1.0  
## SECTION 5 — PRIORITY STACK & RESOLUTION ORDER

### Technical Layer

Global priority of combat events:

```text
1. Beat Events
2. Player Input & Queues
3. Enemy AI Decisions
4. Trigger Events (Drop/Peak/Bass)
5. Player Abilities
6. Enemy Abilities
7. Player Strikes
8. Enemy Strikes
9. Status Applications
10. Resource Updates
11. Corruption Engine
12. Aftereffects
13. Combat Log

5.1 Full Combat Pipeline

Per tick / beat:
0. Clock tick → Beat check

1. Classify beat window (perfect/good/poor/offbeat)

2. Resolve player actions:
   - queued actions
   - dodge > ability > strike priority

3. Resolve enemy intent:
   - AI state machine
   - action selection

4. Apply trigger events:
   - Drop, Peak, Bass
   - modify actions / statuses / corruption

5. Resolve player abilities

6. Resolve enemy abilities

7. Resolve strike collisions:
   - hitboxes vs hurtboxes
   - i-frames / blocks / parries (future)

8. Calculate damage:
   - Impact / Harmony / Dissonance / Flow
   - damage types
   - armor / resistances
   - crits
   - corruption amplification

9. Apply statuses:
   - buffs / debuffs / DoTs / corruption / control
   - dispel logic

10. Update resources:
   - energy, Overdrive, Shadow meter, Flow

11. Corruption engine update:
   - corruption gain
   - reverse-sync checks
   - Shadowborn transitions

12. Aftereffects:
   - knockback, stagger, hitstop, FX

13. Combat log entry

5.2 Player vs Enemy Priority

By default, if simultaneous:

Player action resolves before enemy

Exception: Trigger-driven boss actions may pre-empt

Tie-breaker order:
1. Dodge
2. Trigger-based enemy actions
3. Player abilities
4. Enemy abilities
5. Player strikes
6. Enemy strikes
7. Damage events
8. Status events

5.3 Hit Protection System

To avoid unfair instant deaths:
Within a single beat window, a character cannot lose more than X% max HP,
unless:
- Staggered
- Shadow-corrupted
- Under boss phase transition rules
Default: X = 35% (tunable)

5.4 Godot Integration (CombatLoop)

High-level script:
CombatLoop.gd
├ process_beat()
├ resolve_player()
├ resolve_enemy()
├ resolve_triggers()
├ resolve_abilities()
├ resolve_strikes()
├ resolve_status()
├ resolve_corruption()
└ write_to_log()
Beat events driven by global BeatBus.

Lore Layer

5.1 The Order of the Dance

“First the Pulse speaks.
Then the Operative answers.
Then the world replies.”

This mirrors beat → player → enemy order.

5.2 Why Player Strikes First

“The Operative is the tuning fork of creation.”

5.3 Trigger Laws

Drops/Peaks/Bass = Heavenly Decrees that can override normal sequences.

5.4 Damage as Transformation

“Where waveform meets waveform, a new shape emerges.”

5.5 Corruption Walking Behind

“Entropy walks behind all things.”

Corruption steps last in the pipeline.

5.6 Combat Log as Scripture

“Every strike is written somewhere.”