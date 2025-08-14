# Sudoku Solver in Verilog

A hardware implementation of a Sudoku solver using Verilog HDL. This project demonstrates digital logic design principles and algorithmic problem-solving in hardware description language.

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [File Structure](#file-structure)
- [Module Descriptions](#module-descriptions)
- [Getting Started](#getting-started)
- [Simulation](#simulation)
- [Usage](#usage)
- [Algorithm](#algorithm)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)

## Overview

This project implements a complete Sudoku solver using Verilog hardware description language. The solver can take a partially filled 9x9 Sudoku grid and automatically solve it using backtracking algorithm implemented in digital logic.

## Features

- ✅ Complete 9x9 Sudoku grid solving
- ✅ Hardware-based constraint checking
- ✅ Memory-efficient board storage
- ✅ Modular design with separate components
- ✅ Comprehensive testbenches for verification
- ✅ Backtracking algorithm implementation
- ✅ Valid input puzzle verification

## Architecture

The Sudoku solver consists of three main modules working together:

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│                 │    │                  │    │                 │
│ Sudoku          │    │ Board            │    │ Constraint      │
│ Controller      │◄──►│ Memory           │◄──►│ Checker         │
│                 │    │                  │    │                 │
└─────────────────┘    └──────────────────┘    └─────────────────┘
```

## File Structure

```
ardhish2210-sudoku-solver-verilog/
├── README.md
├── Main Code/
│   ├── board_memory.v              # Memory module for storing the Sudoku grid
│   ├── board_memory_tb.v           # Testbench for board memory
│   ├── constraint_checker.v        # Logic for validating Sudoku rules
│   ├── constraint_checker_tb.v     # Testbench for constraint checker
│   ├── sudoku_controller.v         # Main controller implementing solve algorithm
│   └── sudoku_controller_tb.v      # Testbench for sudoku controller
└── System generated code files/
    └── constrain_checker.vcd       # Waveform output from simulation
```

## Module Descriptions

### 1. Board Memory (`board_memory.v`)
- **Purpose**: Stores the 9x9 Sudoku grid in memory
- **Features**: 
  - Read/Write operations for individual cells
  - Address decoding for row and column access
  - Initial puzzle loading capability
- **Interface**: Address input, data I/O, read/write enable signals

### 2. Constraint Checker (`constraint_checker.v`)
- **Purpose**: Validates Sudoku rules and constraints
- **Features**:
  - Row constraint checking
  - Column constraint checking  
  - 3x3 sub-grid constraint checking
  - Validity output for proposed moves
- **Interface**: Grid position, candidate value, validity output

### 3. Sudoku Controller (`sudoku_controller.v`)
- **Purpose**: Main solving logic and coordination
- **Features**:
  - Backtracking algorithm implementation
  - State machine for solve progression
  - Integration with memory and constraint modules
  - Solution completion detection
- **Interface**: Clock, reset, start signal, completion status

## Getting Started

### Prerequisites
- Verilog simulator (ModelSim, Icarus Verilog, or similar)
- Basic understanding of digital logic design
- Text editor or HDL IDE

### Installation
1. Clone this repository:
   ```bash
   git clone https://github.com/ardhish2210/sudoku-solver-verilog.git
   cd sudoku-solver-verilog
   ```

2. Navigate to the Main Code directory:
   ```bash
   cd "Main Code"
   ```

## Simulation

### Running Individual Module Tests

1. **Board Memory Test**:
   ```bash
   iverilog -o board_memory_test board_memory.v board_memory_tb.v
   ./board_memory_test
   ```

2. **Constraint Checker Test**:
   ```bash
   iverilog -o constraint_test constraint_checker.v constraint_checker_tb.v
   ./constraint_test
   ```

3. **Complete System Test**:
   ```bash
   iverilog -o sudoku_test sudoku_controller.v board_memory.v constraint_checker.v sudoku_controller_tb.v
   ./sudoku_test
   ```

### Viewing Waveforms
Use GTKWave or your simulator's waveform viewer to analyze the generated `.vcd` files:
```bash
gtkwave constrain_checker.vcd
```

## Usage

### Input Format
The Sudoku puzzle should be provided as a 9x9 matrix where:
- Numbers 1-9 represent filled cells
- 0 represents empty cells to be solved

### Example Input
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

## Algorithm

The solver implements a **backtracking algorithm**:

1. **Find Empty Cell**: Locate the next empty cell (value = 0)
2. **Try Values**: Attempt values 1-9 in the empty cell
3. **Check Constraints**: Use constraint checker to validate the move
4. **Recursive Solve**: If valid, recursively solve the remaining puzzle
5. **Backtrack**: If no valid solution found, backtrack and try next value
6. **Complete**: Continue until all cells are filled validly

## Testing

Each module includes comprehensive testbenches:

- **Unit Tests**: Individual module functionality
- **Integration Tests**: Module interaction verification  
- **Edge Cases**: Invalid inputs, boundary conditions
- **Performance Tests**: Timing and resource utilization

### Test Coverage
- ✅ Valid puzzle solving
- ✅ Invalid puzzle detection
- ✅ Multiple solution handling
- ✅ Memory read/write operations
- ✅ Constraint validation accuracy

## Design Considerations

- **Memory Efficiency**: Optimized storage for 9x9 grid
- **Modular Architecture**: Separate concerns for maintainability
- **Scalability**: Design allows for easy modification and extension
- **Verification**: Comprehensive testbench suite ensures correctness

## Performance

- **Grid Size**: 9x9 standard Sudoku
- **Algorithm**: Backtracking with constraint propagation
- **Memory Usage**: Minimal storage requirements
- **Solve Time**: Depends on puzzle complexity and clock frequency

## Future Enhancements

- [ ] Multiple solving algorithms (constraint propagation, etc.)
- [ ] Puzzle difficulty analysis
- [ ] Solution uniqueness verification  
- [ ] Optimized search strategies
- [ ] Enhanced debugging capabilities

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

**Ardhish** - [GitHub Profile](https://github.com/ardhish2210)

## Acknowledgments

- Digital Logic Design principles
- Verilog HDL community and resources
- Sudoku puzzle algorithmic research

---

*This project demonstrates the implementation of complex algorithms in hardware description language, showcasing the intersection of software algorithms and digital hardware design.*
