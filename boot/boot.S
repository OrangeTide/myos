// boot must be at start of the binary.
// linker script treats this section special.
.section ".text.boot"

// kernel entry point
// pc is typically 0x8000.
// r0 -> booted device (generally 0x00000000)
// r1 -> ARM machine type - bcm2708=3138 (0x00000C42)
// r2 -> start of ATAGS
// preserves these registers so they may be passed to system_main()
.comm stack_start, 0x4000	/* reserve 16K of stack in BSS */

.globl _start
_start:
	/// setup stack for the different processor modes ///
	ldr r4, =stack_start
	cps #0x13 /* SVC mode */
	add sp, r4, #0x1000
	cps #0x17 /* ABORT mode */
	add sp, r4, #0x2000
	cps #0x12 /* IRQ mode */
	add sp, r4, #0x3000
	cps #0x1f /* system mode */
	add sp, r4, #0x4000
 
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
.globl halt
halt:
	wfe
	b halt
