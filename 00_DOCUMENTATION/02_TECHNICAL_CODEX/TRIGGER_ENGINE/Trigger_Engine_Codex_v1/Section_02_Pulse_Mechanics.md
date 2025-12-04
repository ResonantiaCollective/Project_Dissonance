# Trigger Engine Codex v1  
## Section 02 — Pulse Mechanics

---

### 2.1 Purpose

Define how musical tempo (BPM) is translated into discrete gameplay triggers:
- Beat
- Half-beat
- Measure
- Special pulse events

---

### 2.2 Inputs

- BPM (from metadata or analysis)
- Track position (optional future extension)
- Manual overrides

---

### 2.3 Outputs (Signals)

- `beat`
- `half_beat`
- `measure`
- Optional: `drop`, `peak`, `breakdown`

---

### 2.4 Usage

Other engines subscribe to pulse events:

- Card Engine — timing windows for card play
- Combat Engine — damage windows / bonuses
- Zone Engine — hazard pulses
- Audio System — visual sync, UI feedback

---

### 2.5 Configuration

Initial config:
- Default BPM
- Mapping to real-time intervals
- Tolerance / latency notes

---

### 2.6 Future Work

- Track-aware pulse
- Multiple layers of rhythm (subdivisions, polyrhythms)
