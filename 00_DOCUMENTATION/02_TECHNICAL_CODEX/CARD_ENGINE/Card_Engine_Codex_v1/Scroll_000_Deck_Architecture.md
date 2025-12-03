# CARD ENGINE CODEX v1.0  

## SCROLL 000 — THE ARCANE DECK ARCHITECTURE  

*Cards are not tools. They are echoes of identity.*

---

## 0.0 Purpose of the Card Engine

The Card Engine defines how Operatives:

- grow  
- adapt  
- specialize  
- shape builds  
- bind to rhythm  
- embrace or resist corruption  
- wield abilities  
- create synergy  
- ascend into Overdrive  
- descend into Shadow Overdrive  

Cards are the **soul-crafting system** of Project Dissonance.

They determine:

- playstyle  
- scaling  
- kit identity  
- progression  
- transformation access  
- corruption alignment  

Where the Player Engine defines *who the Operative is*,  
the Card Engine defines *who the Operative becomes*.

---

## 0.1 Cards as Identity Channels

Cards are not random loot — they are:

- crystallized memory  
- fragments of resonance  
- echoes of previous realms  
- compressed abilities, states, and modifiers  

Each card is a **micro-engine** that changes how the Operative interacts with:

- the Combat Engine  
- the Rhythm Engine  
- the Corruption Engine  
- the Resource Engine  
- transformation states  
- build paths  

Cards create **identity flow**, allowing each run, fight, or sequence to be unique.

---

## 0.2 Card Classes

Every card belongs to one of four primal classes:

### **A) Technique Cards**  

Skill modifications → new attacks, new abilities, new combos.  
These define mechanical style.

### **B) Resonance Cards**  

Rhythm-based bonuses → window changes, crit sync, OD boosts.  
These define timing and mastery.

### **C) Corruption Cards**  

Dark engine nodes → corrupted abilities, instability, SOD triggers.  
These define chaos and divergence.

### **D) System Cards**  

Modifiers → resource boosts, defense, synergy triggers, utility.  
These define long-term build structure.

This fourfold architecture ensures:

- clarity  
- balance  
- synergy  
- extensibility  

---

## 0.3 Deck Composition Philosophy

A Deck represents:

- the Operative’s **identity configuration**  
- their chosen path  
- their understanding of the Pulse  
- their alignment with or against Corruption  

Decks must:

1. reflect the build path  
2. express the Operative’s resonance  
3. synergize with rhythm  
4. respond to corruption  
5. shape Overdrive and Shadow Overdrive dynamics  

Decks are **living structures** that shift as corruption grows.

---

## 0.4 Card Structure Overview

Every card follows a shared model:

```jsonc
Card {
  id: string,
  name: string,
  class: string,     // TECHNIQUE | RESONANCE | CORRUPTION | SYSTEM
  rarity: string,    // COMMON | RARE | EPIC | LEGENDARY | MYTHIC
  cost: object,      // energy, OD, corruption, cooldown
  effect: object,    // stat/ability/resource modification
  synergy_tags: [string],
  corruption_affinity: string,  // PURE | BALANCED | CORRUPTED | ABYSSAL
  rhythm_affinity: string,      // PRECISION | FLEX | CHAOS | NONE
  metadata: object
}
Cards must be powerful but bounded.

0.5 Card Flow — “The Four Steps of Resonance”

Every card travels the same lifecycle:

1. Draw

Card is added to the Operative’s hand.
Trigger events may activate (draw triggers, corruption pulls, rhythm echoes).

2. Evaluate

The Player Engine checks:

resource availability

state privileges

corruption restrictions

rhythm conditions (if any)

3. Play

The card generates:

an action

a resource change

a temporary status

an ability override

a transformation entry condition

a corruption surge or purge

4. Resolve

The card’s effect moves through the Combat Engine →
Resolution Pipeline →
VFX/SFX →
AI →
Zone Engine.

0.6 Card Synergy Archetypes

Cards synergize along six axes:

PWR Scaling

FCS Scaling

RHM Scaling

Corruption Expression

Overdrive Flow

Shadow Overdrive Instability

Any card can influence any axis, but must remain faithful to its Class identity.

0.7 Corrupted & Abyssal Cards

There are two dark forms of cards:

Corrupted Cards

Stabilized but risky variants.
Offer big bonuses with predictable penalties.

Abyssal Cards

High-risk, extremely powerful cards that interact with:

instability

breach levels

Shadow Overdrive

corruption storms

card fusion mutators

Abyssal Cards must NEVER enter the deck early-game.

0.8 Deck Integrity Rules

A deck must always contain a valid ratio of classes.

Deck size caps must be enforced.

Corruption cards may not exceed safe ratios unless Divergent build.

Abyssal cards require extremely strict unlock conditions.

Cards must not break fundamental Combat Engine rules.

Card play must always create deterministic, replay-safe actions.

Rhythm-locked cards must NOT activate on LATE or MISS.

Cards must not allow infinite resource loops.

All card effects must pass through the Resolution Pipeline.

All card transformations (fusion, corruption mutation) must be logged.
