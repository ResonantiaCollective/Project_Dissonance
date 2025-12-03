# CARD ENGINE CODEX v1.0  

## SECTION 01 — CARD DATA MODEL  

*Every card is a spell written as data.*

---

## 1.0 Purpose

The Card Data Model defines the **universal structure** of all cards in Resonantia.

Every system that touches cards (Combat, Player, Rhythm, Corruption, AI, Zone, Trigger)  
must be able to read this structure **without special cases**.

This section specifies:

- how a card is represented  
- core fields (id, type, cost, effects, tags, etc.)  
- how cards reference other systems (stats, abilities, statuses, resources)  
- how corruption and rhythm fields are baked in at the data level  

---

## 1.1 Card Identity

Each card has a stable identity:

```jsonc
CardIdentity {
  id: string,            // unique, stable identifier
  name: string,
  rarity: string,        // common, rare, epic, legendary, etc.
  category: string,      // ability, modifier, trigger, rhythm, corruption, transform
  archetype: string,     // build path tag, e.g. "Brutalist", "Arcanist"
  description: string,
  lore: string
}
id is used internally by code and logs

name is for UI

rarity influences drop rates, upgrade rules, fusion behavior

category links to behavior and engine routing

archetype ties into Player Engine Build Paths

1.2 Card Costs

Cards may consume:

Energy

HP

Overdrive

Corruption Stability

Custom resources (future systems)

CardCost {
  energy: float,
  hp: float,
  overdrive: float,
  corruption: float,   // may increase corruption when played
  other: object        // for future resources
}


Costs are validated in the Player Engine before the card can be played.

1.3 Card Timing

Cards can be:

instant — resolved immediately on play

channeled — resolved after a delay

persistent — apply a status or aura

triggered — wait for a condition

CardTiming {
  play_speed: string,     // fast, normal, slow, channel
  duration: float|null,   // for auras or persistent effects
  trigger_type: string,   // for trigger cards: on_hit, on_perfect, on_corruption_spike, etc.
  trigger_condition: string|null // condition description ID or script hook
}


Timing interacts heavily with the Rhythm System and Trigger Engine.

1.4 Card Effects

Card effects are modular.

Every card can have one or more effects, each with a type:

CardEffect {
  id: string,
  type: string,           // damage, heal, buff, debuff, status, resource, transform, trigger, utility
  target_scope: string,   // self, single_enemy, all_enemies, zone, random, chain
  magnitude: object,      // scaling values, see below
  duration: float|null,   // for effects with time
  status_id: string|null, // link to Status System (buff/debuff)
  ability_id: string|null,// link to Ability System
  resource_changes: object|null, // energy/OD/SOD/corruption delta
  metadata: object        // flexible payload
}

Magnitude specification (example):
magnitude: {
  base: float,
  scaling_stat: string,    // "PWR", "FCS_OP", "VIT_OP", etc.
  scaling_factor: float,   // how strongly it scales with that stat
  rhythm_scaling: string,  // "precision", "flex", "chaos", "none"
  corruption_scaling: string // "stable", "volatile", "inverted"
}


This structure ensures that all card effects can be routed through the Combat & Player Engines.

1.5 Card Tags

Tags are used heavily for:

synergy

search/filtering

card pool building

zone/trigger interactions

corruption mutations

CardTags {
  house: [string],         // House / faction affiliation
  element: [string],       // fire, sonic, void, glitch, corruption, etc.
  role: [string],          // attack, defense, support, utility, control
  rhythm: [string],        // tempo, sync, desync, chain
  corruption: [string],    // pure, tainted, corrupted, abyssal
  mechanics: [string]      // bleed, burn, shield, draw, discard, fuse, etc.
}


Tags must be controlled vocabulary, not free chaos.

1.6 Card State (Runtime)

During a run/combat, each card has a runtime state:

CardRuntimeState {
  in_deck: bool,
  in_hand: bool,
  in_discard: bool,
  in_ether: bool,
  is_corrupted_variant: bool,
  upgrades: int,
  temporary_modifiers: object, // from statuses, zone effects, etc.
  exhaustion_flag: bool        // if the card is removed after play
}


State transitions are managed by the Card Engine and influenced by:

triggers

zones

corruption events

player abilities

1.7 Card Corruption Fields

Each card can define how corruption affects it:

CardCorruptionProfile {
  corruption_affinity: string,   // stable, volatile, abyssal, resistant
  can_mutate: bool,
  mutation_ids: [string],        // list of card IDs it can mutate into
  mutation_chance_base: float,
  mutation_chance_per_level: float,
  instability_impact: string     // how much this card affects corruption instability
}


This ensures all corruption behavior is data-driven.

1.8 Card Rhythm Fields

Cards can define rhythm interaction at the data level:

CardRhythmProfile {
  rhythm_required: bool,
  rhythm_bias: string,         // precision, flex, chaos, neutral
  perfect_bonus: object,       // changes on PERFECT
  good_bonus: object,          // changes on GOOD
  late_penalty: object,        // changes on LATE
  miss_penalty: object         // changes on MISS
}


Examples:

PERFECT → extra damage, extra draw, upgrade card

MISS → card is exhausted or corrupted

1.9 Full Card Schema

Putting it all together:

Card {
  identity: CardIdentity,
  cost: CardCost,
  timing: CardTiming,
  effects: [CardEffect],
  tags: CardTags,
  corruption_profile: CardCorruptionProfile,
  rhythm_profile: CardRhythmProfile
}


This is the canonical Card object used across all engines.

1.10 Integrity Rules

Each card must have a unique id.

Each card must define exactly one category.

Effects must not bypass the Resolution Pipeline.

Rhythm behavior must be defined for rhythm-relevant cards.

Corruption mutations must be finite (no infinite mutation loops).

Tags must use controlled vocabularies.

Card cost cannot be negative.

Corruption effects must not permanently delete cards unless explicitly designed.

All runtime card states must be reconstructable from logs.

Card definitions must be versioned for balance and backward-compatibility.
