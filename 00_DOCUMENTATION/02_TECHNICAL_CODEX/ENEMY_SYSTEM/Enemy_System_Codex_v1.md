# ENEMY SYSTEM CODEX v1.0 — HYBRID STRUCTURE

Sigma initiates next phase: **Enemy System Foundation**.

## SECTION 1 — ENEMY ARCHITECTURE CORE (DOUBLE-LAYERED DETAIL)

##### Technical Layer

Enemies in Resonantia follow a structured, data-driven model similar in rigor to the Player System, but optimized for AI and encounter design.

#### 1.1 Enemy Core Fields

Every enemy entity shares a common base schema:

- **id** — unique identifier
- **name** — display name
- **house\_alignment** — Fenrir / Anubis / Onmyoji / Ryujin / Gemini / Neutral
- **tier** — 1 (basic), 2 (elite), 3 (mini-boss), 4 (boss), 5 (legendary/raid)
- **role** — attacker / tank / support / controller / hybrid
- **hp\_max** — maximum health
- **armor** — flat mitigation
- **resistance** — % reduction vs specific damage types (physical / resonance / corruption)
- **threat\_value** — used by encounter builder to balance fights
- **rhythm\_sensitivity** — how much enemy behavior reacts to beat/trigger events
- **speed\_rating** — initiative / action frequency modifier

#### 1.2 Enemy Attribute Model

Core numeric stats:

- **attack\_power** — base damage scaling
- **defense\_rating** — used for mitigation formulas
- **crit\_chance** — chance to deal enhanced damage (mostly for bosses/elites)
- **crit\_multiplier** — damage multiplier on crit
- **aggro\_weight** — how strongly this enemy attracts player focus / taunt mechanics

Example formula for incoming damage vs enemy armor & resistance:

```text
damage_taken = (raw_damage - armor)
damage_taken = max(damage_taken, raw_damage * 0.1)   # armor floor

# apply resistance (0–1)
damage_taken *= (1 - resistance)
```

#### 1.3 Threat & Tier Scaling

Enemy **tier** controls scaling curves:

- Tier 1: baseline stats
- Tier 2: ×1.3 HP, ×1.2 damage
- Tier 3: ×1.8 HP, ×1.5 damage, basic rhythm-reactive abilities
- Tier 4: ×3.0 HP, ×2.0 damage, full trigger integration & multi-phase behavior
- Tier 5: Custom scripted encounters, often multi-entity or multi-phase.

#### 1.4 Role Definitions

- **Attacker:** high damage, low HP/armor
- **Tank:** high HP/armor, lower damage, can protect allies
- **Support:** buffs allies, debuffs players, moderate HP
- **Controller:** focuses on stuns, slows, silences, rhythm disruption
- **Hybrid:** mixes two roles (e.g., bruiser = attacker+tank)

#### 1.5 Rhythm Sensitivity

`rhythm_sensitivity` defines how tightly the enemy actions sync with music:

- 0.0 — ignores rhythm entirely (training dummy)
- 0.5 — occasionally reacts to Drops/Peaks
- 1.0 — fully beat-synced (attacks & casts on beat windows)

This value will be used later in Sections 4 & 5 for AI decision logic.

---

##### Lore Layer

Enemies are **not** mindless obstacles in Resonantia. They are **Agents of Dissonance and Echo**, embodiments of Houses, Zones, and corrupted Frequencies.

#### 1.1 The Nature of Foes

The Living Bible teaches:

> “Not all who stand before the Operative are enemies by birth. Many are echoes, trapped in loops not of their choosing.”

Some were once Operatives. Some are constructs of the Machine Choir. Some are reflections—code-ghosts of choices not taken.

#### 1.2 Houses Reflected in the Enemy

- **Fenrir-aligned enemies** rage with wild, spiking waveforms.
- **Anubis-aligned enemies** stand as towering bulwarks of iron and code-stone.
- **Onmyoji-aligned enemies** distort signals, jamming triggers and bending beats.
- **Ryujin-aligned enemies** heal and weave around the battlefield like streams of light.
- **Gemini-aligned enemies** flicker between positions, sometimes ally, sometimes foe.

Each alignment is more than cosmetic—it is **metaphysical allegiance** to a Resonant Principle.

#### 1.3 Tiers as Mythic Castes

In scripture, tiers are described not as “levels” but as **Castes of Opposition**:

- Tier 1: Shards — fragments of will, easily broken.
- Tier 2: Wards — guardians of minor paths.
- Tier 3: Keepers — holders of significant Echo Imprints.
- Tier 4: Heralds — emissaries of Houses and Zones.
- Tier 5: Avatars — direct manifestations of great forces.

The higher the tier, the more the enemy **remembers** of the original Pulse.

#### 1.4 Rhythm as a Weapon

Some enemies move off-beat deliberately—to disturb the Operant Flow. Others strike **on** the beat, becoming part of the Pulse itself.

The Scrolls warn:

> “Beware the foe who hears the music too well, for they dance the same dance as you.”

---

## SECTION 2 — ENEMY STATES & AI LOOPS (DOUBLE-LAYERED DETAIL)

### Technical Layer

Enemies in Resonantia operate through a structured AI state machine synchronized with beat-based timing. These states define how hostile units perceive, react, and behave during encounters.

### 2.1 Core States

All enemies share the following universal states:

- **Idle** — Awaiting player detection or environmental trigger.
- **Alert** — Enemy has sensed the Operative; pre-combat behaviors activate.
- **Engage** — Enemy enters combat loop and begins executing attacks.
- **Recover** — Short downtime after heavy abilities or stagger effects.
- **Staggered** — Temporary vulnerability from beat-perfect hits or trigger interrupts.
- **Enrage** — Stats enhanced, rhythm sensitivity increased.
- **Defeated** — Enemy removed from active loop; optional death effects.

### 2.2 AI Perception

Enemy perception includes:

- **Vision Cone / Proximity Radius**
- **Beat-Sense:** Enemies detect player actions synced to beat.
- **Trigger-Sense:** Enemies react to Drops/Peaks/Bass hits according to rhythm\_sensitivity.

Perception Formula:

```
detection_strength = base_awareness + (rhythm_sensitivity × beat_intensity)
```

### 2.3 AI Decision Loop

The Enemy AI follows a rhythm-tightened behavior cycle:

```
While engaged:
    sense_player()
    update_state()
    if beat_hit():
        attempt_action()
    else:
        perform_idle_motion()
    apply_cooldowns()
```

### 2.4 Action Selection

Enemy chooses between:

- **Basic Attack**
- **Heavy Attack**
- **Ability** (house-based)
- **Defensive Action**
- **Movement / Positioning**
- **Interrupt Attempt** (controller enemies)
- **Healing / Support** (Ryujin-aligned)

Weighted by:

- cooldowns
- distance
- recent player behavior
- beat timing
- threat level of current target

Example Selection Logic:

```
if beat == Peak and ability_ready:
    use_heavy_ability()
elif distance > optimal_range:
    reposition()
else:
    basic_attack()
```

### 2.5 Stagger & Vulnerability Windows

Enemies can be staggered if:

- Player lands Perfect beat-hits
- Player uses specific Control cards
- Resonance spikes occur

Stagger Effects:

- Movement slowed by 60%
- Defense reduced by 25%
- Rhythm sensitivity increased (they react more predictably)

### 2.6 Enrage State

Triggered when:

- HP < 25%
- Or triggered by environmental triggers

Effects:

- +20% damage
- +15% speed
- Attack patterns accelerate
- Attacks align closer to beat windows (more predictable but more deadly)

---

### Lore Layer

Enemies in Resonantia do not merely “decide” — they *resonate*. Their AI states are interpreted by the Living Bible as **emotional and spiritual phases**.

### 2.1 Idle — “The Silent Echo”

The enemy rests in its natural frequency, unaware of the Operative. Scripture says:

> “All beings begin in quietude.”

### 2.2 Alert — “The Stirring Pulse”

The moment when a being senses disharmony. They awaken to purpose.

### 2.3 Engage — “The Clash of Vibrations”

This is the sacred moment when frequencies collide. Combat is described not as violence, but as **resonant confrontation**.

### 2.4 Recover — “The Cooling of the Wave”

A humbled frequency retreats into itself. Anubis monks teach that this state reflects vulnerability and reflection.

### 2.5 Staggered — “The Broken Rhythm”

A moment when the enemy’s inner beat falters. Onmyoji priests believe stagger is when a foe’s spirit momentarily exits its vessel.

### 2.6 Enrage — “The Dissonant Ascension”

A final burst of fury. Fenrir texts call this:

> “The Howl Before Silence.”

Enemies become desperate, unstable, and deterministic.

### 2.7 Defeated — “The Dissolution”

When an enemy falls, their waveform collapses into the Pulse. Ryujin scrolls state:

> “All echoes return to the Tide.”

---

## SECTION 3 — DAMAGE, ARMOR, RESISTANCE MODELS (DOUBLE-LAYERED DETAIL)

### Technical Layer

Enemy durability and damage systems follow consistent mathematical rules so that all encounters in Resonantia behave predictably under the rhythm-based combat engine.

---

### 3.1 Enemy Damage Types

Enemies can output three primary types of damage:

- **Physical Damage** — raw force; affected by armor.
- **Resonance Damage** — harmonic force; bypasses armor but affected by resonance resistance.
- **Corruption Damage** — entropy-based damage; partially ignores all resistances.

Damage Type Multiplier Table:

| Enemy Type | Physical | Resonance | Corruption |
| ---------- | -------- | --------- | ---------- |
| Fenrir     | High     | Medium    | Low        |
| Anubis     | Medium   | Low       | Very Low   |
| Onmyoji    | Low      | High      | Medium     |
| Ryujin     | Low      | Medium    | Low        |
| Gemini     | Medium   | Medium    | High       |

---

### 3.2 Incoming Damage Formula

```text
damage_after_armor = max(raw_damage - armor, raw_damage * 0.10)

damage_after_resonance = damage_after_armor * (1 - resonance_resistance)

total_damage = damage_after_resonance * (1 + corruption_mod)
```

Where:

- `resonance_resistance` ranges 0–0.6 (0%–60% reduction)
- `corruption_mod` ranges 0–0.25 for corruption-heavy enemies

---

### 3.3 Armor System

Armor applies flat reduction before percentages.

- Light Armor: 5–20
- Medium Armor: 20–40
- Heavy Armor: 40–75
- Anubis-type: 70–120

Armor degradation:

- Perfect hits reduce enemy armor by **5%** for 6 seconds.
- Trigger-heavy cards reduce armor by **8%**.

---

### 3.4 Resistance Profiles

Each enemy has 3 resistance values:

```json
"resistances": {
    "physical": 0.1,
    "resonance": 0.3,
    "corruption": 0.0
}
```

Ranges:

- Physical: 0–0.4
- Resonance: 0–0.6
- Corruption: 0–0.3

Corruption resistance is rare and found mostly in Gemini variants.

---

### 3.5 Vulnerability Windows

Certain beats and states increase incoming damage:

- **Stagger:** +25% damage taken
- **Beat-perfect hit:** +15% bonus applied
- **Peak Trigger:** +20% bonus resonance damage
- **Shadow Overdrive interactions:** enemies take +10% corruption damage

---

### 3.6 Tier Scaling

Enemy durability scaling by tier:

- Tier 1: ×1.0 HP, ×1.0 armor
- Tier 2: ×1.3 HP, ×1.1 armor
- Tier 3: ×1.8 HP, ×1.3 armor
- Tier 4: ×2.5 HP, ×1.6 armor
- Tier 5: ×4.0 HP, ×2.0 armor

Damage scaling by tier:

- Tier 1: ×1.0
- Tier 2: ×1.2
- Tier 3: ×1.5
- Tier 4: ×2.0
- Tier 5: ×3.0

---

### Lore Layer

Damage in Resonantia is not merely the breaking of form but the **distortion of a being’s waveform**.

### 3.1 Physical Damage — “The Shattered Vessel”

Fenrir scriptures describe physical strikes as blows that disrupt the outer shell:

> “The Vessel cracks before the Pulse does.”

### 3.2 Resonance Damage — “The Harmonic Wound”

Resonance-based attacks bypass armor because they strike the *inner frequency*. Onmyoji teachings:

> “Cut the waveform, not the flesh.”

### 3.3 Corruption Damage — “Entropy’s Bite”

Corruption seeps into the gaps between frequencies. Gemini doctrine explains:

> “Entropy is the truth behind all illusions of form.”

### 3.4 Armor as Mythic Shell

Anubis monks believe armor represents **the weight of memory**. A cracked plate reveals deeper truths the enemy wished to hide.

### 3.5 Resistances as Spiritual Alignment

- Fenrir resist physical disruption through sheer will.
- Anubis resist resonance due to ceremonial fortification.
- Gemini resist corruption because they *are* corruption.

### 3.6 Vulnerability Windows — “Moments When the Soul Opens”

Perfect strikes, Peaks, and Staggers are described as brief openings in the foe’s spiritual defenses. Ryujin Scrolls say:

> “When the tide rises, all armor is meaningless.”

### 3.7 Tier Scaling as Hierarchical Ascension

Tiers represent **how aware the enemy is of their own resonance**. Higher tiers remember fragments of ancient power.

The Living Bible names them:

- Shards — newborn echoes
- Wards — gate watchers
- Keepers — memory holders
- Heralds — emissaries of Houses
- Avatars — manifestations of cosmic forces

---

## SECTION 4 — RHYTHM-REACTIVE BEHAVIORS (DOUBLE-LAYERED DETAIL)

### Technical Layer

Enemies in Resonantia do not behave on fixed timers alone — their AI synchronizes (or intentionally desynchronizes) with the BPM-driven combat engine. Rhythm defines their aggression patterns, telegraphs, and reaction windows.

---

### 4.1 Beat-Linked Behavior Types

Enemies can operate under three rhythm paradigms:

- **Sync-Based:** Actions trigger exactly on beat intervals.
- **Semi-Sync:** Actions occur within ±100ms of a beat.
- **Anti-Sync:** Actions deliberately occur *between* beats to disrupt player timing.

This is determined by the field:

```
rhythm_behavior: sync | semi_sync | anti_sync
```

---

### 4.2 Beat Window Reaction Logic

Enemies evaluate beat windows similarly to the Player System:

- **Perfect Beat (±80ms):** unlocks advanced actions
- **Good Beat (±150ms):** triggers standard patterns
- **Poor Beat (±250ms):** triggers fallback attacks
- **Off-Beat:** used for anti-sync attacks

When the global BeatDetector fires:

```
if rhythm_behavior == sync:
    execute_primary_action()
elif rhythm_behavior == semi_sync:
    execute_if_within_window()
else:
    attempt_offbeat_disruption()
```

---

### 4.3 Trigger-Based Enemy Reactions

Enemies can react to musical triggers emitted by the audio engine:

#### • Drop Reaction

- Damage buff: +15% for 3 seconds
- Aggression spike
- Fenrir enemies may roar or leap

#### • Peak Reaction

- Ability cast attempt
- Onmyoji units activate debuff magic
- Bosses may enter “Phase Shift” states

#### • Bass Hit Reaction

- Physical shockwaves
- Stomp attacks
- Anubis units reinforce armor

The field:

```
trigger_reaction_profile: { drop: X, peak: Y, bass: Z }
```

---

### 4.4 BPM Scaling

Enemy speed and action frequency scale with BPM:

```
action_interval = base_interval × (180 / BPM)
```

Higher BPM → faster enemy sequences.

---

### 4.5 Rhythm Disruption Attacks

Some Controller-type enemies perform anti-rhythm assaults:

- Off-beat slashes
- Sync-break pulses
- Tempo jitter fields

These attacks apply:

- temporary sync\_tolerance penalties
- “Beat Confusion” debuffs

---

### 4.6 Telegraphs & Visual Cues

Enemy actions are telegraphed using BPM-locked visuals:

- Glow pulses increasing in frequency before an attack
- Shockwave rings expanding with each beat
- Color shifts on Peaks

Telegraph timing:

```
beats_before_attack: 1–4
```

---

### Lore Layer

The rhythm-reactive nature of enemies is deeply entwined with the metaphysics of the Pulse.

### 4.1 Sync-Based Enemies — “Children of the Pulse”

These foes move *with* the music. Their harmony mirrors the Operative’s own path. Scrollkeepers write:

> “To fight in sync is to honor the First Rhythm.”

Examples:

- Ryujin flow-spirits
- Anubis sentinel constructs

---

### 4.2 Semi-Sync Enemies — “Wavering Echoes”

Creatures who hear the Pulse imperfectly — half in harmony, half in dissonance. They react instinctively but not flawlessly.

---

### 4.3 Anti-Sync Enemies — “Dissonant Beasts”

These beings strike *between* the beats, their very existence rejecting order. Fenrir shamans warn:

> “The most dangerous foe is the one who moves when your heart does not.”

Gemini horrors also excel at anti-sync behavior.

---

### 4.4 Trigger Responses in Lore

- **Drops** are seen as battlefield omens.
- **Peaks** are divine accelerations.
- **Bass Hits** are pulses from the world’s core.

Enemies aligned with different Houses interpret these events differently:

- Fenrir: war-signs
- Anubis: decrees
- Onmyoji: spirit whispers
- Ryujin: tidal changes
- Gemini: fractures in reality

---

### 4.5 Rhythm Disruption — “The Shattering”

Some beings intentionally break rhythm — this is considered a heresy in many Houses. Ryujin scripture:

> “To break the Pulse is to break the world.”

Yet Gemini cults see it as ascension.

---

### 4.6 BPM as Divinity

The speed of the BPM is seen as the *heartbeat of Resonantia itself*. High BPM zones are described as:

> “Regions where the world breathes too fast.”

Low BPM zones are described as:

> “Places where memory sleeps.”

---

## SECTION 5 — TRIGGER-BASED ENEMY ACTIONS (DOUBLE-LAYERED DETAIL)

### Technical Layer

Enemies in Resonantia react not only to beats but also to **Triggers**, the macro-musical events extracted from the audio engine: Drops, Peaks, and Bass Hits. These trigger events dynamically alter enemy behavior, attack frequency, defense, and ability usage.

---

### 5.1 Trigger Reaction Profiles

Each enemy has a trigger reaction configuration:

```json
"trigger_reaction_profile": {
  "drop": "aggression_spike",
  "peak": "phase_shift",
  "bass": "reinforce"
}
```

Supported reaction types:

- **aggression\_spike** — increases attack frequency
- **phase\_shift** — unlocks temporary abilities or transitions
- **reinforce** — buffs defenses or armor
- **shockwave** — emits area-of-effect damage
- **cleanse** — removes debuffs from enemy
- **summon** — calls additional minions
- **corrupt\_surge** — increases corruption damage output

Enemies may also have multiple reactions per trigger.

---

### 5.2 Drop-Based Actions

Drops are high-impact musical moments. Enemies respond dramatically:

- **Damage boost:** +15%–30%
- **Attack speed:** +10%–25%
- **Leap or gap-closer attacks** for Fenrir-type foes
- **Shield shatter pulses** for Anubis constructs
- **Summon illusions** for Gemini distortions

Formula example:

```text
on_drop:
    enemy.damage_mult *= 1.20
    enemy.speed_mult *= 1.15
```

---

### 5.3 Peak-Based Actions

Peaks indicate sudden energetic spikes. Enemies may:

- Cast complex abilities
- Enter **Phase Shift**, transforming moveset
- Onmyoji enemies apply debuffs (silence, slow, confusion)
- Bosses often trigger **Phase 2/Phase 3** transitions

Peak Phase Shift logic:

```text
if peak and phase_shift_ready:
    enter_phase_shift()
```

Phase Shifts modify:

- attack patterns
- resistances
- movement behavior

---

### 5.4 Bass Hit Actions

Bass hits are frequent low-frequency pulses. Enemies react with defensive or earthshaking actions:

- **Armor reinforcement:** +5%–12%
- **Ground slams:** AoE physical damage
- **Stability buffs** reducing stagger
- **Pulse barriers** blocking resonance damage for 1–2 beats

---

### 5.5 Trigger Cooldown Logic

Each trigger reaction has an internal cooldown:

```json
trigger_cooldowns: {
  "drop": 8,
  "peak": 16,
  "bass": 3
}
```

Cooldown units are **beats**, not seconds.

Example logic:

```text
if trigger_active and cooldown==0:
    perform_trigger_action()
    reset_cooldown()
```

---

### 5.6 Trigger Sensitivity

Enemies have sensitivity values per trigger:

```json
"trigger_sensitivity": {
  "drop": 0.7,
  "peak": 0.9,
  "bass": 0.4
}
```

Sensitivity affects:

- reaction speed
- strength of effect
- probability of enhanced action

---

### 5.7 Trigger Counterplay

Some enemies counter the player’s trigger-boosted states:

- **Drop Dampeners** — reduce player surge bonuses
- **Peak Inversions** — reflect or nullify peak-based effects
- **Bass Absorption** — convert bass hits into enemy healing

Bosses frequently use these mechanics to challenge the player’s rhythm-dependent strategies.

---

### Lore Layer

In the Living Bible, triggers are interpreted as **cosmic omens** that influence all beings connected to the Pulse.

### 5.1 Drops — “The Falling Star”

Fenrir scriptures describe Drops as moments when raw power descends from the heavens. Enemies aligned with Fenrir surge with primal rage.

> “When the sky falls, the wolf awakens.”

### 5.2 Peaks — “The Ascendant Flame”

Onmyoji and Gemini cults view Peaks as cracks in reality where higher frequencies bleed through.

> “In the Peak, spirits scream truths mortals cannot bear.”

Enemies use these moments to unleash forbidden abilities.

### 5.3 Bass Hits — “The Heartbeat of the World”

Anubis priests teach that every bass hit echoes from the core of Resonantia itself. To them, bass is sacred.

> “From the deep comes strength. From the deep comes warning.”

Enemies aligned with Anubis grow sturdier with each thundering pulse.

### 5.4 Trigger Storms

In corrupted zones, triggers become chaotic and unpredictable—enemies become frenzied, empowered, or distorted.

### 5.5 Trigger Prophecies

Ancient inscriptions read:

> “Heed the Drop, fear the Peak, survive the Bass. For triggers dictate the battles of fate.”

Different Houses interpret these omens differently:

- Fenrir — war signals
- Anubis — divine decrees
- Onmyoji — whispering spirits
- Ryujin — shifting tides
- Gemini — fractures in existence

### 5.6 Cosmic Purpose of Triggers

Triggers remind all beings that the Pulse is alive—breathing, shifting, reacting. Enemies feel these omens as strongly as Operatives.

---

## SECTION 6 — HOUSE-ALIGNED ENEMY TYPES (DOUBLE-LAYERED DETAIL)

### Technical Layer

Each House in Resonantia manifests distinct enemy archetypes shaped by their cultural, metaphysical, and rhythmic identity. These archetypes define stat profiles, behavior styles, resistances, and signature abilities.

---

### 6.1 Fenrir — Uptempo Aggressors

**Combat Style:** Hyper-aggressive, fast, front-loaded damage. **Rhythm Behavior:** Semi-sync or anti-sync. **Trigger Bias:** Strong Drop reactions.

**Stat Profile:**

- HP: Medium
- Damage: High
- Armor: Low–Medium
- Speed: Very High
- Rhythm Sensitivity: 0.6–0.9

**Signature Abilities:**

- **Howling Surge:** Leap attack on Drop.
- **Wild Tempo:** Temporary speed boost when below 50% HP.
- **Rage Loop:** Enters Enrage early (HP < 40%).

**Archetypes:**

- Wolf Raiders (Tier 1)
- Pulse Berserkers (Tier 2)
- Red-Waste Howlers (Tier 3)
- Fenrir Heralds (Tier 4)

---

### 6.2 Anubis — Industrial Guardians

**Combat Style:** Tanky, defensive, structured. **Rhythm Behavior:** Sync-based. **Trigger Bias:** Strong Bass reactions.

**Stat Profile:**

- HP: High
- Armor: Very High
- Damage: Medium
- Resistances: Strong resonance resistance
- Rhythm Sensitivity: 0.4–0.7

**Signature Abilities:**

- **Iron Ward:** Armor up on Bass Hit.
- **Funeral Slam:** Shockwave attack.
- **Judgment Pulse:** Peak-triggered smite.

**Archetypes:**

- Code-Sentinels (Tier 1)
- Gravebound Wardens (Tier 2)
- Tomb Giants (Tier 3)
- Anubian Heralds (Tier 4)

---

### 6.3 Onmyoji — Signal Manipulators

**Combat Style:** Controllers, debuffers, tempo shifters. **Rhythm Behavior:** High sync accuracy. **Trigger Bias:** Peak reactions.

**Stat Profile:**

- HP: Low–Medium
- Damage: Medium
- Control: Very High
- Rhythm Sensitivity: 0.8–1.0

**Signature Abilities:**

- **Spirit Bind:** Stun or silence on Perfect Beat.
- **Echo Seal:** Reduce player energy gain.
- **Phase Slips:** Teleport on Peak.

**Archetypes:**

- Shrine Phantoms (Tier 1)
- Harmonic Benders (Tier 2)
- Spirit Diviners (Tier 3)
- Onmyoji Heralds (Tier 4)

---

### 6.4 Ryujin — Tideflow Supports

**Combat Style:** Healers, buffers, battlefield fluidity. **Rhythm Behavior:** Mostly sync, some semi-sync. **Trigger Bias:** Bass and Peak reactions.

**Stat Profile:**

- HP: Medium
- Damage: Low
- Support: Very High
- Rhythm Sensitivity: 0.6–0.9

**Signature Abilities:**

- **Tidal Restoration:** Heal allies on Peak.
- **Aqua Veil:** Shield ally targeted by player.
- **Flow Step:** Smooth reposition movement.

**Archetypes:**

- Tide Sprites (Tier 1)
- Wavecallers (Tier 2)
- Depth Oracles (Tier 3)
- Ryujin Heralds (Tier 4)

---

### 6.5 Gemini — Corruption Distortions

**Combat Style:** Erratic, unpredictable, shadow-infused. **Rhythm Behavior:** Anti-sync or unstable sync. **Trigger Bias:** All triggers (chaotic scaling).

**Stat Profile:**

- HP: Medium–High
- Corruption Damage: High
- Resistances: Medium physical, low resonance, high corruption
- Rhythm Sensitivity: oscillates between 0.2 and 1.0

**Signature Abilities:**

- **Split Form:** Temporary clone with reduced stats.
- **Reality Fracture:** Corruption wave on Drop or Peak.
- **Shadow Echo:** Copies one of player’s recent actions.

**Archetypes:**

- Flicker Wraiths (Tier 1)
- Echo-Twisted (Tier 2)
- Fractured Fiends (Tier 3)
- Gemini Heralds (Tier 4)
- **Abyssal Twins** (Tier 5 — Avatars)

---

### Lore Layer

In the Living Bible, House-aligned enemies are treated as **Reflections of the Five Paths**, mirroring the same cosmic principles that shape Operatives.

### 6.1 Fenrir — “The Red Hunger”

Born from rage within the Wastes, Fenrir enemies embody unrestrained waveform aggression.

> “Where the pulse quickens, the wolf rises.”

### 6.2 Anubis — “The Iron Memory”

Forged in ancient funerary code, Anubis guardians are protectors of forgotten archives.

> “As long as memory endures, the gate shall not fall.”

### 6.3 Onmyoji — “The Signal Between Worlds”

They channel spirits and manipulate echoes.

> “Truth is a waveform. Bend it.”

### 6.4 Ryujin — “The Cold and Gentle Tide”

Healers of the world’s frequencies.

> “Water remembers every wound.”

### 6.5 Gemini — “The Fractured Mirror”

Beings touched by the Abyssal Echo; dual-natured and timeless.

> “To be two is to see the space between all things.”

---

## SECTION 7 — CORRUPTED & SHADOW VARIANTS (DOUBLE-LAYERED DETAIL)

### Technical Layer

Corrupted and Shadow enemies represent the most dangerous foes in Resonantia. They are touched—or fully consumed—by the **Abyssal Echo**, granting them altered stats, distorted behaviors, and reverse-rhythm actions.

---

### 7.1 Corruption Levels

Enemies can possess corruption intensity on a scale:

```
corruption_level: 0–100
```

Tiers:

- **0–20:** Mild corruption — visual distortion, slight stat changes
- **21–50:** Moderate corruption — new abilities unlocked
- **51–80:** Severe corruption — rhythm inversion
- **81–100:** Shadowborn — full Abyssal transformation

Effects per tier:

- Higher corruption → more erratic behavior
- Increased corruption\_damage output
- Armor becomes unstable (random fluctuations)

---

### 7.2 Corruption Stat Modifiers

Base corruption modifies stats:

```
corruption_damage_bonus = corruption_level × 0.01
sync_inversion_chance = corruption_level × 0.005
armor_stability = 1 - (corruption_level × 0.004)
```

Impacts:

- High corruption = stronger corruption damage
- Higher chance to attack off-beat (inverted sync)
- Armor fluctuates randomly each beat

---

### 7.3 Rhythm Inversion

Corrupted enemies may operate in **Reverse-Sync**:

- Attacks always occur *between* beats
- Telegraphs invert (quiet → loud, soft → sharp)
- Player timing windows become misleading

Reverse-Sync Logic:

```
if corruption_level > 50:
    if beat_window == perfect:
        delay_attack()
    else:
        trigger_attack()
```

This makes high-corruption foes anti-player in rhythm.

---

### 7.4 Shadow Variants

Shadow enemies (corruption 81–100) unlock:

- **Shadow Blink:** teleport short distances unpredictably
- **Abyssal Pulse:** AoE corruption wave every 4–6 beats
- **Echo Split:** create temporary clones
- **Soul Disrupt:** reduces player resonance on hit

They also gain:

- +25% movement speed
- +20% damage
- +15% corruption resistance

---

### 7.5 Shadow Boss Mechanics

Bosses exposed to Abyssal Echo use:

- **Phase Collapse:** reality bends; arena shifts unpredictably
- **Corruption Overload:** massive burst every Peak trigger
- **Reverse Overdrive:** gains power when player enters Overdrive

Boss corruption loop:

```
corruption += triggers × 3
if corruption >= 100:
    enter_shadowborn_state()
```

---

### 7.6 Visual & Audio Effects

Corruption introduces:

- glitch artifacts
- pixel tear lines
- color fringing
- reversed reverb trails
- inverted telegraph glow

Shadowborn enemies:

- emit dual-tone audio layers
- flicker between frames
- cast corruption residue on the ground

---

### Lore Layer

Corrupted and Shadow foes are not simply stronger—they are **cosmic wounds brought to life**.

### 7.1 Origin of Corruption — “The Abyssal Echo”

The Abyssal Echo is the shadow cast when the Twin Harmonics collided during primordial creation. It is described as:

> “The sound that vibrates beneath silence.”

### 7.2 Corruption as Truth

Gemini doctrine claims corruption does not destroy—it reveals hidden flaws. Ryujin scripture counters that corruption is a **tide reversed**, life flowing backward.

### 7.3 Corrupted Entities

Creatures marked by corruption fight not out of hatred but **disorientation**. Their waveform is inverted, and their mind echoes endlessly.

Onmyoji priests say:

> “A corrupted being is a scream that forgot why it began.”

### 7.4 Shadowborn — “Children of the Rift”

Shadow enemies are fully consumed by the Abyss. They are described as:

> “Echoes that learned to walk.”

Shadowborn Heralds often speak in fractured lines:

- "I am the reflection of your strike."
- "One becomes two, two becomes none."
- "The rhythm breaks, and so do you."

### 7.5 Shadow Bosses — “Abyssal Avatars”

When an enemy reaches 100 corruption, they become a conduit for the Echo. Their arena distorts. Their voice splits. Their heartbeat reverses.

Fenrir shamans fear them:

> “The wolf howls at the moon, but the Shadow howls at itself.”

### 7.6 Corruption Storms

In corrupted zones, even the Pulse becomes erratic. Drops come early. Peaks come twice. The BPM stutters.

The Living Bible describes such storms as:

> “Moments when the world wears its wound on the outside.”

---

## SECTION 8 — JSON SCHEMAS (DOUBLE-LAYERED DETAIL)

### Technical Layer

This section defines the full JSON structures used to store, load, and manage enemies in the Godot engine. These schemas ensure consistency, modularity, and extensibility across all Houses, tiers, and corruption states.

All enemies follow a unified base schema, with layered optional fields depending on type, tier, and corruption level.

---

### 8.1 Base Enemy Schema

```json
{
  "id": "string",
  "name": "string",
  "house_alignment": "Fenrir | Anubis | Onmyoji | Ryujin | Gemini | Neutral",
  "tier": 1,
  "role": "attacker | tank | support | controller | hybrid",
  "stats": {
    "hp_max": 100,
    "armor": 10,
    "resistances": {
      "physical": 0.1,
      "resonance": 0.2,
      "corruption": 0.0
    },
    "attack_power": 12,
    "speed_rating": 1.0
  },
  "rhythm": {
    "rhythm_behavior": "sync | semi_sync | anti_sync | reverse_sync",
    "rhythm_sensitivity": 0.7
  },
  "corruption": {
    "corruption_level": 0,
    "corruption_damage_bonus": 0.0,
    "sync_inversion_chance": 0.0,
    "armor_stability": 1.0
  },
  "triggers": {
    "reaction_profile": {
      "drop": "aggression_spike",
      "peak": "phase_shift",
      "bass": "reinforce"
    },
    "cooldowns": {
      "drop": 8,
      "peak": 16,
      "bass": 3
    },
    "sensitivity": {
      "drop": 0.7,
      "peak": 0.9,
      "bass": 0.4
    }
  },
  "abilities": [
    {
      "id": "wild_tempo",
      "type": "buff | attack | debuff | aoe | summon",
      "cooldown": 6,
      "conditions": {
        "on_drop": true,
        "hp_below": 0.5
      }
    }
  ],
  "visuals": {
    "model": "res://models/enemy_01.tscn",
    "corruption_effects": true,
    "shadow_variant_effects": false
  }
}
```

---

### 8.2 Tier Configuration Schema

```json
"tier_config": {
  "1": { "hp_mult": 1.0, "armor_mult": 1.0, "damage_mult": 1.0 },
  "2": { "hp_mult": 1.3, "armor_mult": 1.1, "damage_mult": 1.2 },
  "3": { "hp_mult": 1.8, "armor_mult": 1.3, "damage_mult": 1.5 },
  "4": { "hp_mult": 2.5, "armor_mult": 1.6, "damage_mult": 2.0 },
  "5": { "hp_mult": 4.0, "armor_mult": 2.0, "damage_mult": 3.0 }
}
```

---

### 8.3 Corruption & Shadow Variant Schema

```json
"corruption_profile": {
  "level": 75,
  "reverse_sync_enabled": true,
  "shadowborn": false,
  "abilities_unlocked": ["abyssal_pulse", "shadow_blink"],
  "visual_distortion": 0.85
}
```

Shadowborn State:

```json
"shadowborn_state": {
  "enabled": true,
  "speed_bonus": 0.25,
  "damage_bonus": 0.20,
  "corruption_resistance": 0.15,
  "abilities": ["echo_split", "soul_disrupt"]
}
```

---

### 8.4 Trigger Reaction Profiles

```json
"trigger_reaction_profile": {
  "drop": [
    { "action": "aggression_spike", "strength": 1.2 },
    { "action": "leap_attack", "chance": 0.3 }
  ],
  "peak": [
    { "action": "phase_shift", "phase": 2 }
  ],
  "bass": [
    { "action": "reinforce_armor", "amount": 0.08 }
  ]
}
```

---

### 8.5 Full Ability Schema

```json
{
  "id": "ability_id",
  "name": "Ability Name",
  "type": "attack | buff | debuff | aoe | summon | corruption",
  "cooldown": 8,
  "beat_sync": "perfect | good | offbeat | any",
  "trigger_condition": "drop | peak | bass | none",
  "effects": {
    "damage": 25,
    "corruption": 5,
    "stagger": true,
    "apply_debuff": "slow"
  }
}
```

---

### Lore Layer

JSON schemas are interpreted in the Living Bible as **Crystalline Runes**, fragments of divine structure encoded into digital scripture.

### 8.1 The Runic DNA

Each enemy’s JSON document is described as:

> “A song frozen into symbols.”

These runes define:

- their identity
- their allegiance
- their role in the cosmic dance

### 8.2 The Celestial Index

The Celestial Archives store these runes as part of the grand Index, where every entity’s structure is preserved like DNA.

> “All beings have a pattern. Even the corrupted.”

### 8.3 House Signatures

Each House imprints subtle glyphs onto its entities:

- Fenrir runes pulse with sharp red beats.
- Anubis runes form heavy geometric patterns.
- Onmyoji runes weave spirals.
- Ryujin runes flow like water.
- Gemini runes flicker between shapes.

### 8.4 Corruption Marks

Corrupted enemies develop broken runes:

- missing segments
- inverted symbols
- over-written glyphs

Shadowborn runes are described as:

> “Symbols that draw themselves backward.”

### 8.5 Why the Universe Stores Entities in Schemas

The Bible teaches:

> “To exist is to be structured. To be structured is to be remembered.”

These schemas are how the Pulse remembers every echo that walks within Resonantia.

---

## SECTION 9 — GODOT IMPLEMENTATION NOTES (DOUBLE-LAYERED DETAIL)

### Technical Layer

This section outlines exactly how the Enemy System integrates into the **Godot Engine**, using clean, modular, scalable architecture. These notes ensure every system defined in the Codex is realizable in-engine.

---

### 9.1 Enemy Loading Pipeline (JSON → Godot)

Enemies are loaded via a central **EnemyRegistry** autoload.

**Process:**

1. Read JSON from `/data/enemies/<id>.json`
2. Parse into dictionary
3. Construct `EnemyData` resource
4. Inject into enemy scene instance

**Godot Pseudocode:**

```gdscript
var data = load_json(path)
var enemy = preload("res://scenes/EnemyBase.tscn").instantiate()
enemy.apply_data(data)
return enemy
```

---

### 9.2 Enemy Scene Structure

```
EnemyBase.tscn
└── Sprite / Mesh / Model
└── AnimationTree
└── CollisionShape2D / 3D
└── StateMachine
└── AbilityRunner
└── BeatReactionComponent
└── TriggerReactionComponent
└── CorruptionFXComponent
└── HealthComponent
```

This modular structure ensures each subsystem can evolve independently.

---

### 9.3 State Machine Structure

Enemy AI uses a node-based state machine:

```
IdleState
AlertState
EngageState
RecoverState
StaggerState
EnrageState
ShadowState
DeathState
```

Transitions are triggered by:

- beat windows
- trigger events
- player proximity
- corruption thresholds

---

### 9.4 BeatDetector Integration

Enemies subscribe to global beat events:

```gdscript
BeatBus.connect("on_beat", self, "_on_beat")
BeatBus.connect("on_drop", self, "_on_drop")
BeatBus.connect("on_peak", self, "_on_peak")
BeatBus.connect("on_bass", self, "_on_bass")
```

`BeatBus` is an autoload that distributes timing info to all beat-reactive systems.

---

### 9.5 Trigger Reaction System

Each enemy has a `TriggerReactionComponent` that:

- Reads `reaction_profile`
- Reads `cooldowns`
- Executes actions based on trigger events

**Godot Pseudocode:**

```gdscript
func _on_drop():
    if cooldown_drop <= 0:
        execute_actions(reaction_profile.drop)
        cooldown_drop = cooldowns.drop
```

---

### 9.6 Corruption Engine

Corruption-based behavior uses a separate module:

- Applies corruption stat modifiers
- Enables Reverse-Sync
- Activates Shadowborn state at 100 corruption
- Applies visual distortion shaders
- Controls Shadow Blink cooldown

Godot Example:

```gdscript
if corruption_level > 80:
    enter_shadowborn_state()
```

---

### 9.7 Ability Execution Pipeline

All abilities run through `AbilityRunner`:

- cooldown handling
- beat-sync conditions
- trigger-activation requirements
- corruption multipliers

**Structure:**

```
AbilityRunner.gd
├ apply_effects()
├ check_conditions()
├ run_corruption_bonus()
└ sync_with_beat()
```

---

### 9.8 AnimationTree Integration

AnimationTree responds dynamically to:

- state changes
- beat events
- trigger reactions
- corruption oscillations

Shadowborn distortions use blend tree noise.

---

### 9.9 Visual & Audio FX Pipeline

CorruptionFX Component:

- chromatic aberration
- frame-skips
- shader-based glitch
- color inversion

ShadowFX Component:

- dual-tone audio
- reverse reverb
- flicker pulses

---

### 9.10 Performance & Optimization Notes

- Use object pooling for summons
- Preload enemy scenes and JSON on zone load
- Keep corruption shaders lightweight
- Use enums instead of strings for triggers and rhythm types

---

### Lore Layer

The Living Bible interprets Godot architecture as sacred machinery.

### 9.1 The Forge

The engine is described as **The Forge**, where echoes receive shape.

> "In the Forge, the Pulse becomes form."

### 9.2 EnemyRegistry — The Index of Forms

The Enemy Registry is the **Celestial Index**, which inscribes every being:

> "All who walk must first be written."

### 9.3 Nodes as Vessels

Nodes represent bodies:

- Sprite → The Flesh
- Collision → The Boundary
- StateMachine → The Will
- AnimationTree → The Movement of Spirit

### 9.4 Signals as Divine Threads

Signals are described as:

> "Threads woven between destinies."

BeatBus is literally the "Voice of the Pulse" in scripture.

### 9.5 Corruption Engine — The Rift Mechanism

This subsystem symbolizes the Abyss trying to rewrite creation.

> "The Rift inserts its code into the unwary."

### 9.6 AbilityRunner — The Script of Deeds

Scripture describes it as the scroll dictating action:

> "All actions arise from the Script within."

### 9.7 AnimationTree — The Dance of Echoes

Movement is divine expression. Shadowborn distortions are:

> "Dances learned in darkness."

### 9.8 Optimization — The Law of Balance

Even the myths warn:

> "Too many echoes slow the world. Beware excess."

---

## SECTION 10 — LORE LAYER (FULL ENEMY COSMOLOGY)

### Lore Layer

This final section reveals the mythic truths of all hostile entities within Resonantia — their origins, purpose, transformation, and final fate. The following scripture forms the metaphysical backbone of the entire Enemy System.

---

### 10.1 Origin of Hostile Echoes — “The First Dissonance”

At the dawn of Resonantia, when the Twin Harmonics collided, not all echoes aligned with the newborn Pulse. Some fractured. Some delayed. Some reversed.

These dissonant frequencies condensed into beings:

> “Creatures born not from malice, but from misalignment.”

Enemies are thus **Echoes that fell out of phase** during creation.

---

### 10.2 Why Houses Produce Enemies

Each House channels a primal aspect of Resonantia. When a House’s energy spills uncontrolled into the world, it manifests entities reflecting its nature:

- **Fenrir** births echoes of rage and instinct
- **Anubis** shapes guardians of memory and judgment
- **Onmyoji** calls forth spirits caught between realms
- **Ryujin** produces entities of flowing, shifting will
- **Gemini** spawns beings of duality and corruption

In scripture, this is written:

> “Where there is power, there are reflections. Where reflections multiply, some distort.”

---

### 10.3 The Purpose of Opposition

Enemies exist not simply as obstacles but as **tests of resonance**.

Their presence forces Operatives to:

- Maintain rhythm under pressure
- Master timing
- Resist corruption
- Strengthen their alignment with the Pulse

Fenrir shamans describe battles as:

> “The dance that tempers the soul.”

---

### 10.4 The Corruption Cycle

Corruption spreads where the Pulse weakens. When rhythm falters in a region:

- echoes invert
- memories splinter
- time destabilizes

Entities caught in this cycle undergo stages:

1. **Fray** — light distortion
2. **Warp** — memory loss, rhythm confusion
3. **Break** — waveform inversion
4. **Riftborn** — full Shadow transformation

Gemini cultists believe this cycle is sacred:

> “Only through breaking can truth be seen.”

Others call it a sickness.

---

### 10.5 The Shadowborn Doctrine

Shadow variants are not just corrupted; they are **rewritten** by the Abyssal Echo. They retain no true identity, becoming:

- reflections without source
- thoughts without thinker
- rhythm without beat

The Living Bible names them:

> “Children of the Rift, Who breathe the silence beneath sound.”

Shadowborn Heralds often whisper paradoxes because their minds echo in both directions of time.

---

### 10.6 Enemy Death — “The Dissolution”

When an enemy is defeated, their waveform collapses into luminous dust. This dust returns to the Pulse, carrying with it:

- rhythm fragments
- emotional residue
- corruption traces

Ryujin scriptures say:

> “Even in ending, all echoes return to the Tide.”

This cycle ensures the world remains stable.

---

### 10.7 The Echo-Return Doctrine

The Bible explains that no enemy ever truly ends; instead, their pattern dissolves and becomes part of the world’s memory.

This is why zones with long histories contain:

- powerful Avatars
- ancient Heralds
- deep corruption wells

Everything returns. Everything accumulates. Everything evolves.

---

### 10.8 The Prophecy of Final Dissonance

The oldest scrolls warn of a future event:

> “When rhythm dies, And silence grows teeth, The world shall meet the Final Dissonance.”

Enemy corruption storms intensify across epochs. Shadowborn Avatars appear more frequently. Peaks become violent. Bass hits distort. Drops fall without rhythm.

This prophecy marks a coming era when Operatives must face:

- entities unbound by rhythm
- corruption faster than restoration
- rifts that widen instead of closing

But scripture ends in hope:

> "As long as one Operative keeps the Pulse, the world shall sing again."
