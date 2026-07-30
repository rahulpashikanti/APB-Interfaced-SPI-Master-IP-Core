# 🚀 APB-Interfaced SPI Master IP Core using Verilog

## 📌 Project Overview

This project focuses on the implementation of an **APB-Interfaced SPI Master IP Core**, which was designed using **Verilog HDL**. The design integrates an **Advanced Peripheral Bus (APB) Slave Interface** with an **SPI Master Controller**, enabling a processor to communicate with SPI-compatible peripheral devices through memory-mapped registers.

To verify its functionality, I simulated the complete design using a custom Verilog testbench in **Xilinx Vivado 2026.1**.

The APB-SPI IP Core is a commonly used peripheral in modern System-on-Chip (SoC) architectures, providing an efficient bridge between a processor and SPI-based devices such as sensors, EEPROMs, Flash memories, and ADC/DAC modules. I developed this project as part of my learning journey in **VLSI Design & Verification**.

---

## 🛠️ Tools & Project Files

- **Language:** Verilog HDL
- **Software:** Xilinx Vivado 2026.1 (Behavioral Simulation)

---

## 🎯 Learning Outcomes

While working on this project, I gained hands-on experience in several key areas:

- Writing clean and synthesizable Verilog HDL code.
- Understanding the APB (Advanced Peripheral Bus) protocol.
- Designing an SPI Master Controller for serial communication.
- Developing modular RTL architectures for digital systems.
- Creating Verilog testbenches for functional verification.
- Debugging simulation waveforms using Xilinx Vivado.
- Integrating multiple RTL modules into a complete IP Core.

---

## 🔮 Future Improvements

In the next version of this project, I am planning to add the following features:

- **Support for All SPI Modes:** Implement configurable CPOL and CPHA settings.
- **Programmable Clock Divider:** Allow dynamic SPI clock frequency selection.
- **FIFO Buffers:** Add transmit and receive FIFOs for efficient data transfer.
- **Status & Interrupt Registers:** Implement Busy, Transfer Complete, and Error flags with interrupt support.
- **Parameterization:** Make the design configurable for different data widths.
- **Advanced Verification:** Develop a robust SystemVerilog/UVM-based verification environment.

---

## 👨‍💻 Author

**Rahul Pashikanti**  
**Aspiring VLSI RTL Design & Verification Engineer**

**📌 Areas of Interest:** VLSI Design, RTL Design, Design Verification, FPGA Design, Verilog & SystemVerilog.

- **Connect with Me: **www.linkedin.com/in/rahul-pashikanti-b818bb245
