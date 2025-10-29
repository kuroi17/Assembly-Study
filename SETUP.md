Ah, yes bro — I get exactly what you’re asking. Let’s break this down **step by step**, with the **syntax/commands** you need for each step, and clarify what is “fixed” and what you can change. I’ll make it super clear so it’s like a cheat sheet for assembly in GitHub Codespaces.

---

# **Step-by-Step Assembly Workflow in GitHub Codespaces**

---

## **Step 0 — Install essential tools (one-time setup)**

Before writing any assembly program, you need NASM and GCC (linker included). In Codespaces terminal:

```bash
sudo apt update
sudo apt install nasm build-essential -y
```

* ✅ This is **fixed** once — no need to reinstall.
* `nasm` → assembler, `build-essential` → GCC and `ld` linker.

Check versions (optional):

```bash
nasm -v
gcc -v
```

---

## **Step 1 — Create the assembly file**

Use `nano` or VSCode editor:

```bash
nano hello.asm
```

* You can also do **VSCode: File → New File → hello.asm**.

---

## **Step 2 — Write your assembly code**

Paste this code in `hello.asm`:

```asm
section .data
    msg db "Hello, World!", 0Ah   ; message with newline

section .text
    global _start

_start:
    mov rax, 1        ; sys_write
    mov rdi, 1        ; stdout
    mov rsi, msg
    mov rdx, 14       ; length of message
    syscall

    mov rax, 60       ; sys_exit
    xor rdi, rdi
    syscall
```

### Notes:

* `section .data` → defines static data like strings.
* `msg db "Hello, World!", 0Ah` → your message + newline.
* `section .text` → code section.
* `_start` → entry point for Linux syscall programs.
* `mov rax, 1 / syscall` → Linux syscalls (`1 = write`, `60 = exit`).

✅ This part is **fixed for Linux syscall “Hello World”**, except you can change the message or add more syscalls if you want.

---

## **Step 3 — Save and exit Nano**

* Save: `Ctrl + O` → press Enter
* Exit: `Ctrl + X`

Your file `hello.asm` now exists in the folder.

---

## **Step 4 — Assemble the code**

In the terminal:

```bash
nasm -f elf64 hello.asm -o hello.o
```

* `-f elf64` → output format for Linux 64-bit
* `hello.o` → object file created
* ✅ You need to run this **every time you modify the `.asm` file**

---

## **Step 5 — Link the object file**

```bash
ld hello.o -o hello
```

* `ld` → linker
* `hello` → final executable file
* ✅ Run this every time you re-assemble

---

## **Step 6 — Run your program**

```bash
./hello
```

You should see:

```
Hello, World!
```

---

### ✅ **Summary Cheat Sheet Syntax**

| Step          | Command / Syntax                           |
| ------------- | ------------------------------------------ |
| Install tools | `sudo apt install nasm build-essential -y` |
| Create file   | `nano hello.asm`                           |
| Assemble      | `nasm -f elf64 hello.asm -o hello.o`       |
| Link          | `ld hello.o -o hello`                      |
| Run           | `./hello`                                  |

---

### **Extra Notes**

1. **Message and code**: You can change `msg db "Hello, World!", 0Ah` to print anything else.
2. **Program logic**: `_start` and syscalls are fixed for Linux programs — for more complex programs you’ll add more instructions.
3. **Workflow**:

   * Edit `.asm` → Assemble → Link → Run

---

If you want, I can also make a **ready-to-copy one-command workflow** for Codespaces so you just press **one command** to assemble, link, and run every time.

Do you want me to do that?
