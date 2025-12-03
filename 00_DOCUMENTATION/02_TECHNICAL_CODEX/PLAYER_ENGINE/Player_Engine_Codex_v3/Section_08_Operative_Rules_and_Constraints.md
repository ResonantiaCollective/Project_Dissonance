# PLAYER ENGINE CODEX v3.0  
## SECTION 08 — OPERATIVE RULES & CONSTRAINTS  
*A system without constraints is not a system — it is chaos.*

---

## 8.0 Purpose

This section defines the **rules that all Operatives must obey**, regardless of:

- build  
- stats  
- corruption  
- rhythm  
- progression  
- transformation  
- abilities  

These rules ensure:

- deterministic behavior  
- fairness  
- engine stability  
- replay accuracy  
- balance integrity  

This is the *law layer* for the Player Engine.

---

## 8.1 Action Integrity Rules

1. Operatives must not generate actions while:
   - stunned  
   - frozen  
   - silenced (abilities only)  
   - in transformation lock  
   - dead  

2. No action may bypass the Action Framework.  
3. All actions must enter the Resolution Pipeline.  
4. Actions must always reference current snapshots (stats, rhythm, corruption).  
5. MISS on a rhythm action must never cause hidden success.  
6. Invalid targets must stop the action cleanly.  
7. Actions must be logged with timestamp and source.

---

## 8.2 Movement Integrity Rules

1. Movement must be deterministic based on:
   - AGI  
   - statuses  
   - corruption  
   - current transformation  

2. Dash must always respect:
   - collision  
   - movement locks  
   - stun states  

3. Movement drift from corruption must be readable and capped.  
4. Dashing must not allow clipping through geometry.  
5. Movement snapshots must remain sync-safe for replays.

---

## 8.3 Resource Integrity Rules

1. Energy cannot go negative.  
2. Overdrive cannot exceed its maximum (except temporary corruption spikes).  
3. Shadow Overdrive must always end cleanly.  
4. Resource updates must be atomic (no partial states).  
5. Resource loops must not self-trigger infinitely.  
6. OD and SOD decay must always tick reliably across frames.  
7. Rhythm refunds/bonuses must never exceed safe caps.

---

## 8.4 Transformation Integrity Rules

1. Only one transformation per category may exist at once.  
2. SOD overrides OD.  
3. OD cannot activate during SOD.  
4. Transformations must revert **all** modified values on exit.  
5. Entry and exit conditions must be clearly defined.  
6. No transformation may bypass Snapshot generation.  
7. Transformations must be logged.  
8. SOD risk must always be present at high corruption.  
9. Environmental states must never delete OD/SOD effects — only override temporarily.

---

## 8.5 Rhythm Integrity Rules

1. Timing windows must never reach zero.  
2. Corruption modifications to rhythm must remain within defined caps.  
3. Rhythm must never break input priority.  
4. Rhythm classification must be deterministic.  
5. Rhythm cannot be bypassed by abilities or build bonuses.  
6. MISS must always override PERFECT/LATE logic.  
7. Rhythm modifiers must not stack in infinite loops.  
8. Rhythm Snapshots must always be included in the Resolution Pipeline.

---

## 8.6 Corruption Integrity Rules

1. Corruption must never permanently modify stats unless explicitly defined.  
2. Corruption instability must always be bounded.  
3. Corruption cannot skip system layers:
   - Action  
   - Resource  
   - Rhythm  
   - Transformation  

4. SOD must always be triggered at Breach level (Level 4).  
5. Cleanse events must fully purge temporary distortions.  
6. Corrupted ability variants must follow ability rules.  
7. Corruption cannot instantly kill an Operative unless in Breach or extreme design.

---

## 8.7 Build Integrity Rules

1. Builds must not bypass stat caps.  
2. Build path bonuses must be versioned and deterministic.  
3. Corruption builds must always have a real risk component.  
4. Rhythm builds must not trivialize rhythm windows.  
5. Divergent builds must remain readable despite chaos.  
6. Build transitions must follow strict state rules and must update snapshots.

---

## 8.8 Snapshot Integrity Rules

Snapshots must always contain:

- Combat Stats  
- Rhythm Snapshot  
- Corruption State  
- Resource States  
- Active Transformations  
- States & Privileges

Rules:

1. Snapshots must be atomic.  
2. Snapshots must not carry over expired states.  
3. Snapshots must be used for all action resolution.  
4. Snapshots must remain deterministic under replay.  
5. Snapshots must be logged for debugging.

---

## 8.9 Debug & Telemetry Requirements

Player Engine must log:

- action history  
- resource history (Energy, OD, SOD)  
- corruption changes  
- rhythm input  
- transformation entry/exit  
- errors and invalid state transitions  

These logs are used by:
- Combat Engine  
- AI Engine  
- Debug Tools  
- Replay System

---

## 8.10 Fail-Safe Rules

1. If corruption reaches undefined state → clamp to max tier.  
2. If snapshot fails → regenerate immediately.  
3. If transformation fails to exit → force revert + log error.  
4. If rhythm clock desyncs → resync to master clock.  
5. If resource loop detected → break loop and clamp values.  
6. If build bonuses exceed safe max → clamp and warn.  
7. If action invalid → cancel safely without crash.

---

*SECTION 08 ends here.*  
**PLAYER ENGINE CODEX v3.0 — COMPLETE.**