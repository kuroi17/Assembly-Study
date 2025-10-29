Absolutely bro! Here’s the **full, clean, step-by-step workflow** for your `add.asm` program in **GitHub Codespaces** that adds two numbers and prints the result using `printf`.

---

# **Step 0 — Make sure tools are installed**

In your Codespaces terminal:

```bash
sudo apt update
sudo apt install nasm build-essential -y
```

* `nasm` → assembler
* `build-essential` → GCC, linker

---

# **Step 1 — Create the assembly file**

```bash
nano add.asm
```

Paste this code:

```asm
global main
extern printf

section .data
    fmt db "Result = %d", 10, 0   ; printf format with newline
    num1 dq 5
    num2 dq 7

section .text
main:
    mov rax, [num1]      ; load num1
    add rax, [num2]      ; add num2
    mov rsi, rax          ; 1st argument to printf
    lea rdi, [fmt]        ; format string
    xor rax, rax          ; required by printf
    call printf

    xor rax, rax
    ret
```

* `num1` and `num2` → numbers you want to add
* `fmt` → format string for `printf`
* `rsi` → first argument to printf (%d)
* `rdi` → pointer to format string

Save & exit: **Ctrl+O → Enter → Ctrl+X**

---

# **Step 2 — Assemble the program**

```bash
nasm -f elf64 add.asm -o add.o
```

* `-f elf64` → produces 64-bit Linux object file

---

# **Step 3 — Link with GCC (disable PIE)**

```bash
gcc add.o -no-pie -o add
```

* `-no-pie` → disables position-independent executable linking
* You may see a warning about `.note.GNU-stack` — it’s safe to ignore

---

# **Step 4 — Run the program**

```bash
./add
```

Output:

```
Result = 12
```

* ✅ Works perfectly
* Change `num1` and `num2` in `section .data` to add different numbers

---

# **Step 5 — Optional Notes / Tips**

* Workflow in Codespaces:

```text
Edit add.asm → Assemble → Link → Run
```

* You can make a **shell alias** to automate assemble + link + run:

```bash
echo "alias run_add='nasm -f elf64 add.asm -o add.o && gcc add.o -no-pie -o add && ./add'" >> ~/.bashrc
source ~/.bashrc
```

Then just type:

```bash
run_add
```

* Snippets or templates help reduce repetitive typing

---

This is the **fully working setup** for your assembly add program in Codespaces.

If you want, I can also make a **Hello World + Add Two Numbers template repo** ready to copy-paste so you just focus on editing numbers/messages.

Do you want me to do that?
