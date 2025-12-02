# COMBAT ENGINE CODEX v1.0  
## SECTION 8 — DAMAGE TYPES, CRITICALS & MULTIPLIER SYSTEM

---

## Technical Layer

The damage system defines how all types of harm are calculated, modified, mitigated, and delivered.  
It integrates stats (Impact, Harmony, Dissonance, Flow), statuses, corruption, triggers, armor, resistances, crits, and rhythm windows into one deterministic pipeline.

---

# 8.1 Damage Types (Three Harm Principles)

Resonantia uses **three core forms of damage**:

1. **Physical Damage**
   - mitigated by armor
   - affected by Impact
   - influenced by stagger & knockback logic

2. **Resonance Damage**
   - bypasses armor
   - mitigated by resonance resistance
   - scales strongly with Harmony
   - gains bonuses from Perfect / Good beats

3. **Corruption Damage**
   - partially ignores all resistances
   - enhanced by Dissonance
   - interacts with corruption_level
   - may invert rhythm effects (off-beat bonus)

---

# 8.2 Damage Resolution Order

Damage follows this exact sequence:

```text
1. Determine base damage (strike/ability)
2. Apply Impact scaling
3. Apply Harmony (beat window) multiplier
4. Apply damage type (physical/resonance/corruption) logic
5. Apply armor (for physical only)
6. Apply resistance (per damage type)
7. Apply Dissonance multipliers (off-beat, corruption)
8. Apply buffs / debuffs
9. Apply crit (if triggered)
10. Apply Shadowborn modifiers (if active)
11. Clamp, round, finalize
Every hit uses this order.
Nothing skips steps unless explicitly defined.

8.3 Base Damage Calculation
Base damage is defined per action:

text
Copy code
base_damage = action.base_damage
For abilities, base_damage may be modified by:

charge time

trigger variant

corruption variant

ability scaling rules

8.4 Impact Scaling
ini
Copy code
impact_factor = 1 + (Impact / 100)
step1 = base_damage * impact_factor
Impact always applies first after base.

8.5 Beat Window Multiplier (Harmony)
yaml
Copy code
if perfect: step2 = step1 * (1 + Harmony * 0.02)
elif good:  step2 = step1 * (1 + Harmony * 0.01)
elif poor:  step2 = step1 * 1.0
else:       step2 = step1 * (0.8 - Harmony * 0.003)
Beat quality matters more than any other modifier.

8.6 Damage-Type Behavior
8.6.1 Physical Damage
lua
Copy code
phys_after = max(step2 - armor, step2 * 0.10)
phys_after *= (1 - physical_resistance)
Min 10% penetration ensures slow attacks still matter.

8.6.2 Resonance Damage
ini
Copy code
res_after = step2 * (1 - resonance_resistance)
Ignores armor entirely.

Gains additional penetration from Harmony:

nginx
Copy code
res_after *= (1 + Harmony * 0.0035)

8.6.3 Corruption Damage
Corruption partially ignores protections:

ini
Copy code
eff_resistance = resistance * 0.4
corrupt_after = step2 * (1 - eff_resistance)
Dissonance amplifies corruption:

nginx
Copy code
corrupt_after *= (1 + Dissonance * 0.03)
If target is Shadow-corrupted:

nginx
Copy code
corrupt_after *= 1.15
8.7 Final Resistance Step
After type-handling:

ini
Copy code
step3 = damage_after_type
step4 = step3 * (1 - final_resistance)
final_resistance depends on the type.

8.8 Dissonance Multipliers
If hit was Off-Beat:

ini
Copy code
step5 = step4 * (1 + Dissonance * 0.02)
If attacker is corrupted:

markdown
Copy code
step5 *= (1 + corruption_level * 0.004)
If Shadow Overdrive active:

markdown
Copy code
step5 *= (1 + Dissonance * 0.04)
8.9 Buffs & Debuffs
All buffs/debuffs are multiplicative:

ini
Copy code
step6 = step5 * buff_mult * debuff_mult
Examples:

Vulnerable: ×1.15

Armor Break: armor reduced before calc

Power Surge: ×1.10

8.10 Critical Hits
Crit chance is computed after all previous layers.

cpp
Copy code
if rand() < crit_chance:
    step7 = step6 * crit_multiplier
else:
    step7 = step6
Beat interactions:

Perfect Beat → guarantees crit if Harmony ≥ 80

Off-beat → crit chance boosted by Dissonance

Bosses may have crit resistance.

8.11 Shadowborn Modifiers
Shadowborn enemies (or players in Shadow Overdrive) apply:

ini
Copy code
step8 = step7 * 1.10     # universal amplification
Shadowborn bosses override this with custom tables.

8.12 Rounding & Clamping
Final damage:

ini
Copy code
total_damage = clamp(round(step8), 1, max_value)
Never less than 1 unless absorbed.

8.13 Godot Implementation Outline
Damage pipeline script:

scss
Copy code
DamageEngine.gd
├ calculate_base()
├ apply_impact()
├ apply_harmony()
├ apply_damage_type()
├ apply_resistance()
├ apply_dissonance()
├ apply_status_modifiers()
├ apply_crit()
├ apply_shadowborn()
└ finalize()
Modular, unit-testable, deterministic.

Lore Layer
8.1 Three Harm Principles
Scripture names the three damage types as:

Harm of Flesh → physical

Harm of Tone → resonance

Harm of Void → corruption

Each represents a different way reality can be wounded.

8.2 Beat Determines Fate
“The tone of the strike matters more than its weight.”

Perfect Beats are described as moments where the Operative’s soul aligns with creation.

8.3 Armor & Resistance as Spiritual Shells
Armor represents memory.
Resistance represents alignment of frequency.

“A being resists only what it understands.”

8.4 Corruption Wounds as Truth
Corruption doesn’t just harm — it reveals flaws.

“Entropy is the truth behind all illusions of form.”

Shadowborn creatures are said to be:

“Too honest for the world around them.”

8.5 Critical Hits as Divine Precision
Crits are described as:

“Moments when the universe blinks.”

Perfect Beats guaranteeing crits at high Harmony reflect true cosmic alignment.

8.6 Shadowborn Power
Shadowborn amplification is explained as:

“A reflection striking back harder than the hand.”