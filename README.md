# MROS

A small boot / OS learning project written in Assembly. The goal is to evolve this repository from a basic bootloader into a small hobby OS while keeping it accessible to beginners and friendly for contributors.

Description
- This repo contains Assembly code and resources for a bootloader and early OS experiments.
- Primary goals: teach low-level boot and runtime concepts, provide a simple foundation for contributors to extend, and produce a minimal, working boot environment.

Key features
- Assembly-only source code
- Bootloader and minimal kernel stub
- Easy-to-follow build steps for learners
- Intended to run in Bochs (or other x86 emulators) for safe development and testing

Prerequisites
- nasm (Netwide Assembler) — for assembling .asm files
- bochs (recommended) or another x86 emulator (e.g., QEMU) for running the build
- make (optional) for convenience

Quick start (assemble and run)
1. Assemble the boot sector
   - nasm -f bin -o boot.bin src/boot.asm
2. Create a disk image (1.44M floppy example)
   - dd if=/dev/zero of=mros.img bs=512 count=2880
   - dd if=boot.bin of=mros.img conv=notrunc
3. Run in Bochs
   - bochs -f bochsrc.txt
   (or use: bochs -q -f bochsrc.txt for quiet mode)
4. Alternative: Run in QEMU
   - qemu-system-i386 -fda mros.img

Notes
- Adjust paths where your source files live (the sample assumes src/boot.asm).
- The exact assemble and link commands depend on the project layout; see the project file tree below.

Build / development tips for beginners
- Work iteratively: change small pieces of code and test in the emulator frequently.
- Keep a copy of a working disk image to avoid repeating setup steps.
- Use the Bochs debugger or QEMU -S -gdbtcp options to step through code and inspect registers.
- Comment your assembly thoroughly — it helps new contributors understand intent and flow.

Contributing
- Everyone is welcome. Suggested process:
  1. Fork the repo and create a branch for your feature or fix.
  2. Add code, tests (if applicable), and documentation.
  3. Open a Pull Request describing what you changed and why.
- Coding style:
  - Use clear labels and section comments in assembly files.
  - Keep boot sector size under 512 bytes (for floppy/MBR boot sectors).
- Issues: open issues for bugs, feature requests, or design discussions.

Roadmap (short)
- Improve bootloader robustness and comments for educational clarity
- Add a small kernel stub with basic text output and simple driver examples
- Add tutorials in docs/ showing step-by-step how the boot process works
- Add tests and CI (emulator-based) if possible

License
- This project is released under GPL-3.0. See LICENSE for details.

References and learning resources
- OSDev Wiki — https://wiki.osdev.org
- NASM documentation — https://www.nasm.us
- Bochs — https://bochs.sourceforge.io
- “Operating Systems: From 0 to 1” style tutorials and other assembly/bootloader guides

- Expand any section (detailed build script, example code walkthrough, contributor checklist, CI config).

Which action would you like next?
