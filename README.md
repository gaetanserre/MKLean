## MKLean

Automating the creation and update of [Lean 4](https://github.com/leanprover/**lean4**) projects (as described [here](https://leanprover-community.github.io/install/project.html#creating-a-lean-project)).

### Usage

Build:
```bash
make
make install (optional)
```

Run:
```bash
mklean [update | <project directory> [math?]]
```

### How it works
- `mklean directory` creates a new Lean project in the specified directory using the a recent version of Lean 4.
- `mklean directory [math|m]` creates a new Lean project in the specified directory using the most recent version of Lean 4 and mathlib4.
- `mklean update` updates the Lean version and all dependencies of the project.