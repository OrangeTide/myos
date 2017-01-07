/* 
 * defines a template for exception vectors that can be installed to 0x00000000
 */
.extern _start
.extern vector_swi
.extern vector_irq
.extern vector_fiq

.globl vector_start
vector_start:
	ldr pc, =_reset
	ldr pc, =_undefined_instruction
	ldr pc, =_software_interrupt
	ldr pc, =_prefetch_abort
	ldr pc, =_data_abort
	ldr pc, =_reserved
	ldr pc, =_interrupt
	ldr pc, =_fast_interrupt

/* table of absolute addresses */
.globl vector_table
vector_table:
	_reset: .word _start
	_undefined_instruction: .word 0
	_software_interrupt: .word vector_swi
	_prefetch_abort: .word 0
	_data_abort: .word 0
	_reserved: .word 0
	_interrupt: .word vector_irq
	_fast_interrupt: .word vector_fiq

.globl vector_end
vector_end:

/* utility function to copy the exception vectors to the proper location */
.globl vector_init
vector_init:
	mov r0, #vector_start
	mov r1, #0	/* TODO: offer the option of installing at #ffff0000 */
	/* copy 64 bytes, 32 bytes at a time */
	ldmia r0!, {r2-r9}
	stmia r1!, {r2-r9}
	ldmia r0!, {r2-r9}
	stmia r1!, {r2-r9}
	mov pc, lr

/* dummy handler for FIQ - disables further FIQs, then returns from FIQ [UNTESTED] */
.weak vector_fiq
vector_fiq:
	cpsid f /* disable FIQ */
	subs pc, r14, #4

/* dummy handler for IRQ - disables further IRQs, then returns from IRQ [UNTESTED] */
.weak vector_irq
vector_irq:
	cpsid i /* disable IRQ */
	ldmfd sp!, {r0-r12,pc}^

/* dummy handler for SWI [UNTESTED] */
.weak vector_swi
vector_swi:
	stmfd sp!, {r0-r12,lr}
	/* TODO: handle the SWI */
	ldmfd sp!, {r0-r12,pc}^
