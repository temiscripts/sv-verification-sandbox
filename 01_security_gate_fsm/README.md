# Synchronous Security Gate FSM

A 2-state Finite State Machine (FSM) that controls a security gate. The gate starts locked and unlocks when a correct password signal is received. Think of it like an electronic door. It stays shut until you prove you are allowed in, and locks again the moment your credentials are removed.

## Architecture Highlights
**2-Always Block FSM Structure:** Follows modern SystemVerilog FSM guidelines. One always_ff block handles the sequential state register (what state are we currently in?), and one always_comb block handles next-state logic (what state should we go to next?). Keeping these separate makes the design easier to read, debug, and synthesize correctly.

**Synchronous Reset:** Reset only takes effect on a rising clock edge, meaning the system initialises to LOCKED in a controlled, predictable way tied to the clock.

**typedef enum:** States are declared as named types (LOCKED, UNLOCKED) rather than raw numbers, making the code self-documenting and reducing the chance of errors.

## Ports
| Signal | Direction | Width | Description |
|---|---|---|---|
| clk | input | 1-bit | Clock |
| rst | input | 1-bit | Synchronous reset, forces LOCKED state |
| password_ok | input | 1-bit | High = correct password presented |
| door_open | output | 1-bit | High = gate is unlocked |

## Verification
The testbench applies reset, then presents a correct password and verifies door_open goes high. It then removes the password and confirms the gate returns to locked. This verifies both state transitions: LOCKED to UNLOCKED and UNLOCKED to LOCKED.

**Race Condition Prevention:**
Stimulus changes are applied after a #1 delay following each clock edge (@(posedge clk); #1;), accurately modelling physical hold time requirements and preventing zero-delay race conditions between the testbench driving inputs and the FSM sampling them.