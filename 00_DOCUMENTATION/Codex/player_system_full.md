# PLAYER SYSTEM — COMPLETE SPECIFICATION (v1.0)

## 1. PLAYER CORE ARCHITECTURE
### 1.1 Base Stats
- HP (Health Points)
- Armor
- Energy
- Resonance Level
- Crit Chance
- Crit Damage
- Beat Accuracy Rating
- Drop Reaction Rating
- BPM Sync Tolerance

### 1.2 Derived Stats
- Effective HP
- Damage Multiplier
- Speed Modifier
- Heal Efficiency

### 1.3 States
- Idle
- Beat Listening
- Beat Window Active
- Card Charging
- Trigger Response
- Low HP State (<30%)
- Overdrive State

## 2. ENERGY LOOP
- Energy Pool (0-10)
- Gain per Beat
- Gain per Drop Trigger
- Consumption per Card
- Bonus from Perfect Beat chains

### 2.1 Energy Events
- On Beat: +1 Energy
- On Perfect Sync: +2 Energy
- On Drop Trigger: +3 Energy
- On Miss: -1 Energy

## 3. DAMAGE SYSTEM
### 3.1 Damage Types
- Base Damage
- Beat Damage
- Drop Damage
- Crit Damage
- Overdrive Damage

### 3.2 Damage Formula
Damage = (Card Base × Player Multiplier) × Beat Window Modifier × Resonance State

### 3.3 Beat Window Types
- Perfect (±80ms)
- Good (±150ms)
- Poor (±250ms)
- Miss (>250ms)

### 3.4 Beat Window Modifiers
- Perfect: ×1.5
- Good: ×1.2
- Poor: ×1.0
- Miss: 0

## 4. RESONANCE SYSTEM
### 4.1 Resonance Meter
- Fills with every beat hit
- Fills more with drop triggers
- Decays on misses

### 4.2 Resonance Stages
1. Normal
2. Elevated
3. Charged
4. Overdrive

### 4.3 Overdrive Bonuses
- +30% Damage
- +20% Energy Generation
- +10% BPM Sync Tolerance

## 5. COMBAT RHYTHM ENGINE
### 5.1 Core Loop
1. Audio Playing
2. Beat Detector Running
3. Player Input
4. Timing Window Calculation
5. Outcome Determined
6. Card Activated
7. Trigger Effects Applied

### 5.2 Timing Sync
- AudioStreamPlayer Position → Beat Interval
- Beat Δ = |inputTime – expectedBeat|

### 5.3 Window Definitions
- perfectWindow = 0.080s
- goodWindow = 0.150s
- poorWindow = 0.250s

## 6. PLAYER–CARD INTERACTION
### 6.1 Card Requirements
- Energy Cost
- Timing Requirement
- Trigger Requirement (optional)

### 6.2 Card Output
- Damage
- Armor
- Heal
- Buff/Debuff

### 6.3 Multipliers
FinalValue = CardValue × BeatModifier × ResonanceModifier × TriggerBonus

## 7. TRIGGER REACTION SYSTEM
### 7.1 Trigger Types
- Drop
- Peak
- Bass Hit

### 7.2 Player Responses
- Damage Spike
- Energy Surge
- Overdrive Entry
- Armor Surge

## 8. PROGRESSION SYSTEM
### 8.1 XP Events
- Victory
- Beat Chains
- Trigger Perfects

### 8.2 Level Rewards
- Stat Points
- Resonance Expansion
- Energy Cap increase

## 9. JSON SCHEMA
```json
{
  "player": {
    "hp": 100,
    "armor": 0,
    "energy": 3,
    "resonance": 0,
    "stats": {
      "crit_chance": 0.05,
      "crit_damage": 1.5,
      "sync_tolerance": 0.15
    },
    "progression": {
      "level": 1,
      "xp": 0,
      "next_level": 100
    }
  }
}
```

## 10. GODOT IMPLEMENTATION
### 10.1 Nodes
- Player
- BeatDetector
- CombatManager
- CardHand

### 10.2 Signals
- onBeat
- onPerfect
- onDrop
- onPlayerDamage
- onPlayerEnergyChange

### 10.3 Script Functions
- apply_damage()
- grant_energy()
- apply_resonance()
- enter_overdrive()

## 11. FUTURE EXPANSIONS
- House-based modifiers
- Player equipment
- Skill trees
- Resonance perks
- Card mastery system

