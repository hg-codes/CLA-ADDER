# 4-bit Carry Look-Ahead Adder (CLA Adder) – Full Design and Implementation

This project presents the complete design, simulation, and implementation of a **4-bit Carry Look-Ahead Adder (CLA)** using SPICE, MAGIC layout, Verilog, and FPGA-based testing. The design includes CMOS logic gates, pass-transistor-based XOR gates, and a TSPC-based D Flip-Flop to achieve high speed and area efficiency.

---

## 📐 Technology & Specifications

- **Technology Node**: 180nm (LAMBDA = 0.09µm)
- **CMOS Sizing**:
  - NMOS Width (Wn) = 10 × LAMBDA
  - PMOS Width (Wp) = 2 × Wn
  - MOSFET Length = 2 × LAMBDA

---

## ⚙️ Design Components

### ➤ Logic Gate Implementations

- **Inverter**: Static CMOS, sized with Wn & Wp as per standard.
- **XOR Gate**: Implemented using Pass Transistor Logic (PTL).
- **AND Gate**: NAND gate + inverter (series NMOS, parallel PMOS).
- **OR Gate**: NOR gate + inverter (parallel NMOS, series PMOS).

---

## 🔄 Flip-Flop Design

- **D Flip-Flop**:
  - Implemented using **TSPC (True Single Phase Clock)** logic.
  - Includes buffer to avoid signal degradation.
  - **Clock-to-Q delay**: 0.140 ns
  - **Hold time**: 0 ps
  - **Setup time**: 107 ps

---

## 🧪 Simulation & Layout

- **SPICE Simulation**: Validates timing parameters (delay, setup, hold).
- **MAGIC Layout**: Post-layout simulations show accurate waveform behavior and confirm design integrity.
- **GTKWave Outputs**:
  - D Flip-Flop (1-bit)
  - D Flip-Flop (4-bit)
  - 4-bit CLA Adder terminal outputs and waveform

---

## 💻 FPGA & Verilog Implementation

- **Verilog Structural Modeling**:
  - Individual gates (AND, OR, XOR)
  - D Flip-Flop
  - 4-bit CLA Adder
- **Waveform Analysis**: Verified using GTKWave.
- **Terminal Output**: Shows correct binary sum and carry outputs based on sample inputs.

---

## 📊 Performance Summary

| Metric           | Value      |
| ---------------- | ---------- |
| Clock-to-Q Delay | 0.140 ns   |
| Setup Time       | 107 ps     |
| Hold Time        | 0 ps       |
| Gate Style       | CMOS + PTL |
| Flip-Flop Style  | TSPC       |

---

## 🧾 Conclusion

This project demonstrates a full digital design workflow starting from logic equations to SPICE simulations, layout generation in MAGIC, and functional verification using Verilog and GTKWave. The use of CLA logic ensures high-speed arithmetic, and the optimized layout and flip-flop design contribute to the circuit’s overall efficiency and reliability.

---
