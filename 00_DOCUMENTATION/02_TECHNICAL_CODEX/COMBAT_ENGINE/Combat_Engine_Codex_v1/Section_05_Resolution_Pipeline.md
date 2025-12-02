# COMBAT ENGINE CODEX v1  
## SECTION 05 — RESOLUTION PIPELINE  
*The Heart of Combat*

---

## 5.0 Purpose of the Resolution Pipeline

The **Resolution Pipeline** is where actions become outcomes.

Every action (Section 02) enters this pipeline and exits as:

- damage  
- healing  
- statuses  
- knockback  
- resource gain  
- rhythm events  
- corruption distortions  
- AI state changes  

Nothing in combat bypasses the pipeline.

This is the “truth forge” of Resonantia.

---

## 5.1 Pipeline Overview

Every action flows through the same sequence:

1. **PRE-CHECK → Eligibility**  
2. **TIMING → Rhythm Scaling**  
3. **BASE FORMULA → ATK/FCS/VIT scaling**  
4. **MODIFIERS → Buffs / Debuffs / Status interactions**  
5. **CORRUPTION → Distortion layer**  
6. **DEFENSE → Mitigation / shields**  
7. **FINALIZATION → Damage / healing / effects**  
8. **PROPAGATION → Audio, VFX, AI**  
9. **LOG → Historical record**

This ensures deterministic, debuggable combat.

---

## 5.2 Stage 1 — Pre-Check

Before anything else, the pipeline verifies:

### ✔ Actor can act  
- Not stunned  
- Not frozen  
- Not locked by special states  
- Not dead  

### ✔ All requirements met  
- costs paid  
- cooldowns available  
- valid target(s)

If a pre-check fails:

- Action is cancelled  
- A failure packet is returned  
- No further pipeline stages run

---

## 5.3 Stage 2 — Rhythm Scaling

The action inherits its rhythm timing from Section 02.

There are four qualities:

- **PERFECT**  
- **GOOD**  
- **LATE**  
- **MISS**

These influence:

### Damage scaling:

PERFECT: +25%
GOOD: +10%
LATE: -20%
MISS: 0% (action whiffs)

### Crit chance bonus:

PERFECT: +15%
GOOD: +5%
LATE: 0%
MISS: 0%

### Resource (Overdrive) gain:

PERFECT: +20%
GOOD: +10%
LATE: +2%
MISS: 0%

If **MISS**, skip straight to Propagation with a “miss” outcome.

---

## 5.4 Stage 3 — Base Formula

If the action deals damage, the base damage is computed from
stats (Section 03):

base_damage = ATK * ability_multiplier

For magical / ranged actions:

base_damage = FCS * ability_multiplier

For DoT / HoT ticks:

tick_value = (FCS * tick_multiplier) ± variance

Healing:

heal_amount = VIT * heal_multiplier

Movement / crowd control actions skip this stage.

---

## 5.5 Stage 4 — Modifiers (Buffs/Debuffs)

All active statuses (Section 04) now modify the base values:

- **ATK_UP / ATK_DOWN** → additive  
- **FCS_UP / FCS_DOWN** → additive  
- **DEF_UP / DEF_DOWN** → defensive multipliers  
- **window_expand / window_shrink** → affects Stage 2  
- **crit_boost / crit_reduce** → affects Stage 2  
- **corruption_amplify / corruption_resist** → Stage 5  
- **shield** → Stage 6  
- **invulnerability** → Stage 6  

Modifiers stack according to their declared stacking mode.

Order of application:

1. Additive modifiers  
2. Multiplicative modifiers  
3. Overrides (special states)

This prevents stat overflow and maintains fairness.

---

## 5.6 Stage 5 — Corruption Distortion Layer

Resonantia’s unique identity.

Every action runs a corruption pass:

### Potential distortions:

- value spike (+10–30%)  
- value dip (−10–30%)  
- rhythm inversion (GOOD → LATE)  
- crit corruption (crit becomes “glitch crit”)  
- status mutation (Bleed → Hemorrhage)  
- ability twist (changes element type)  

The severity depends on:

actor_corruption_value
target_corruption_value
environment_corruption_level
global_corruption_state

Corruption cannot delete actions — only distort them.

---

## 5.7 Stage 6 — Defense & Mitigation

The target’s defensive systems apply now:

### DEF formula:

damage_after_def = dmg * (100 / (100 + DEF))

### Elemental RES:

elemental_after_res = dmg * (1 - RES_factor)

### Shields:

- Subtract from shield first  
- Excess goes to HP  

### Invulnerability:

if target.has(invulnerability):
final_damage = 0

### Guard / Block:

- LATE guard: −20% damage  
- GOOD guard: −50% damage  
- PERFECT guard: −80% damage + reflects % back  
- MISS guard: no mitigation  

---

## 5.8 Stage 7 — Finalization

After all scaling and mitigation:

### Damage:

final_damage = max(1, floor(modified_damage))

### Healing:

final_heal = max(1, floor(modified_heal))

### Status application:

- Chance modified by rhythm quality  
- Modified by FCS and RHM  
- Target can resist via RESOLVE  

### Resource gain:

overdrive += base_gain + rhythm_bonus

### Action result packet is constructed:

```jsonc
{
  "type": "damage" | "heal" | "status" | "miss",
  "value": final_value,
  "source": actor_id,
  "target": target_id,
  "rhythm": rhythm_quality,
  "crit": true|false,
  "corruption": distortion_info,
  "metadata": {...}
}
This packet is what all other systems read.

5.9 Stage 8 — Propagation to Other Systems

The result packet is sent to:

Animation system

plays the appropriate attack/hit/block animation

Audio system

selects hit SFX

adjusts based on corruption / crit / rhythm

VFX system

hit sparks, glitch bursts, corruption tendrils, etc.

AI system

enemy changes state

reacts to damage or timing

triggers counterbehavior

UI system

damage numbers

status icons

timing feedback

Propagation is read-only:
No system can rewrite the result packet.

This protects engine integrity.

5.10 Stage 9 — Logging

Every resolved action is written to the Combat Log:

action_id

actor

target

damage/heal values

crit

rhythm

corruption effects

statuses applied

timestamps

Used for:

debugging

analytics

replays

balancing

post-fight analysis

Logs are never authoritative — but they mirror the authoritative engine.

5.11 Resolution Pipeline Integrity Rules

Once an action enters the pipeline, it must complete.

No result can contradict earlier pipeline stages.

Corruption cannot skip Defense or Modifiers.

MISS actions skip directly to Propagation, never dealing damage.

Defensive states always apply before corruption spikes.

Final values must be integers ≥ 1 unless overridden by a special state.

Action packets must be immutable after finalization.

These rules ensure predictable, stable combat.