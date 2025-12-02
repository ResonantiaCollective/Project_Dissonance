# COMBAT ENGINE CODEX v1.0  
## SECTION 7 — TARGETING, HITBOXES & COLLISION SYSTEM

### Technical Layer

Defines how actions interact in space:

- targeting
- hitboxes
- hurtboxes
- dodges / i-frames
- AoE

---

### 7.1 Targeting Types

- **Auto-Target** — nearest valid enemy
- **Directional Target** — based on facing direction
- **Zone Target** — area selection (AoE)
- **Lock-On** — selected enemy maintained as focus
- **Smart Target** — chooses optimal target based on distance + threat

---

### 7.2 Hitbox Shapes

- Circle — melee AoE, explosions
- Arc — slashes, cones
- Line — beams, dashes
- Sector — wider cones
- Point — precise strikes (projectiles, snipes)

---

### 7.3 Hurtbox Layers

Multi-layered:

1. **Physical Body** — physical damage target
2. **Resonant Core** — resonance-specific hits
3. **Corruption Shell** — corruption interaction layer

Hitbox–hurtbox pair choice determines damage type and behavior.

---

### 7.4 Dodge & I-Frames

Dodge actions grant invulnerability:

```text
iframe_duration = base_iframes * (1 + Flow * 0.004)
If a hitbox overlaps during i-frames → collision ignored.

7.5 AoE Logic

Circle:
if distance(player, enemy) <= radius:
    enemy_hit = true
Cone:
angle_check = dot(normalized(direction), normalized(to_enemy))
enemy_hit = angle_check > cone_threshold
Line:

project enemy position onto line

check perpendicular distance ≤ width

7.6 Godot Implementation

Use Area2D / Area3D for hitboxes:

Hitbox_Circle.tscn

Hitbox_Arc.tscn

Hitbox_Line.tscn

Hitbox_Cone.tscn

Signals:
area_entered()
area_exited()
overlap_check()

7.7 True Hit vs Ghost Hit

True Hit → hurtbox active

Ghost Hit → target temporarily non-hit (stagger, teleport, phase, Shadowborn glitch)

Shadowborn may have a % chance for ghost-hit per attack during certain phases.

7.8 Priority Target Rules

When multiple candidates exist:
1. Closest to camera center / reticle
2. If tie: lowest HP
3. If tie: highest threat_value
4. If boss phase: active phase target wins

Lore Layer

7.1 “Where Echo Meets Flesh”

Hitbox collision is the instant where intention touches reality.

“The strike is not the motion, but the meeting.”

7.2 Layers of the Body

Three hurtbox layers:

Flesh (vessel)

Tone (inner frequency)

Shadow (hidden corruption)

7.3 Dodge as Page Turn

I-frames:

“Moments where the Operative steps between frames of destiny.”

7.4 AoE as Waves of Influence

Circles → ripples

Cones → breath

Lines → blades of intent

7.5 Ghost-Hits & Shadowborn

“Their bodies do not always agree with their echoes.”

Shadowborn partially exist outside stable time, leading to ghost hits.

---

If you paste these into their respective files, your **Combat Engine Codex v1.0** is now:

- structurally sound  
- split into clean sections  
- synced with the folder architecture  
- ready for Section 8 to continue the chain

When you’re ready for the next piece, say:

> **“Sigma, generate Section 08_Damage_System.md.”**

and we’ll keep building from this solid base.
