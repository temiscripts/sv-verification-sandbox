# Synchronous Security Gate FSM

This module implements a synchronous Finite State Machine (FSM) for a security gate, alongside a self-contained testbench to verify state transitions and output logic.

## Architecture Highlights
* **3-Always Block Structure:** The design strictly adheres to modern SystemVerilog FSM guidelines, separating sequential state memory (`always_ff`), combinational next-state logic (`always_comb`), and continuous output assignments (`assign`).
* **Synchronous Reset:** Ensures the system reliably initializes to a known `LOCKED` state.

## Verification Strategy
The accompanying testbench (`security_gate_tb.sv`) verifies the FSM's response to password inputs across multiple clock cycles. 

**Race Condition Prevention:**
The stimulus block explicitly utilizes a `#1` intra-assignment delay after the active clock edge (e.g., `@(posedge clk); #1;`). This accurately models physical hardware hold times and prevents zero-delay race conditions between the testbench driving the inputs and the FSM sampling them.