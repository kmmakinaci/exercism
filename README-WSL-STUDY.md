# Grains C in Ubuntu WSL: Test + Debug Study Guide

This guide is a practical workflow for solving Exercism C exercises from Ubuntu on WSL.

## 0) Recommended setup choice

For this workspace, prefer a small WSL bridge over Docker.

Why:
- your `gcc`, `make`, `gdb`, and test runs already belong in Ubuntu WSL
- your Exercism CLI lives on Windows
- your git SSH key also lives on Windows
- Docker would add another filesystem and permission layer without solving those Windows integration points cleanly

This repo includes helper scripts for that bridge:
- [`scripts/exercism_cli.sh`](/mnt/c/Users/Mert/repos/exercism/scripts/exercism_cli.sh): runs the Windows or WSL Exercism CLI from Ubuntu
- [`scripts/download_exercism_c.sh`](/mnt/c/Users/Mert/repos/exercism/scripts/download_exercism_c.sh): downloads a C exercise and normalizes it to the shared test framework
- [`scripts/wsl_shell_env.sh`](/mnt/c/Users/Mert/repos/exercism/scripts/wsl_shell_env.sh): exports `EXERCISM_BIN` and `GIT_SSH_COMMAND` for your shell

Optional local config lives in `.wsl-local.env` and is ignored by git. A template is in [`.wsl-local.env.example`](/mnt/c/Users/Mert/repos/exercism/.wsl-local.env.example).

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

Then load the repo bridge in your WSL shell:

```bash
source /mnt/c/Users/Mert/repos/exercism/scripts/wsl_shell_env.sh
```

If you want that every time, add the same line to `~/.bashrc`.

Recommended first step:

```bash
cp /mnt/c/Users/Mert/repos/exercism/.wsl-local.env.example /mnt/c/Users/Mert/repos/exercism/.wsl-local.env
```

Example `.wsl-local.env` values:

```bash
EXERCISM_BIN='C:\Users\Mert\Downloads\exercism-3.5.8-windows-64bit\exercism.exe'
WINDOWS_SSH_BIN='C:\Windows\System32\OpenSSH\ssh.exe'
WINDOWS_SSH_KEY='C:\Users\Mert\.ssh\id_ed25519'
```

Notes:
- if `EXERCISM_BIN` is not set, the scripts try `exercism` from `PATH` first
- if that is missing, they try to auto-discover `exercism.exe` under your Windows `Downloads` folder
- explicit `EXERCISM_BIN` is still the most reliable setup

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

Download and normalize a new C exercise:

```bash
cd /mnt/c/Users/Mert/repos/exercism
./scripts/download_exercism_c.sh queen-attack
```

This wrapper:
- runs the Exercism CLI from WSL
- normalizes the exercise to the shared [`c/test-framework`](/mnt/c/Users/Mert/repos/exercism/c/test-framework)
- continues even if the CLI exits non-zero but the exercise folder was still created

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
../../scripts/exercism_cli.sh submit grains.c grains.h
```

## 9) Optional VS Code integration (WSL)

Install extensions:
- `C/C++` (Microsoft)
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
