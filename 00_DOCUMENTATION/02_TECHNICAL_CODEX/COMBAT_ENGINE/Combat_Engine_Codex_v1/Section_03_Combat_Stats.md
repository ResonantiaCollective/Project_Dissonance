# COMBAT ENGINE CODEX v1  
## SECTION 03 — COMBAT STATS

---

## 3.0 Purpose of Combat Stats

Combat Stats define how powerful actions are, how tough actors are, and how
they interact with timing, corruption, and abilities.

Stats determine:

- Base damage  
- Defensive mitigation  
- Ability scaling  
- Initiative priority  
- Resistances  
- Overdrive / resource gain  

Stats are never isolated — they always move through the **Resolution
Pipeline** (Section 05).

---

## 3.1 Primary Stats

These are the fundamental measures of power shared across all actors in
Resonantia.

### **ATTACK (ATK)**  
Describes offensive power.

- Increases base damage of attacks and abilities  
- Scales with weapon, card, and ability modifiers  
- Affected by corruption (can fluctuate)

Used in formulas as:  

base_damage = ATK * ability_multiplier

---

### **DEFENSE (DEF)**  
Reduces incoming physical and neutral damage.

Formula (simplified):

damage_taken = incoming_damage * (100 / (100 + DEF))

This creates **diminishing returns**, preventing invulnerability.

DEF does **not** reduce:
- pure corruption damage  
- true damage  
- certain enemy “frequency” attacks

---

### **FOCUS (FCS)**  
Magical / ranged / rhythmic precision power.

Affects:

- ranged abilities  
- rhythm-dependent scaling  
- crit rate and crit damage  
- ability stability under corruption

Used as:

crit_chance += (FCS * 0.05%)
ability_precision += (FCS * 0.1)

---

### **VITALITY (VIT)**  
Health- and endurance-related stat.

- Increases max HP  
- Slightly increases stagger resistance  
- Modifies Overdrive gain under stress  

Formula:

max_hp = base_hp + (VIT * hp_per_point)

---

## 3.2 Secondary Stats

These stats modify deeper combat systems.

---

### **SPEED (SPD)**  
Controls:

- initiative_value in Action ordering  
- frequency of status ticks  
- movement responsiveness  
- animation blend acceleration  

In initiative:

initiative_value = SPD * 2 + timing_bonus

---

### **RESISTANCE (RES)**  
Mitigates elemental or type-based damage:

- Fire  
- Void  
- Glitch  
- Sonic  
- Corruption (partially)

Formula:

elemental_damage_taken = dmg * (1 - (RES / (RES + 150)))

---

### **RESOLVE (RSL)**  
A stat tied to psychological and metaphysical strength.

Affects:

- corruption exposure  
- fear / stagger duration  
- ability disruption resistance  
- chance to ignore mind-type attacks  

Higher RESOLVE means stability in distorted spaces.

---

### **RHYTHM MASTERY (RHM)**  
How well the actor synchronizes with the Pulse.

Affects:

- timing windows (PERFECT/GOOD thresholds)  
- critical chance on PERFECT timing  
- Drop/Peak/Bass trigger sensitivity  
- Overdrive gain from rhythm quality  

Formula example:

perfect_window = base_window + (RHM * 0.3ms)

---

## 3.3 Derived Stats

These are not allocated directly but calculated.

---

### **CRIT CHANCE & CRIT DAMAGE**

Base:

crit_chance = (FCS * 0.5%) + item_bonus + rhythm_bonus
crit_damage = 150% + (FCS * 0.2%)

PERFECT timing grants temporary crit boosts:


if rhythm_quality == PERFECT:
crit_chance += 15%

---

### **OVERDRIVE GAIN**

Derived from:

- action type  
- damage dealt  
- damage taken  
- rhythm quality  
- corruption influence  

Example:

od_gain = base_gain + (damage_dealt * 0.1) + 

---

### **ACTION PRIORITY**

From Section 02:

initiative_value = SPD * 2 + timing_bonus
priority_layer determined by action type

Corruption can randomly modify initiative by small bursts (+/-).

---

## 3.4 Scaling Curves

Stats do not scale linearly.

Each primary stat uses a **mixed progression curve**:

- early levels → linear  
- mid-level → mild exponential  
- late-game → diminishing return  

This prevents:

- stat inflation  
- one-shot builds  
- invincible builds  
- “wrong stat” uselessness

All three engines (Player/Enemy/Combat) reference the same curves, ensuring
fairness.

---

## 3.5 Stat Interactions with Rhythm

Every stat interacts with rhythm in at least one way:

- ATK → bonus scaling for PERFECT strikes  
- DEF → reduced impact of LATE guards  
- FCS → expands timing precision  
- SPD → affects rhythm-based counters  
- RHM → improves windows & Drop sensitivity  

This reinforces the core principle:

> **In Resonantia, stats are not passive numbers — they dance with the Pulse.**

---

## 3.6 Stat Interactions with Corruption

Corruption introduces unpredictable distortions:

- ATK may spike or dip  
- DEF may experience “fracture moments”  
- FCS may glitch  
- SPD may jitter  
- RHM may suddenly desync  

Corruption never deletes stats — it **warps** them temporarily.

Enemy patterns and Shadow Overdrive can intentionally manipulate these
distortions.

---

## 3.7 Stat Integrity Rules

To keep combat readable and fair, all stats follow these laws:

1. **Stats can never go below 1** (unless a special mechanic explicitly
   overrides).  
2. **Multiplicative bonuses apply after additive bonuses.**  
3. **Corruption distortions never stack infinitely.**  
4. **RHYTHM MASTERY always adjusts windows, never damage directly.**  
5. **DEF never reduces true/corruption damage.**

These rules prevent exploits and ensure every build path remains viable.

---

*SECTION 03 ends here.*  
Awaiting Operative confirmation before constructing  
**SECTION 04 — STATUS SYSTEM**.
