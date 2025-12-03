# PLAYER ENGINE CODEX v3.0  
## SECTION 01 — BASE STATS & GROWTH  
*From raw signal to defined form.*

---

## 1.0 Purpose of Operative Stats

The Player Engine defines the **core parameters of an Operative’s identity**:

- physical capability  
- precision and focus  
- resilience  
- rhythm sensitivity  
- corruption resistance  
- growth over time  

Operative Stats shape *who the player is*, while the Combat Engine determines *what happens* when they act.

---

## 1.1 Primary Operative Stats

These are the base pillars of player identity and scaling.

---

### **1. POWER (PWR)**  
Defines raw physical offensive potential.  
Higher PWR → higher ATK conversion.

Used for:
- melee abilities  
- physical cards  
- brawler builds  

---

### **2. FOCUS (FCS_OP)**  
Defines precision, ranged control, and magical capability.  
Higher FCS_OP → higher FCS conversion.

Used for:
- ranged abilities  
- crit consistency  
- support / precision builds  

*(Different from Combat Stat **FCS**, but maps into it.)*

---

### **3. VITALITY (VIT_OP)**  
Defines endurance, survivability, and life-force stability.

Affects:
- max HP  
- stagger resistance  
- VIT (Combat Stat)  

---

### **4. AGILITY (AGI)**  
Defines movement efficiency and responsiveness.

Affects:
- movement speed  
- dash distance  
- animation blend speed  
- SPD (Combat Stat)  

---

### **5. RESOLVE (RSL_OP)**  
Defines mental/spiritual strength under pressure.

Affects:
- corruption resistance  
- fear/stun resistance  
- RESOLVE (Combat Stat)  

---

### **6. RHYTHM MASTERY (RHM_OP)**  
Defines innate connection to the Pulse.

Affects:
- size of timing windows  
- overdrive gain  
- rhythm forgiveness  
- RHM (Combat Stat)  

---

## 1.2 Secondary Operative Stats

These are optional but powerful modifiers.

### **CRIT FACTOR (CRF)**  
Controls both crit chance and crit damage scaling.

### **GUARD EFFICIENCY (GRD)**  
Improves block, parry, and defensive timing effects.

### **OVERDRIVE AFFINITY (ODF)**  
Determines how quickly Overdrive builds and how stable it stays.

### **SHADOW AFFINITY (SHF)**  
Determines compatibility with Shadow Overdrive forms.

---

## 1.3 Stat Storage Model

All Operative stats are stored in a structured data object:

```jsonc
OperativeStats {
  level: int,
  xp: int,
  primary: {
    PWR: int,
    FCS_OP: int,
    VIT_OP: int,
    AGI: int,
    RSL_OP: int,
    RHM_OP: int
  },
  secondary: {
    CRF: int,
    GRD: int,
    ODF: int,
    SHF: int
  },
  growth_profile_id: string,
  bonuses: object
}
The Combat Engine never sees this structure directly —
it only receives snapshots converted into Combat Stats.

1.4 Mapping Operative Stats → Combat Stats
Conversion happens each time a snapshot is generated:

ini
Copy code
ATK     = PWR * atk_per_power
FCS     = FCS_OP * fcs_per_focus
VIT     = VIT_OP * vit_per_vitality
SPD     = AGI * spd_per_agility
RESOLVE = RSL_OP * resolve_per_rsl
RHM     = RHM_OP * rhm_per_rhmop
DEF and RES primarily come from:

gear

cards

special statuses
but can also have small contributions from base stats.

1.5 Levels & Growth Curves
Leveling follows a simple formula:

Increase level

Apply growth profile values

Recompute snapshot

Trigger level-up events

Update resource thresholds (HP, OD capacity, etc.)

Growth Profiles define how each archetype increases stats per level.

Example:

jsonc
Copy code
GrowthProfile {
  id: "balanced",
  hp_per_level: 10,
  pwr_per_level: 2,
  fcs_per_level: 2,
  vit_per_level: 2,
  agi_per_level: 2,
  rsl_per_level: 1,
  rhm_per_level: 1
}
1.6 XP Curve
XP per level can follow:

ini
Copy code
xp_required = base * (level^curve)
Where:

base = early game speed

curve = progression steepness

Rules:

XP overflow carries

XP cannot be negative

Level caps defined per game phase

1.7 Bonus Application Order
Bonuses apply in strict order:

level-based stats

flat bonuses

multiplicative bonuses

temporary buffs

corruption adjustments

This prevents chaotic scaling.

1.8 Rhythm & Stat Growth
RHYTHM MASTERY grows more slowly than other primaries
because it drastically affects difficulty and skill expression.

High RHM_OP:

expands GOOD/PERFECT windows

improves rhythm-based ability efficiency

increases OD generation

But always capped for fairness.

1.9 Corruption & Stat Growth
Corruption can adjust stats temporarily or permanently:

temporary skew from corruption storms

permanent altered growth paths from corruption attunements

unlocking Shadow skill paths

Corruption must always involve tradeoffs, not free power.

1.10 Integrity Rules
Primary stats cannot drop below 1.

Growth profile must be deterministic.

Multipliers apply after flats.

Corruption never applies permanent changes unless designed.

Stat recalcs must occur on level-up, OD shifts, and transformations.

Rhythm-linked stats must never trivialize timing windows.

XP curve must never soft-lock progress.

Stat trees must remain readable for debugging.

Leveling must not crash the snapshot.

Combat Stat conversion must always remain pure.