
---

### 📘 Section 03 — Combat Stats  
**File:** `Section_03_Combat_Stats.md`

```markdown
# COMBAT ENGINE CODEX v1.0  
## SECTION 3 — THE FOUR COMBAT STATS

### Technical Layer

Both Player and Enemies use four core combat stats:

- Impact
- Harmony
- Dissonance
- Flow

---

### 3.1 Impact — Raw Force

Controls:

- base damage scaling
- stagger power
- hitstop intensity
- knockback
- armor-break efficiency

Formula examples:

```text
impact_factor = 1 + (Impact / 100.0)
damage_after_impact = base_damage * impact_factor

stagger_power = base_stagger * (1 + Impact * 0.005)
hitstop_ms   = 3 + (Impact * 0.03)   # tune as needed
3.2 Harmony — Rhythm Alignment

Controls:

Perfect / Good beat bonuses

resonance penetration

Overdrive gain

duration / potency for resonance-based effects

Example:
perfect_mult = 1 + Harmony * 0.02
good_mult    = 1 + Harmony * 0.01
poor_mult    = 1.0
offbeat_mult = 0.8 - Harmony * 0.003

Resonance penetration:
resonance_pen = Harmony * 0.0035   # 0–0.35 (clamp)

Overdrive gain:
overdrive_gain = base_gain * (1 + Harmony * 0.015)

3.3 Dissonance — Corruption & Off-Beat Mastery

Controls:

corruption damage

off-beat bonuses

reverse-sync benefits

Shadow Overdrive scaling

Examples:
offbeat_bonus_mult = 1 + Dissonance * 0.02
corruption_damage  = base_corruption * (1 + Dissonance * 0.03)
shadow_overdrive_mult = 1 + Dissonance * 0.04
inversion_chance_pct  = Dissonance * 0.4

3.4 Flow — Tempo & Motion

Controls:

dodge i-frames

movement distance

recovery times

beat-GCD threshold

cast times

Examples:
recovery_time = base_recovery * (1 - Flow * 0.004)
dash_distance = base_distance  * (1 + Flow * 0.005)

if Flow >= 40:
    gcd_beats = 0.5
else:
    gcd_beats = 1.0

cast_time = base_cast * (1 - Flow * 0.003)

3.5 Universal Damage Formula (Overview)

Detailed in other sections, but combined order:
1. Impact          → power
2. Harmony         → beat bonus
3. Damage type     → physical / resonance / corruption
4. Armor/Resist    → mitigation
5. Dissonance      → off-beat / corruption boost
6. Buffs/Debuffs   → multipliers
7. Crit            → optional final multiplier

Lore Layer

Impact — “The Hand That Shapes the World”

“To strike is to declare one’s existence.”

Harmony — “The Voice of the Pulse”

“Those who walk in Harmony reshape the world without effort.”

Perfect Beats are moments where Operative and Pulse breathe together.

Dissonance — “The Shadow Behind Sound”

“What is broken reveals what was hidden.”

Power accrues to those who thrive in chaos.

Flow — “The Eternal Motion”

“The world belongs to those who move before it thinks.”

Represents spiritual agility: the ability to slip between harsh events.
