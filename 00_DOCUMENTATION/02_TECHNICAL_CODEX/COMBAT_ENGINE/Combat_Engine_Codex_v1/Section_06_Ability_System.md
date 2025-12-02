# COMBAT ENGINE CODEX v1.0  
## SECTION 6 — ABILITY SYSTEM (PLAYER & ENEMY)

### Technical Layer

The Ability System unifies advanced actions for both Player and Enemy.

Abilities are:

- data-driven
- rhythm-aware
- trigger-reactive
- corruption-capable

---

### 6.1 Ability Categories

- **Strike Abilities** — enhanced attacks
- **Resonance Abilities** — harmonic skills
- **Corruption Abilities** — entropy powers
- **Support Abilities** — heals, shields, buffs
- **Control Abilities** — stuns, roots, silence, etc.
- **Ultimate / Overdrive Abilities** — large-impact skills gated by Overdrive or Shadow Overdrive

---

### 6.2 Ability Data Structure

```json
{
  "id": "pulse_strike",
  "type": "strike",
  "cast_time": 0.3,
  "recovery": 0.2,
  "cooldown_beats": 4,
  "resource_cost": 20,
  "beat_behavior": "perfect | good | poor | offbeat | any",
  "trigger_variant": {
    "drop": "pulse_strike_plus",
    "peak": "pulse_strike_overdrive"
  },
  "corruption_variant": "shadow_pulse_strike",
  "effects": {
  
    "damage": 40,
    "type": "resonance",
    "status": "stagger",
    "aoe_radius": 1.5
  }
}

6.3 Ability Scaling

Abilities scale with combat stats:
damage = base * (1 + Impact * 0.01)
damage *= beat_multiplier_from_Harmony
damage *= corruption_multiplier_from_Dissonance
recovery *= (1 - Flow * 0.004)

6.4 Trigger Variants

Abilities may transform when a Trigger is active:

Drop: damage / speed up

Peak: evolve into more complex variant

Bass: gain defensive / shockwave effects

Mapped via trigger_variant field.

6.5 Corruption Variants

At high corruption or in Shadow Overdrive, abilities may:

convert damage type to corruption

increase AoE / range

change beat behavior (off-beat bonuses)

reduce cast time

6.6 Cast & Recovery Frames

Ability lifespan:
cast_start → hit_frame → recovery → finish

Flow stat reduces cast and recovery durations.

6.8 Godot Implementation (AbilityRunner)

Core script:
AbilityRunner.gd
├ load_ability_data()
├ apply_variants()        # trigger + corruption
├ handle_cast_time()
├ trigger_hit_event()
├ apply_statuses()
├ finalize_cooldown()
└ log_event()

Lore Layer

6.1 Abilities as Words of Power

“To invoke is to shape the world with intention.”

Abilities are described as:

Words of Resonance

Whispers of Corruption

Shouts of Pulse

6.2 Trigger Variants as Divine Reactions

Drop → war command

Peak → revelation

Bass → heartbeat of the world

6.3 Corruption Variants as Forbidden Forms

“Power bends in the presence of the Rift.”

6.4 Cast & Recovery as Breath & Echo

Cast:

“The breath drawn before a name is spoken.”

Recovery:

“The echo that follows intention.”

6.5 Ultimate Abilities as True Names

Overdrive abilities are described as revealing fragments of the Operative’s True Name.