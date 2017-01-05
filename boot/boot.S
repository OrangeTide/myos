// boot must be at start of the binary. linker script treats this section special.
.section ".text.boot"
 
// kernel entry point
// pc is typically 0x8000.
// r0 -> booted device (generally 0x00000000)
// r1 -> ARM machine type - bcm2708=3138 (0x00000C42)
// r2 -> start of ATAGS
// preserves these registers so they may be passed to system_main()
.globl _start
_start:
	// Setup the stack.
	mov sp, #0x8000
 
	// Clear out bss.
	ldr r4, =__bss_start
	ldr r9, =__bss_end
	mov r5, #0
	mov r6, #0
	mov r7, #0
	mov r8, #0
	b       2f
 
1:
	// store multiple at r4.
	stmia r4!, {r5-r8}
 
	// If we are still below bss_end, loop.
2:
	cmp r4, r9
	blo 1b
 
	// Call system_main either in ARM or Thumb mode
	ldr r3, =system_main
	blx r3
 
	// halt loop if system_main() ever returns
halt:
	wfe
	b halt
