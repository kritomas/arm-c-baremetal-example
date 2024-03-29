# ARM C Baremetal Example 

This project demonstrates how to use C on baremetal ARM, emulated via QEMU. This example is very short, for a quick start.

# Overview

+	`cstart.c`: The C code to be executed.
+	`start.s`: Short loader assembly code, which initializes the CPU, and then invokes `cstart()` from `cstart.c`.
+	`link.ld`: Linker script, linking everything together, as well as defining the RAM and the entry point.
+	`Makefile`: The Makefile that compiles and links everything.

Firstly, the CPU needs to be initialized (most notably the stack pointer and link register). This is done using assembly (`start.s`). After that, C can be called.

Lastly, if the C code returns, it is important that execution ends in a loop which does nothing.

`Link.ld` Contains the linker script needed to load `_start` from `start.s` at the correct address (the beginning of RAM space), so that it actually executes. It also contains a pointer to the end of RAM space, which is where the stack pointer is initialized to.

**Note:** RAM Space may differ system to system. You may need to modify its definition in `link.ld` with data obtained from your system's Device Tree. On QEMU, the Device Tree can be obtained by adding `dumpdtb=[Device Tree Blob target file here]` to QEMU's machine arguments:
```
qemu-system-arm -M virt,dumpdtb=virt.dtb -cpu cortex-a15
```
The resulting blob then needs to be converted to a human readable format via Device Tree Compiler:
```
dtc -I dtb -O dts virt.dtb -o virt.dts
```
After that, you can look through `virt.dts` to find the RAM's properties. Example:
```
	memory@40000000 {
		reg = <0x00 0x40000000 0x00 0x8000000>;
		device_type = "memory";
	};
```
This tells us that RAM space begins at address `0x40000000`, and is `0x8000000` bytes long.

Makefile just build everything.

# Usage

Firstly, install everything necessary, most notably `qemu-system-arm` and an ARM cross compiler.

Then, you can compile everything by running `make`, which will produce `arm.bin`.

Lastly, run the example by invoking `qemu-system-arm -M virt -cpu cortex-a15 -bios arm.bin`. If everything is working correctly, the register `r0` should contain 0x489. You can check by running `info registers` in the QEMU monitor console, or by adding `-d cpu` to the QEMU invocation command.