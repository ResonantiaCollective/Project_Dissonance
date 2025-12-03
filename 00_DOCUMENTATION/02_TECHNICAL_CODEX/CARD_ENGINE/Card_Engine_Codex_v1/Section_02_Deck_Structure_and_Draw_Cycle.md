# CARD ENGINE CODEX v1.0  

## SECTION 02 — DECK STRUCTURE & DRAW/DISCARD CYCLE  

*The deck is a living circuit.*

---

## 2.0 Purpose

This section defines:

- how the deck is structured  
- how cards move between zones (draw, hand, discard, ether)  
- how reshuffles work  
- how corruption and rhythm influence the cycle  
- how the deck stays deterministic and replay-safe  

The deck is the **core loop** of the Card Engine.

---

## 2.1 Deck Zones

Cards can exist in exactly one of the following zones:

1. **DECK** (Draw Pile)  
2. **HAND**  
3. **DISCARD**  
4. **ETHER** (removed from play)  
5. **CORRUPTED_DECK** (optional layer for corrupted variants)

These zones are mutually exclusive state flags in `CardRuntimeState`.

---

## 2.2 Deck-Level Data Model

The deck as a whole is stored as:

```jsonc
DeckState {
  deck_id: string,
  owner_id: string,          // Operative ID
  main_deck: [string],       // card IDs in draw order (top = end or start, depending on convention)
  hand: [string],
  discard_pile: [string],
  ether: [string],
  corrupted_deck: [string],  // optional: mutated versions
  max_hand_size: int,
  draw_per_turn: int,
  turn_counter: int,
  reshuffle_counter: int,
  identity: DeckIdentity
}
DeckIdentity is defined in Scroll 000 (archetype, rhythm bias, corruption bias, etc.).

2.3 Deck Initialization
At the start of a run or encounter:

Build main_deck from selected cards.

Shuffle main deck (seeded RNG for replay correctness).

Clear hand, discard_pile, ether, corrupted_deck.

Draw opening hand:

scss
Copy code
for i in range(opening_hand_size):
    draw_card()
Log final initial state.

2.4 Draw Rules
Basic draw:
text
Copy code
draw_card():
    if main_deck not empty:
        move top card → HAND
    else:
        reshuffle()
        then draw again (if possible)
Constraints:

cannot draw beyond max_hand_size

if hand is full, drawn card may:

be sent to discard, or

be prevented from drawing (design choice)

Draw events are logged.

2.5 Discard Rules
When a card is played:

it normally moves from HAND → DISCARD.

Some cards may:

exhaust → HAND → ETHER

transform → HAND → CORRUPTED_DECK or other states

When a card is manually discarded:

HAND → DISCARD

All discards are logged for synergy and triggers.

2.6 Reshuffle Rules
When draw is requested but main_deck is empty:

Check if discard_pile is empty:

if yes → no draw possible (deck lock).

if no → proceed to reshuffle.

Move discard_pile → main_deck.

Apply corruption mutations (Section 03 will detail).

Shuffle main_deck with seeded RNG.

Increment reshuffle_counter.

Log reshuffle event.

Reshuffles must be deterministic across replays.

2.7 Ether Zone Rules
The ETHER is a one-way zone for:

exhausted cards

banished cards

temporarily removed cards (unless returned by special effects)

Rules:

ETHERED cards are not part of main_deck, hand, or discard_pile.

Corruption may send cards to ETHER.

Some rare abilities may return cards from ETHER → DISCARD or DECK.

ETHER state must be logged for full run history.

2.8 Corrupted Deck Layer (Optional)
For advanced corruption mechanics, a CORRUPTED_DECK may exist:

holds mutated versions of cards

may be drawn from during corruption storms

may replace or overlay the main deck partially

Example use:

At corruption threshold → certain cards mutate and are transferred to corrupted_deck.

Draw rules may pull from corrupted_deck first when under Corruption Storm status.

This layer is optional and versioned.

2.9 Turn-Based vs. Real-Time
The deck system must support both:

Turn-based draws (roguelite deckbuilder modes).

Real-time draws (action-hybrid modes).

Turn-based:
draw_per_turn at start of each turn

discard at end of turn

strong synergy with triggers and statuses

Real-time:
draw_timer instead of per-turn draw

automatic draw at intervals

TIMING and RHYTHM become more relevant for play speed

The DeckState can include:

jsonc
Copy code
{
  "draw_timer": float,
  "draw_interval": float
}
for real-time modes.

2.10 Rhythm & Draw Cycle
Rhythm influences:

bonus draws on PERFECT

delayed draw on MISS

conditional draw (only on GOOD+ actions)

combo draw (draw 1 for X PERFECT in a row)

Deck rules must avoid infinite draw loops.

2.11 Corruption & Draw Cycle
Corruption influences:

forced drawing of corruption cards

top-deck manipulation (forced bad cards)

shuffled mutations before reshuffles

extra reshuffles under corruption storms

These effects must always be:

logged

bounded

deterministic for the same seed

2.12 Integrity Rules
A card must belong to exactly one zone at any time.

Draws must never crash if deck and discard are empty—simply result in “no draw.”

Reshuffles must always consume the entire discard pile.

Corruption mutations must occur before reshuffle RNG.

Ethered cards must not accidentally re-enter the main cycle without explicit rules.

Real-time and turn-based modes must both read from the same deck structure.

DeckLock (no more playable cards) must be detectable for game logic.

All deck state changes must be loggable and reconstructable in replay.
