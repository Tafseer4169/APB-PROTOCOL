# 🚌 APB Slave Verification using SystemVerilog (Non-UVM)

The **APB (Advanced Peripheral Bus) Slave Verification Environment** is a **SystemVerilog class-based, Non-UVM verification project** developed to verify the functionality of an APB slave RTL. The verification environment employs **constrained-random stimulus**, **mailbox-based communication**, **self-checking scoreboards**, and **functional coverage** to validate read, write, and error scenarios in accordance with the AMBA APB protocol.

---

## 🧠 Key Features

### 🏗️ Class-Based Verification Environment

* Built using **SystemVerilog Object-Oriented Programming (OOP)**.
* Modular verification components without using UVM.
* Easy to understand and extend for beginners.

### 🎲 Constrained Random Verification

* Randomized APB transactions.
* Configurable address and data constraints.
* Automatic generation of read and write operations.

### 📬 Mailbox-Based Communication

* Generator → Driver communication through mailbox.
* Monitor → Scoreboard communication through mailbox.
* Event-based synchronization between verification components.

### ✅ Self-Checking Scoreboard

* Maintains a reference memory model.
* Automatically compares DUT responses with expected results.
* Reports data mismatches and APB slave errors.

### 📊 Functional Coverage

* Address Coverage
* Read/Write Coverage
* Data Coverage
* PSLVERR Coverage
* Cross Coverage (Address × Read/Write)
* Cross Coverage (Error × Read/Write)

---

## 🧭 Verification Architecture

The verification environment consists of the following components:

* **Transaction**

  * Stores APB transaction information.
  * Supports constrained randomization.

* **Generator**

  * Produces randomized APB transactions.
  * Synchronizes with Driver and Scoreboard.

* **Driver**

  * Drives APB interface signals.
  * Implements APB read/write protocol.

* **Monitor**

  * Samples completed APB transactions.
  * Captures DUT responses.

* **Scoreboard**

  * Maintains reference memory.
  * Verifies DUT outputs.
  * Reports mismatches.
  * Samples functional coverage.

* **Coverage**

  * Collects functional coverage using SystemVerilog covergroups.
  * Tracks protocol completeness.

---

## 🧩 DUT Interface

| Signal    | Direction | Description        |
| --------- | --------- | ------------------ |
| `PCLK`    | Input     | APB Clock          |
| `PRESETn` | Input     | Active-Low Reset   |
| `PADDR`   | Input     | Address Bus        |
| `PSEL`    | Input     | Slave Select       |
| `PENABLE` | Input     | Enable Signal      |
| `PWRITE`  | Input     | Read/Write Control |
| `PWDATA`  | Input     | Write Data         |
| `PRDATA`  | Output    | Read Data          |
| `PREADY`  | Output    | Transfer Complete  |
| `PSLVERR` | Output    | Error Indicator    |

---

## ⚙️ Verification Features

* APB Write Transaction Verification
* APB Read Transaction Verification
* Valid Address Access
* Invalid Address Detection
* PSLVERR Verification
* Memory Data Integrity Checking
* Automatic Result Comparison
* Functional Coverage Collection

---

## 🧪 Testbench Overview

The verification environment performs:

* APB Reset Sequence
* Random Read Transactions
* Random Write Transactions
* Valid Address Verification
* Invalid Address Verification
* Error Response Verification
* Functional Coverage Sampling
* Automatic Data Checking
* End-of-Test Statistics

---

## 📊 Functional Coverage

The covergroup measures verification completeness by collecting coverage for:

* Valid Address Space
* Invalid Address Space
* Read Operations
* Write Operations
* Write Data Distribution
* PSLVERR Assertion
* Address × Read/Write Cross Coverage
* Error × Read/Write Cross Coverage

Coverage is sampled after every completed APB transaction.

---

## 🏗️ Verification Architecture Diagram

Below is the architecture of the complete **SystemVerilog Non-UVM APB Verification Environment**, illustrating the Generator, Driver, Monitor, Scoreboard, Coverage, Mailboxes, Event Synchronization, and APB Slave DUT.

> 
![APB TB ARCHITECTURE](https://github.com/Tafseer4169/APB-PROTOCOL/blob/main/apb_tb_architect.png)

## 📈 Sample Simulation Output

```text
[GEN] paddr=10 pwdata=125 pwrite=1

[DRV] Write Transaction Started

[MON] Transaction Captured

[SCO] DATA STORED

---------------------------------------
Functional Coverage = 90%
---------------------------------------

Total Mismatches = 71
```

---

## 🔧 Tools & Technologies

* SystemVerilog
* Verilog HDL
* Class-Based Verification (Non-UVM)
* Functional Coverage (Covergroups)
* Mailboxes
* Events
* Vivado Simulator
* QuestaSim / ModelSim
* GTKWave
* EDA Playground

---

## 📁 Directory Structure

```text
APB-Slave-Verification/
├── rtl/
│   ├── apb_slave.sv
│   └── apb_if.sv
│
├── tb/
│   ├── transaction.sv
│   ├── generator.sv
│   ├── driver.sv
│   ├── monitor.sv
│   ├── scoreboard.sv
│   ├── coverage.sv
│   ├── environment.sv
│   └── tb.sv
│
├── docs/
│   ├── apb_testbench_architecture.png
│   ├── waveform.png
│   └── coverage_report.png
│
├── README.md
└── LICENSE
```

---

## 🎯 Learning Outcomes

This project demonstrates practical implementation of:

* SystemVerilog Object-Oriented Programming
* Class-Based Verification Methodology
* APB Protocol Verification
* Constrained Random Verification
* Mailbox Communication
* Event Synchronization
* Self-Checking Testbench
* Functional Coverage
* Coverage-Driven Verification Concepts

---

## 🚀 Future Improvements

* APB Master Verification Environment
* UVM-Based APB Verification
* Assertion-Based Verification (SVA)
* Protocol Compliance Checker
* Regression Test Suite
* HTML Coverage Reports
* Continuous Integration using GitHub Actions

---

## 📚 License

This project is released under the **MIT License**.

Feel free to use, modify, and extend this verification environment with proper attribution.

---

**Thank you for exploring this APB Slave Verification project!**

Contributions, improvements, bug reports, and feature requests are always welcome. Feel free to fork the repository, raise issues, or submit pull requests.
