# COMBAT ENGINE CODEX v1  
## SECTION 07 — TARGETING SYSTEM  
*Precision → Geometry → Execution*

---

## 7.0 Purpose of the Targeting System

The Targeting System defines **who or what** an action can affect.

It is responsible for:

- validating targets  
- selecting valid targets  
- computing hitboxes and geometry  
- resolving line-of-sight checks  
- handling projectiles  
- handling AoE  
- managing transformations under corruption  

No action proceeds until targeting is validated.

---

## 7.1 Targeting Categories

### **Single Target**
- Selects exactly 1 valid target  
- Must be enemy or ally based on action rules  
- Fails if target is invalid or out of range

Examples:
- Frequency Shot  
- Healing Pulse  
- Corrosion Needle  

---

### **Multi-Target**
- Selects several targets within constraints  
- Used for chain lightning, multi-hit slashes, etc.

Limit types:
- max count  
- proximity priority  
- corruption priority  
- weakest-first targeting  

---

### **Area of Effect (AoE)**
Shapes include:
- Circle  
- Cone  
- Rectangle  
- Ray  
- Ring  
- Sphere (3D future-proofing)

Abilities define:
- radius  
- angle  
- origin point  
- direction vector  

The system resolves all actors intersecting the shape.

---

### **Projectile Targeting**
Projectiles are entities with:

- position  
- velocity  
- direction  
- lifetime  
- collision geometry  
- corruption sensitivity  
- rhythm sensitivity  

They may:

- pierce  
- explode  
- bounce  
- chain  
- multiply under corruption  

The targeting system validates collision → then sends packet to Resolution Pipeline.

---

### **Self-Target**
Actor targets themselves.

Used for:
- buffs  
- cleanses  
- transformations  
- stances  

---

## 7.2 Target Validation Rules

Before an action commits, all targets must satisfy:

is_alive
is_targetable
is_in_range
not_in_safe_zone
not_in_locked_state
not_in_faction_protected_state

diff
Copy code

Faction rules:

- Players cannot hit allies (unless chaos mechanics)  
- Enemies can target players or enemies depending on AI behavior  
- Bosses may ignore faction protections  

Range rules use:

distance(actor, target) <= ability.range

yaml
Copy code

---

## 7.3 Geometric Resolution

Hit detection depends on geometry type.

### Circle:

distance <= radius

shell
Copy code

### Cone:

angle_between(actor_forward, direction_to_target) <= cone_angle
and distance <= cone_range

shell
Copy code

### Ray:

line_of_sight == true
and distance <= ray_length

shell
Copy code

### Rectangle / Box (for swipes):

target_position within oriented bounding box

yaml
Copy code

Geometry must be deterministic and match animations.

---

## 7.4 Line-of-Sight (LoS)

LoS checks consider:

- walls  
- props  
- environment obstacles  
- corruption fog (partial block)  

Certain abilities ignore LoS completely (e.g. homing attacks).

---

## 7.5 Target Filtering & Priority Layers

When multiple valid targets exist, the system applies priority:

1. **Primary Target** (closest to cursor/facing direction)  
2. **Distance Priority** (closest actors first)  
3. **Threat Priority** (AI-defined)  
4. **Corruption Priority** (targets with high corruption)  
5. **Faction Priority** (enemy > neutral > ally)

Filtering ensures predictable outcomes.

---

## 7.6 Rhythm Interaction

Rhythm affects targeting in subtle ways:

- PERFECT → expands cone angles slightly  
- GOOD → small range bonus  
- LATE → reduced accuracy (for projectiles)  
- MISS → severe projectile spread or mis-aim  

Example:

if rhythm_quality == PERFECT:
cone_angle += 5°

yaml
Copy code

Projectiles may gain precision or lose it depending on rhythm quality.

---

## 7.7 Corruption Interaction

Corruption can distort targeting:

- projectile curves  
- AoE radius warps  
- cones glitch in angle  
- rays become unstable  
- self-target actions accidentally target enemies (rare chaos effect)

Each ability’s corruption affinity dictates behavior:

- stable → minimal distortion  
- chaotic → heavy distortion  
- void → range inversion  
- glitch → duplication  

---

## 7.8 Target Lock & Unlock

Actions may **lock** onto a target temporarily:

- action completes even if target moves  
- projectiles home  
- melee follows movement subtly  

Target lock breaks if:

- target dies  
- target becomes untargetable  
- actor is stunned or interrupted  

---

## 7.9 Special Targeting Cases

### **Chain Targeting**
One hit leaps to another target based on priority.

### **Multi-Hit Sweeps**
Each sweep phase recalculates geometry.

### **Random Chaos Targeting**
Used for corruption-heavy abilities.

### **Transformation Targeting**
Abilities that change faction or shape recalc targeting rules dynamically.

---

## 7.10 Targeting Failure Modes

Targeting can fail because:

- no valid targets  
- out of range  
- LoS blocked  
- actor in stun/freeze  
- corruption misfire  
- invalid geometry  

Failure returns packet:

```jsonc
{
  "type": "target_fail",
  "reason": "...",
  "ability_id": "...",
  "actor": "..."
}
Pipeline stages do not run.

7.11 Targeting System Integrity Rules
Geometry must always resolve deterministically.

Rhythm cannot create infinite range/angle.

Corruption cannot override faction rules unless explicitly allowed.

Projectiles must always collide or expire.

Line-of-sight must never soft-lock AI or players.

No ability may hit more targets than its definition allows.

Target lock must cancel on stun/death.

These rules maintain fairness and avoid engine exploits.