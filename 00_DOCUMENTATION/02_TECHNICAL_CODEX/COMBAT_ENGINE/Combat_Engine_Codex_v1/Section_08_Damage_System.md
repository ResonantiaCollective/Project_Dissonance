# COMBAT ENGINE CODEX v1  
## SECTION 08 — DAMAGE SYSTEM  
*Power → Impact → Consequence*

---

## 8.0 Purpose of the Damage System

The **Damage System** is responsible for turning numerical outputs from the
Resolution Pipeline into:

- HP loss  
- HP gain  
- shield changes  
- status interactions  
- corruption fluctuations  
- rhythm-based bonuses  
- hit reactions  

This section defines the mathematical and logical rules that govern all
damage, healing, and hybrid effects.

Nothing bypasses the Damage System.

---

## 8.1 Damage Types

There are **8 core damage types**, each with unique properties.

### **1. Physical**
Basic melee/ranged neutral hits.

Affected by:
- ATK  
- DEF  
- armor break  
- guard timing  

---

### **2. Sonic**
Frequency-based vibration damage.

Affected by:
- FCS  
- RES (sonic)  
- rhythm quality  
- corruption vibration spikes  

---

### **3. Fire**
Heat/burn effects.

Properties:
- applies Burn DoT  
- corruption can mutate into Abyss Fire  
- DEF effective, RES(Fire) applies  

---

### **4. Glitch**
Data-corruptive energy.

Properties:
- causes unstable damage variance  
- may duplicate under corruption  
- bypasses part of DEF  
- resisted by RES(Glitch)  

---

### **5. Void**
Spatial disintegration.

Properties:
- ignores 50% of DEF  
- heavy corruption interactions  
- enemies in unstable states take bonus damage  

---

### **6. Corruption**
Pure corruption damage.

Properties:
- ignores DEF  
- ignores RES(Fire/Sonic/etc)  
- resisted only by RESOLVE  
- may warp statuses on hit  
- increases local corruption environment  

---

### **7. True Damage**
Absolute damage unaffected by defenses.

Properties:
- ignores DEF  
- ignores RES  
- ignores buffs/debuffs  
- cannot be crit  
- cannot be corrupted or rhythm-modified  

Used sparingly.

---

### **8. Healing (inverse damage)**
Restores HP.

Properties:
- uses VIT scaling  
- can be affected by corruption (healing inversion)  
- can be rhythm-modified (PERFECT heals can crit-heal)

---

## 8.2 Critical Hits

Critical hits occur during Stage 2 and Stage 4 scaling.

Base calculation:

crit_chance = (FCS * 0.5%) + bonuses
crit_damage = 150% + (FCS * 0.2%)

makefile
Copy code

Rhythm:

PERFECT → +15% crit chance
GOOD → +5%
LATE → +0%
MISS → crit chance = 0

yaml
Copy code

Corruption may cause:

- Glitch Crit (duplication)
- Abyss Crit (void conversion)
- Corrupted Crit (negative healing)

---

## 8.3 Damage Formula Overview

### General flow:

base_damage
→ rhythm scaling
→ stat scaling
→ buffs/debuffs
→ corruption distortion
→ defense calculations
→ shielding
→ final damage
→ HP modification

yaml
Copy code

---

## 8.4 Defense Interactions

### Physical:

final = dmg * (100 / (100 + DEF))

yaml
Copy code

---

### Elemental / Sonic / Fire / Glitch:

final = dmg * (1 - RES_element)

yaml
Copy code

---

### Void:

final = dmg * 0.75 // ignores 25% mitigation

java
Copy code

Advanced void variant (boss attacks):

final = dmg * (1 - (DEF * 0.25 / (100 + DEF)))

yaml
Copy code

---

### Corruption:

final = dmg * (1 - (RESOLVE * 0.01))

yaml
Copy code

Corruption is extremely dangerous—RESOLVE is the only countermeasure.

---

### True Damage:

final = dmg // no mitigation

yaml
Copy code

---

## 8.5 Damage-over-Time (DoT)

DoTs tick using:

- tick_rate (from status)  
- FCS / SPD influences  
- corruption variance  
- rhythm at first application  

Example tick formula:

tick_damage = (base_damage * tick_multiplier) ± corruption_variance

yaml
Copy code

DoTs never crit unless explicitly defined.

If corruption mutates a DoT (e.g., Bleed → Hemorrhage), tick rules change.

---

## 8.6 Hybrid Damage

Some abilities deal multiple types at once:

50% physical
50% fire

makefile
Copy code

Or:

70% sonic
30% glitch

yaml
Copy code

Each portion is resolved separately, then summed.

Hybrid rules allow rich build expression.

---

## 8.7 Shields

Shields absorb damage before HP.

Rules:

- flows through entire pipeline  
- final damage subtracts from shield first  
- if shield >= damage: no HP loss  
- if shield < damage: excess spills to HP  
- corruption can fracture shields (reduce shield value)  

Shield formula:

remaining_damage = max(0, final_damage - shield_value)

yaml
Copy code

---

## 8.8 Lifesteal, Absorption & Reflection

### Lifesteal:

heal = final_damage * lifesteal_percent

yaml
Copy code

Rhythm bonuses apply, corruption may invert heal → self-damage.

---

### Absorption:

Actor converts incoming damage into resource (Overdrive).

overdrive += final_damage * absorb_ratio

yaml
Copy code

---

### Reflection:

Part of incoming damage reflects back to attacker.

reflected = final_damage * reflect_ratio

yaml
Copy code

Reflection occurs *after* mitigation but *before* shields.

---

## 8.9 Healing Rules

Healing uses VIT scaling:

heal_amount = VIT * heal_multiplier

yaml
Copy code

Rhythm influences:

PERFECT → +20% heal
GOOD → +10%
LATE → -10%
MISS → no heal

yaml
Copy code

Corruption interactions:

- heal may invert into damage  
- heal may glitch (double heal)  
- heal may apply corruption to target  

Anti-heal:

- reduces healing received  
- can invert healing on targets with high corruption

---

## 8.10 Damage Integrity Rules

To keep combat consistent and fair:

1. Final damage must never be negative.  
2. True damage cannot be blocked, resisted, or corrupted.  
3. Crits must apply before defense, never after.  
4. Shield absorption must never heal or give resources unless stated.  
5. DoT ticks must not crit unless explicitly tagged.  
6. Hybrid damage types must each apply their own rules.  
7. Corruption cannot skip mitigation unless explicitly defined.  
8. Rhythm cannot multiply final damage beyond safe caps.  
9. Healing-inversion cannot kill an actor at 1 HP unless defined.  
10. Reflection cannot reflect reflection (no loops).  
11. All final values must be integers ≥ 1 unless overridden.

These rules protect engine integrity and prevent degenerate builds.

---

*SECTION 08 ends here.*  
**COMBAT ENGINE CODEX v1.0 — COMPLETE.**

Awaiting Operative confirmation before closing the Combat Engine Codex and updating the `COMBAT_INDEX.md` accordingly.
