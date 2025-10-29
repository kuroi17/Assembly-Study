# **Assembly Programming Guide for GitHub Codespaces**

A beginner-friendly guide for learning x86-64 assembly on Linux.

---

## **Prerequisites — One-Time Setup**

Install the assembler (NASM) and linker tools:
Inside terminal(ctrl + j):

```bash
sudo apt update
sudo apt install nasm build-essential -y
```

**What each tool does:**
- `nasm` → The assembler (converts `.asm` to `.o` object files)
- `build-essential` → Includes `ld` (linker) and `gcc`

Verify installation:
```bash
nasm -v
ld -v
```

---

## **Basic Assembly Program Structure**

### **Anatomy of a "Hello World" Program**

```asm
section .data
    msg db "Hello, World!", 0Ah   ; Your custom message here

section .text
    global _start

_start:
    mov rax, 1        ; sys_write (FIXED - syscall number)
    mov rdi, 1        ; stdout (FIXED - file descriptor)
    mov rsi, msg      ; FIXED - pointer to message
    mov rdx, 14       ; CUSTOMIZABLE - message length
    syscall           ; FIXED - invoke system call

    mov rax, 60       ; sys_exit (FIXED - syscall number)
    xor rdi, rdi      ; FIXED - exit code 0
    syscall           ; FIXED - invoke system call
```

---

## **What's FIXED vs. What You Can Change**

### ✅ **FIXED Syntax (Like `#include <iostream>` in C++)**

These are **required** for Linux x86-64 assembly programs:

| Element | Purpose | Why It's Fixed |
|---------|---------|----------------|
| `section .data` | Declares data/variables section | Required section for static data |
| `section .text` | Declares code section | Required section for executable code |
| `global _start` | Makes `_start` visible to linker | Entry point declaration for Linux programs |
| `_start:` | Program entry point | Equivalent to `main()` in C/C++ |
| `syscall` | Invokes a system call | Required to interact with OS |
| `mov rax, 1` | sys_write syscall number | Linux syscall numbers are fixed |
| `mov rax, 60` | sys_exit syscall number | Linux syscall numbers are fixed |
| `mov rdi, 1` | stdout file descriptor | Standard output is always 1 |
| `xor rdi, rdi` | Set exit code to 0 | Standard way to set register to 0 |

### 🎨 **CUSTOMIZABLE Parts (Like Variables in C++)**

| Element | What You Can Change | Example |
|---------|---------------------|---------|
| `msg db "Hello, World!", 0Ah` | The message text | `msg db "Hi!", 0Ah` |
| `msg` (label name) | Variable name | `message`, `str`, `output` |
| `mov rdx, 14` | Message length | Calculate: length of your string |
| `0Ah` | Newline character | `0Ah, 0Dh` (CRLF), or omit for no newline |

---

## **Complete Workflow**

### **Step 1: Create the Assembly File**
inside terminal, write this 
after you write this, there will like a command interace na magpopop-up
```bash
nano hello.asm
```

Or use VS Code: **File → New File → Save as `hello.asm`**

### **Step 2: Write Your Code**

Copy the template below and paste in the command interface

```asm
section .data
    msg db "Hello, World!", 0Ah   ; Your custom message here

section .text
    global _start

_start:
    mov rax, 1        ; sys_write (FIXED - syscall number)
    mov rdi, 1        ; stdout (FIXED - file descriptor)
    mov rsi, msg      ; FIXED - pointer to message
    mov rdx, 14       ; CUSTOMIZABLE - message length
    syscall           ; FIXED - invoke system call

    mov rax, 60       ; sys_exit (FIXED - syscall number)
    xor rdi, rdi      ; FIXED - exit code 0
    syscall           ; FIXED - invoke system call
```
after u type/ paste them, do CTRL + O then ENTER.
then do CTRL X

### **Step 3: Assemble (Convert .asm → .o)**
after exiting the command interface, put this in the same terminal again
```bash
nasm -f elf64 hello.asm -o hello.o
```

**Breakdown:**
- `nasm` → assembler command (FIXED)
- `-f elf64` → output format for Linux 64-bit (FIXED)
- `hello.asm` → your source file (CUSTOMIZABLE filename)
- `-o hello.o` → output object file (CUSTOMIZABLE filename)

### **Step 4: Link (Convert .o → executable)**
put this also
```bash
ld hello.o -o hello
```

**Breakdown:**
- `ld` → linker command (FIXED)
- `hello.o` → input object file (match your .o file)
- `-o hello` → output executable name (CUSTOMIZABLE)

### **Step 5: Run the Program**

```bash
./hello
```

**Expected Output:**
```
Hello, World!
```

---

## **Quick Reference: Commands**

| Task | Command | Required? |
|------|---------|-----------|
| Install tools | `sudo apt install nasm build-essential -y` | Once only |
| Create file | `nano filename.asm` | Every new program |
| Assemble | `nasm -f elf64 file.asm -o file.o` | After every edit |
| Link | `ld file.o -o file` | After every assemble |
| Run | `./file` | To test program |

---

## **Common Linux Syscalls**

| Syscall | RAX Value | Purpose | Arguments |
|---------|-----------|---------|-----------|
| `sys_read` | 0 | Read from file | RDI=fd, RSI=buffer, RDX=count |
| `sys_write` | 1 | Write to file | RDI=fd, RSI=buffer, RDX=count |
| `sys_exit` | 60 | Exit program | RDI=exit_code |

**Example: Exit with code 42**
```asm
mov rax, 60
mov rdi, 42
syscall
```

---

## **One-Command Build Script (Optional)**

Save as `build.sh`:

```bash
#!/bin/bash
nasm -f elf64 $1.asm -o $1.o && ld $1.o -o $1 && ./$1
```

Make executable:
```bash
chmod +x build.sh
```

Usage:
```bash
./build.sh hello
```

---

## **Comparison with C++**

| C++ | Assembly (x86-64) |
|-----|-------------------|
| `#include <iostream>` | `section .data` / `section .text` |
| `using namespace std;` | `global _start` |
| `int main()` | `_start:` |
| `cout << "Hello";` | `mov rax, 1` + `syscall` |
| `return 0;` | `mov rax, 60` + `syscall` |
| Variables: `string msg = "Hi";` | `msg db "Hi", 0Ah` |

---

## **Troubleshooting**

**Error: `No such file or directory`**
→ Run `sudo apt install nasm build-essential -y`

**Error: `undefined reference to _start`**
→ Add `global _start` in your `.asm` file

**Nothing prints**
→ Check message length in `rdx` matches actual string length

---

**Note:** This guide uses the **direct syscall approach**. You can also use `libc` functions with `gcc` linking for a more C-like approach.