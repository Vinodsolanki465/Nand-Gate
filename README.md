# 🔳 SystemVerilog NAND Gate with Complete Verification Environment

**SystemVerilog nand gate with a complete verification environment**, including **interface**, **driver**, **monitor**, **scoreboard**, **randomized tests**, and **functional coverage** to ensure full validation of the design.

This project demonstrates the design and verification of a **2-input NAND gate** using SystemVerilog. Beyond the basic RTL implementation, it includes a **structured, modular verification environment** that showcases industry-standard verification practices used in **ASIC/FPGA development**.

---

## 🟦 **RTL Design**
- Implemented using **synthesizable SystemVerilog** constructs  
- Takes **two logic inputs (a, b)**  
- Produces **NAND output (y)**  
- Demonstrates the fundamental operation of a **universal logic gate**

---

## 🟧 **Verification Environment**
A modular SystemVerilog testbench environment is created to thoroughly verify the NAND gate.

It includes:

- **Interface** for connecting testbench and DUT  
- **Driver** to generate input stimulus  
- **Monitor** to collect output responses  
- **Scoreboard** to compare **actual vs expected results**  
- **Constrained-random test generation**  
- **Functional coverage** to ensure verification completeness  

This environment ensures all **input combinations** and **corner cases** are extensively tested.

---

## 🟩 **Key Features**
- **Synthesizable RTL** written in SystemVerilog  
- **Layered testbench architecture** (Driver, Monitor, Scoreboard)  
- **Randomized + Directed** test stimulus  
- **Functional coverage** collection for completeness  
- **Self-checking testbench**  
- **Beginner-friendly verification structure**  
- Reusable components for future digital design projects
