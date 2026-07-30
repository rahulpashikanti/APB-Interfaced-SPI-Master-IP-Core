🚀 APB-Interfaced SPI Master IP Core using Verilog

📌 Project Overview

This project focuses on the design and implementation of an APB-Interfaced SPI Master IP Core using Verilog HDL. The SPI Master is controlled through an Advanced Peripheral Bus (APB) interface, allowing a processor to communicate with SPI-compatible peripheral devices in a structured and efficient manner.


The design was developed and functionally verified using Xilinx Vivado 2026.1 with a custom Verilog testbench. This project helped me understand the integration of standard on-chip communication protocols and strengthened my knowledge of RTL design and digital communication interfaces.



🛠️ Tools & Project Files
Language: Verilog HDL
Simulation Tool: Xilinx Vivado 2026.1 (Behavioral Simulation)
Protocols Used:
Advanced Peripheral Bus (APB)
Serial Peripheral Interface (SPI)


📂 Project Files
baud_rate_generator.v - baud_rate_generator_tb.v
slave_select.v - slave_select_tb.v
shift_reg.v - shift_reg_tb.v
apb_slave_interface.v - apb_slave_interface_tb.v



⚙️ Features
APB Slave Interface for processor communication
SPI Master supporting full-duplex communication
Configurable SPI clock generation
Chip Select (CS) control
Serial data transmission (MOSI)
Serial data reception (MISO)
Multiple SPI slave support
Behavioral simulation and functional verification


🎯 Learning Outcomes
Through this project, I gained hands-on experience in:

Designing synthesizable Verilog RTL modules.
Understanding the APB protocol and register-based communication.
Implementing the SPI Master protocol (MOSI, MISO, SCLK, CS).
Integrating multiple hardware modules into a complete IP Core.
Developing Verilog testbenches for functional verification.
Debugging simulation waveforms using Xilinx Vivado.
Understanding SoC peripheral interface design.


🔮 Future Improvements

Future enhancements planned for this project include:

Support for all four SPI modes (CPOL & CPHA configuration)
Programmable SPI clock divider
FIFO buffers for transmit and receive operations
Interrupt generation on transfer completion
Error detection and status flag registers
Parameterizable data width (8/16/32-bit)
Advanced verification using SystemVerilog and UVM
APB4 protocol support with additional features


👨‍💻 Author

Rahul Pashikanti
Aspiring VLSI Design & Verification Engineer

Areas of Interest

RTL Design
Digital Design
Design Verification
VLSI System Design
FPGA Development
Verilog & SystemVerilog

Connect with Me:
www.linkedin.com/in/rahul-pashikanti-b818bb245 
