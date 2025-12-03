# PLAYER ENGINE CODEX v3.0  
## SECTION 03 — RESOURCE SYSTEMS  
*Power must flow. Rhythm dictates its shape.*

---

## 3.0 Purpose

Resource Systems govern **how Operatives generate, store, and spend power**.

They define:

- what the Operative can do  
- how often they can do it  
- what form their higher states take  
- how risk and reward interact  
- how rhythm and corruption influence their strength  

This section is the economic backbone of player expression.

---

## 3.1 Core Resources Overview

Operatives have access to three universal resource types:

1. **Energy** — basic ability fuel  
2. **Overdrive (OD)** — heightened combat performance  
3. **Shadow Overdrive (SOD)** — corrupted transformation state  

Additional optional systems (for future builds):

- **Burst Meter**  
- **Chain Gauge**  
- **Resonance Bar**  

These expand later, but the three core systems must always exist.

---

## 3.2 Energy System

Energy is the Operative’s **short-term ability resource**, replenishing frequently.

### Stored as:

```jsonc
Energy {
  current: float,
  max: float,
  regen_rate: float,
  regen_delay: float,
  last_spend_time: float
}
Energy Spend Rules:
basic abilities cost energy

energy cannot go below zero

energy recovery pauses briefly after spending

certain abilities may refund partial energy on PERFECT rhythm hits

Energy Regen Formula:
markdown
Copy code
if time_since_last_spend >= regen_delay:
    current += regen_rate * delta_time
Regen is modified by:

AGI (small boost)

RHM_OP (rhythm mastery)

corruption states

statuses (e.g. “Haste”, “Mana Burn”)

3.3 Overdrive (OD)
Overdrive is the Operative’s empowerment meter.
It enhances offensive and defensive capabilities.

Stored as:
jsonc
Copy code
Overdrive {
  current: float,
  max: float,
  state: "OFF" | "ON",
  decay_rate: float,
  gain_multiplier: float
}
OD Effects:
When activated:

increased movement speed

increased damage

larger PERFECT rhythm window

enhanced crit rate

improved ability scaling

Exact numbers are defined in “Transformation States” (Section 04).

OD Gain Sources:
dealing damage

taking damage

PERFECT rhythm actions

specific abilities or cards

corruption interactions (positive and negative)

OD Gain Formula Example:
makefile
Copy code
od_gain = base_gain
        + (damage_dealt * 0.1)
        + (rhythm_bonus)
OD Decay Rules:
When OD is active:

sql
Copy code
current -= decay_rate * delta_time
Decay can pause under certain rhythm conditions or increase under corruption.

3.4 Shadow Overdrive (SOD)
Shadow Overdrive is the corrupted ascension state,
granting immense power at the cost of stability.

SOD is never activated by a button.
It is triggered by:

reaching OD max under high corruption

specific corruption thresholds

certain ability chains

environmental conditions

Stored as:
jsonc
Copy code
ShadowOverdrive {
  state: "INACTIVE" | "CHARGING" | "ACTIVE" | "DRAINED",
  corruption_level_at_trigger: float,
  duration: float,
  max_duration: float,
  instability: float
}
SOD Effects:
When active:

massive stat boosts

corrupted variants of abilities

altered movement

altered rhythm interaction

altered target selection (slight auto-aim drift)

HP drain or OD drain over time

SOD End Conditions:
duration reaches max

corruption instability overload

player HP falls below threshold

manual purify action

environmental collapse (zones can break SOD)

3.5 Corruption → Resource Interaction
Corruption modifies resource behavior:

Energy:
regeneration may flicker

high corruption may invert regen (regen becomes drain)

abilities may cost more under corruption spikes

Overdrive:
corruption may increase OD gain

may freeze OD at certain thresholds

may cause random OD surges

Shadow Overdrive:
corruption determines:

activation

duration

stability

exit conditions

risk levels

Resource systems are the primary vector through which corruption affects gameplay.

3.6 Rhythm → Resource Interaction
Rhythm interacts with resources constantly:

PERFECT:
bonus OD gain

slight energy refund

extended OD duration

temporary stability in SOD

GOOD:
small OD gain

normal energy spend

LATE:
reduced OD gain

higher corruption chance

MISS:
partial resource loss

potential OD drop

severe corruption destabilization (rare)

3.7 Resource Caps & Safety Rules
Energy cannot exceed max.

OD cannot exceed max (except temporary corruption surges).

SOD has a max duration that cannot be surpassed.

SOD cannot be triggered twice in the same encounter unless specifically allowed.

Resource calculations must be deterministic.

Resource gains cannot loop recursively.

Resource decay cannot exceed safe limits.

Resource states must always be included in snapshot generation.

3.8 Debug & Replay Requirements
The Resource System must provide:

clear logs of OD gain/loss

timestamps for SOD activation/deactivation

snapshots of current energy

corruption states affecting resources

These are critical for balancing and QA.