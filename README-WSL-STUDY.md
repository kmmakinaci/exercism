# Grains C in Ubuntu WSL: Test + Debug Study Guide

This guide is a practical workflow for solving Exercism C exercises from Ubuntu on WSL.

## 1) One-time setup (Ubuntu WSL)

```bash
sudo apt update
sudo apt install -y build-essential gdb valgrind clang-format
```
Verify tools:

```bash
gcc --version
make --version
gdb --version
valgrind --version
```

## 2) Open this exercise

```bash
cd /mnt/c/Users/UserName/repos/exercism/c/grains
ls
```

Key files:
- `grains.c`: your implementation
- `grains.h`: declarations
- `test_grains.c`: tests (initially many are ignored)
- `makefile`: build and test commands

## 3) Fast TDD loop

Run tests:

```bash
make test
```

The generated binary is `tests.out`.

Clean build outputs:

```bash
make clean
```

## 4) Why tests show IGNORE

In Exercism C exercises, many tests start with `TEST_IGNORE();` in `test_grains.c`.
Delete one `TEST_IGNORE();` at a time to unlock the next test.

Typical flow:
1. Remove one `TEST_IGNORE();`
2. Run `make test`
3. Fix code
4. Repeat

## 5) Debug with gdb

Build with symbols and start debugger:

```bash
make clean
make tests.out
gdb ./tests.out
```

Useful `gdb` commands:

```gdb
break square
run
next
step
print index
backtrace
continue
quit
```

Tip: if a breakpoint does not trigger, confirm the test calling that function is not still ignored.

## 6) Memory/debug safety checks

Your `makefile` includes AddressSanitizer build:

```bash
make memcheck
```

You can also run valgrind manually on the normal test binary:

```bash
make tests.out
valgrind --leak-check=full --show-leak-kinds=all ./tests.out
```

Notes:
- `memcheck` target uses compiler sanitizers (`-fsanitize=address`)
- valgrind is a separate runtime checker; both are useful while learning

## 7) Suggested day-to-day workflow

```bash
cd /mnt/c/Users/Mert/repos/exercism/c/grains
make test
# edit grains.c / grains.h
make test
make memcheck
gdb ./tests.out   # when stuck
```

## 8) Submit to Exercism

From this folder:

```bash
exercism submit grains.c grains.h
```

## 9) Optional VS Code integration (WSL)

Install extensions:
- `C/C++` (Microsoft)
- `CodeLLDB` (optional alternative debugger)
- `WSL`

Open folder through WSL and debug `tests.out` using `gdb`.

## 10) Common issues

- `gdb: command not found`
  - Install with `sudo apt install gdb`
- Tests are all skipped
  - Remove `TEST_IGNORE();` lines in `test_grains.c`
- Unexpected test failures
  - Run `make clean && make test` to avoid stale binaries

---

If you want, this can be reused as a template for every C exercise in your Exercism workspace.
