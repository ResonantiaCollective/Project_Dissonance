# COMBAT ENGINE CODEX v1.0  
## SECTION 1 — CORE PHILOSOPHY OF COMBAT

### Technical Layer

The Combat Engine defines how all interactions between:

- Player
- Enemies
- Abilities
- Triggers (Drop / Peak / Bass)
- Rhythm windows
- Status effects
- Overdrive & Shadow Overdrive
- Corruption
- Environment

are resolved.

It is NOT:

- animation system  
- AI system  
- VFX system  

It is the **mathematical heart** where intent becomes outcome.

---

### 1.1 Core Combat Pipeline Overview

High-level resolution steps (conceptual):

1. Input → Rhythm Window Classification  
2. Action / Ability Identification  
3. Trigger Modifiers (Drop / Peak / Bass)  
4. Buff & Debuff Modifiers  
5. Damage Type Resolution (Physical / Resonance / Corruption)  
6. Armor & Resistances  
7. Corruption Effects  
8. Aftereffects (stagger, knockback, etc.)  
9. Combat Log Entry & Analytics

All player and enemy actions pass through the same pipeline for determinism.

---

### 1.2 Deterministic Rhythm Priority

Combat is rhythm-first:

- Rhythm windows (Perfect / Good / Poor / Off-beat) are evaluated **before** damage and status.
- This ensures beat skill strongly influences outcome.

Order of influence:

1. Beat Window  
2. Ability / Action  
3. Modifiers (buffs/debuffs)  
4. Damage Types  
5. Corruption / Overdrive

---

### 1.3 Player-first Resolution Model

Because the player is beat-driven and enemies may be de-synced, the core loop assumes:

```text
player_action → enemy_reaction → enemy_damage → player_result
This keeps:

input responsiveness high

fairness obvious

learning curve readable

Exceptions: certain Trigger-based boss attacks may pre-empt.

1.4 The Four Universal Combat Values
Every action is influenced by four core combat stats:

Impact — raw force expression

Harmony — rhythm & resonance alignment

Dissonance — corruption, entropy, off-beat mastery

Flow — tempo, recovery, motion

These are defined mathematically in Section 3.

Lore Layer
The Living Bible reflects these mechanics in mythic language.

1.1 Combat as Sacred Confrontation
Combat is not described as violence, but as Resonance meeting Opposition.

“The Operative does not strike to destroy,
but to correct the world’s rhythm.”

1.2 Why Combat Exists
Opposition and combat exist so that:

Pulse does not stagnate

Dissonance does not consume everything

1.3 The Four Values as Cosmic Forces
Impact → The Hand That Shapes the World

Harmony → The Voice of the Pulse

Dissonance → The Shadow Behind Sound

Flow → The Eternal Motion

1.4 Player-first Resolution in Lore
Scripture states:

“The world answers the Operative,
not the other way around.”

This is the lore reflection of the player-first resolution order.