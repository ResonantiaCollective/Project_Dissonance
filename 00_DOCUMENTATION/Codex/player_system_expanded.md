# PLAYER SYSTEM — FULL EXPANDED SPECIFICATION (v2.0)

## NOTE
This document **supplements** but **does not replace** Living_Bible_v4.0. The Living Bible defines the metaphysics, lore, rituals, and universal laws. This Player System defines the *mechanical and technical foundation* of how a player behaves within the Resonantia Combat Engine.

Both documents operate in parallel:
- Living Bible = Philosophy, metaphysics, universe logic.
- Player System = Gameplay implementation, formulas, structure.

---

# 1. PLAYER CORE ARCHITECTURE

## 1.1 Primary Stats
These represent the player’s raw physical and metaphysical attributes.
- **HP (Health Points)** — Maximum & current health.
- **Armor** — Flat reduction applied before HP.
- **Energy (0–10)** — Required to play cards.
- **Resonance (0–100)** — Player’s sync with The Pulse.
- **Crit Chance (%)** — Chance to deal critical damage.
- **Crit Damage (x multiplier)** — Total output when crit triggers.
- **Beat Accuracy (%)** — Consistency in hitting beat windows.
- **Drop Reaction (%)** — Ability to react to drops/peaks.
- **BPM Sync Tolerance (ms)** — Player forgiveness window.

## 1.2 Secondary Stats
Automatically derived using primary stats & Resonance.
- **Effective HP:** HP + Armor × mitigation value.
- **Damage Multiplier:** Base multiplier affected by Resonance.
- **Speed Modifier:** Affects animation timings.
- **Heal Efficiency:** Affects healing card performance.

## 1.3 Hidden Stats (used internally)
- **Rhythm Stability Index** — Measures consistency over time.
- **Resonance Drift Value** — How fast resonance decays.
- **Trigger Responsiveness** — Latency compensation.

---

# 2. PLAYER STATES

States define the internal machine behavior.

### 2.1 Major States
- **Idle:** Awaiting beat or player input.
- **Listening:** BeatDetector actively scanning waveform.
- **Beat Window Active:** Player can act.
- **Card Charging:** Player pre-emptively holds a card.
- **Trigger Response:** Player reacting to drop/peak/bass.
- **Low HP (<30%) State:** Gains panic bonuses.
- **Overdrive State:** Maximum resonance, boosted output.

### 2.2 Overdrive Conditions
- Resonance ≥ 100
- BPM Sync Stability ≥ 85%
- No recent “Miss” in last 5 beats

Overdrive lasts **8 beats** unless refreshed.

---

# 3. ENERGY LOOP — FULL SYSTEM

Energy is the player’s resource to deploy cards.

## 3.1 Energy Sources
- **+1 Energy per Beat Hit**
- **+2 on Perfect Beat**
- **+3 on Drop Trigger**
- **+5 on Peak Trigger (rare)**
- **+1 for 10-Beat Combo Chain**

## 3.2 Energy Loss
- **Miss (timing fail): –1**
- **Card Fumble (played outside window): –2**
- **Resonance Collapse: –3**

## 3.3 Energy Cap Effects
Default: 10 (expandable via progression)
- If Energy = 10 and gain occurs → Player generates **Resonance Surge (+5 resonance)** instead.

---

# 4. DAMAGE SYSTEM (FULL FORMULAS)

Damage output depends on:
1. Card Base Value
2. Beat Accuracy
3. Resonance State
4. Player Stats (Crit, Multiplier)
5. Drop Effects

## 4.1 Damage Formula
```
Damage = Base × BeatMod × ResonanceMod × CritMod × TriggerMod
```

## 4.2 Beat Window Modifiers
- **Perfect (±80ms): ×1.50**
- **Good (±150ms): ×1.20**
- **Poor (±250ms): ×1.00**
- **Miss (>250ms): ×0.00**

## 4.3 Resonance Modifiers
- Normal: ×1.00
- Elevated: ×1.10
- Charged: ×1.25
- Overdrive: ×1.50

## 4.4 Critical Hit Logic
```
If random() < CritChance: CritMod = CritDamage
Else: CritMod = 1.0
```

## 4.5 Trigger Modifiers
- Drop: ×1.30
- Peak: ×1.50
- Bass Hit: ×1.15

---

# 5. RESONANCE SYSTEM — FULL MODEL

Resonance is the metaphysical connection between player and The Pulse.

## 5.1 Resonance Gains
- Beat Hit: +2
- Perfect: +4
- Drop Trigger: +12
- Peak Trigger: +20
- Bass Hit Trigger: +6

## 5.2 Resonance Loss
- Miss: –5
- Card Fumble: –8
- Idle Too Long: –1 per 2 seconds

## 5.3 Resonance Stages Breakdown
### Stage 1 — Normal (0–39)
- No bonus

### Stage 2 — Elevated (40–69)
- +10% damage
- +5% energy gain

### Stage 3 — Charged (70–99)
- +25% damage
- +10% crit chance
- -10% decay

### Stage 4 — Overdrive (100)
See states above.

---

# 6. COMBAT RHYTHM ENGINE — FULL TECHNICAL

## 6.1 Beat Sync Logic
Beat interval:
```
beatInterval = 60 / BPM
```

Each frame:
```
currentTime = audioPlayer.get_playback_position()
expectedBeat = lastBeatTime + beatInterval
window = abs(currentTime - expectedBeat)
```

## 6.2 Timing Windows
```
if window ≤ 0.080: PERFECT
elif window ≤ 0.150: GOOD
elif window ≤ 0.250: POOR
else: MISS
```

---

# 7. PLAYER–CARD INTERACTION (ADVANCED)

## 7.1 Card Requirements
- Energy cost
- Beat timing
- Optional trigger timing
- Player state (cannot play while stunned, etc.)

## 7.2 Output Logic
```
if BeatWindow == MISS:
    Card fails
else:
    Execute card
```

## 7.3 Synergy System
Some cards gain bonuses if played:
- During Overdrive
- On Drop/Peak
- On specific beat numbers (4, 8, 16, 32…)

---

# 8. TRIGGER REACTION — FULL TABLE

| Trigger | Energy | Resonance | Bonus Effect |
|--------|---------|-----------|--------------|
| Drop | +3 | +12 | 30% dmg |
| Peak | +5 | +20 | 50% dmg |
| Bass Hit | +1 | +6 | Minor buff |

---

# 9. PROGRESSION SYSTEM — FULL TREE OUTLINE

## Level Up Rewards
- +HP
- +Armor
- +Energy Cap
- +Crit Chance
- +Resonance Decay reduction
- Unlock passive abilities

## Passive Ability Categories
- Rhythm Mastery
- Drop Affinity
- BPM Stability
- Resonance Flow
- Energy Channeling

---

# 10. FULL JSON SCHEMA (EXTENDED)
```json
{
  "player": {
    "stats": {
      "hp": 100,
      "armor": 0,
      "energy": 3,
      "crit_chance": 0.05,
      "crit_damage": 1.5,
      "sync_tolerance": 0.150,
      "resonance": 0
    },
    "progression": {
      "level": 1,
      "xp": 0,
      "xp_next": 100,
      "talents": []
    },
    "states": {
      "overdrive": false,
      "low_hp": false
    }
  }
}
```

---

# 11. GODOT IMPLEMENTATION — LOW LEVEL

## 11.1 Key Scripts
- Player.gd
- RhythmEngine.gd
- TriggerManager.gd
- CombatManager.gd
- CardExecutor.gd

## 11.2 Mandatory Functions
- process_beat()
- process_trigger()
- apply_damage()
- apply_resonance()
- update_state()
- handle_card()
- enter_overdrive()
- exit_overdrive()

---

# 12. FUTURE EXPANSIONS
- House-based stat multipliers
- Weapon/Artifact system
- Solo/Co-op modes
- Player roles (DPS/Tank/Support)
- Skill trees per House
- Resonance mutations
- Shadow Overdrive mechanic

