# 🧩 Sudoku Solver in Verilog

> **Hardware meets Sudoku!** A complete digital logic implementation that solves 9x9 Sudoku puzzles using backtracking algorithm in pure Verilog HDL.
## 🚀 What's Inside
- [✨ Features](#-features)
- [🏗️ Architecture](#️-architecture)
- [📁 File Structure](#-file-structure)
- [⚙️ Getting Started](#️-getting-started)
- [🔬 Simulation](#-simulation)
- [🎯 Usage](#-usage)
- [🧠 Algorithm](#-algorithm)

## ✨ Features

- 🎯 Complete 9x9 Sudoku solving
- ⚡ Hardware-based constraint checking  
- 💾 Memory-efficient board storage
- 🧱 Modular design architecture
- 🧪 Comprehensive testbenches
- 🔄 Backtracking algorithm in hardware

## 🏗️ Architecture

Three main modules working in harmony:

```
🎮 Sudoku Controller  ◄──► 💾 Board Memory  ◄──► ✅ Constraint Checker
```

## 📁 File Structure

```
📦 ardhish2210-sudoku-solver-verilog/
├── 📄 README.md
├── 💻 Main Code/
│   ├── 💾 board_memory.v              # Grid storage
│   ├── 🧪 board_memory_tb.v           # Memory testbench
│   ├── ✅ constraint_checker.v        # Rule validation
│   ├── 🧪 constraint_checker_tb.v     # Checker testbench
│   ├── 🎮 sudoku_controller.v         # Main solver logic
│   └── 🧪 sudoku_controller_tb.v      # Controller testbench
└── 📊 System generated code files/
    └── 📈 constrain_checker.vcd       # Simulation waveforms
```

## ⚙️ Getting Started

**Quick Setup:**
1. Clone the repo and dive in!
2. Navigate to `Main Code/` directory
3. Run simulations with your favorite Verilog simulator

## 🔬 Simulation

**Test Individual Modules:**

```bash
# 💾 Board Memory
iverilog -o board_test board_memory.v board_memory_tb.v && ./board_test

# ✅ Constraint Checker  
iverilog -o constraint_test constraint_checker.v constraint_checker_tb.v && ./constraint_test

# 🎮 Full System
iverilog -o sudoku_test *.v && ./sudoku_test
```

**View Waveforms:** `gtkwave constrain_checker.vcd` 📊

## 🎯 Usage

**Input:** 9x9 grid where `0` = empty cell, `1-9` = filled cell

**Example Puzzle:**
```
5 3 0 | 0 7 0 | 0 0 0
6 0 0 | 1 9 5 | 0 0 0  
0 9 8 | 0 0 0 | 0 6 0
------+-------+------
8 0 0 | 0 6 0 | 0 0 3
4 0 0 | 8 0 3 | 0 0 1
7 0 0 | 0 2 0 | 0 0 6
------+-------+------
0 6 0 | 0 0 0 | 2 8 0
0 0 0 | 4 1 9 | 0 0 5
0 0 0 | 0 8 0 | 0 7 9
```

## 🧠 Algorithm

**Smart Backtracking in Hardware:**
1. 🔍 Find empty cell
2. 🎲 Try values 1-9  
3. ✅ Check constraints
4. 🔄 Recurse or backtrack
5. 🎉 Solution found!

## 🎨 What Makes It Special

- **Pure Hardware Logic** - No software, just digital circuits!
- **Modular Design** - Clean, testable, maintainable code
- **Complete Testing** - Every module thoroughly verified
- **Educational Value** - Perfect for learning HDL design

## 🚀 Future Ideas

- 🔥 Advanced solving algorithms
- 📊 Puzzle difficulty analyzer  
- 🎯 Multiple solution detection
- ⚡ Performance optimizations

## 🤝 Contributing

Love hardware design? Jump in!
1. Fork it 🍴
2. Create your feature branch
3. Commit your changes  
4. Push and create a Pull Request

---

**Created by:** [Ardhish](https://github.com/ardhish2210) 💻

*Where algorithms meet silicon! 🔥*
