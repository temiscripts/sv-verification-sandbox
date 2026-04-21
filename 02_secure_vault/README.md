# Secure Vault FSM

A 2-state FSM that controls access to a vault using a 4-bit password. Unlike the basic security gate which accepts any "correct" signal, this module compares a presented 4-bit code against a hardcoded secret (4'b1100). The vault only opens when the exact code matches. Everything else keeps it locked.

## Architecture Highlights
**2-Always Block FSM Structure:** Same proven pattern as the security gate. always_ff for state register, always_comb for next-state logic. Clean separation of sequential and combinational concerns.

**localparam Secret Code:** The secret code is declared as localparam SECRET_CODE = 4'b1100, a constant that is locked to this module and cannot be overridden from outside during instantiation. This is intentional: a secret code that can be changed externally is not much of a secret.

**4-bit Password Comparison:** The FSM uses a direct equality check (password_in == SECRET_CODE) rather than a single-bit signal, making it more realistic as a security primitive.

## Ports
| Signal | Direction | Width | Description |
|---|---|---|---|
| clk | input | 1-bit | Clock |
| rst | input | 1-bit | Synchronous reset, forces LOCKED state |
| password_in | input | 4-bit | Code presented to the vault |
| vault_open | output | 1-bit | High = vault is unlocked |

## Verification
The self-checking testbench uses $display and conditional checks to verify two scenarios: presenting a wrong password (4'b1111) confirms the vault stays locked, and presenting the correct code (4'b1100) confirms it opens. Pass/fail results print directly to the transcript, making failures immediately visible without needing to inspect waveforms manually.

**Race Condition Prevention:**
Stimulus changes are applied after a #1 delay following each clock edge (@(posedge clk); #1;), accurately modelling physical hold time requirements and preventing zero-delay race conditions between the testbench driving inputs and the FSM sampling them.