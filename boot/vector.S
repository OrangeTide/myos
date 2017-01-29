/* 
 * defines a template for exception vectors that can be installed to 0x00000000
 */
.extern _start
.extern vector_swi
.extern vector_irq
.extern vector_fiq
.extern vector_abort
.extern vector_prefetch
.extern vector_undefined
.extern uart0_base

.text

.globl vector_start
vector_start:
	ldr pc, _reset
	ldr pc, _undefined_instruction
	ldr pc, _software_interrupt
	ldr pc, _prefetch_abort
	ldr pc, _data_abort
	ldr pc, _reserved
	ldr pc, _interrupt
	ldr pc, _fast_interrupt

/* table of absolute addresses */
.globl vector_table
vector_table:
	// _reset: .word _start
	_reset: .word _start
	_undefined_instruction: .word vector_undefined
	_software_interrupt: .word vector_swi
	_prefetch_abort: .word vector_prefetch
	_data_abort: .word vector_abort
	_reserved: .word 0xdeadbeef
	_interrupt: .word vector_irq
	_fast_interrupt: .word vector_fiq

.globl vector_end
vector_end:

.weak vector_undefined
vector_undefined:
	b vector_undefined	/* infinite loop, debugger can rub this out. */
	movs pc, r14

/* dummy handler for abort */
.weak vector_prefetch
vector_prefetch:
	b vector_prefetch	/* infinite loop, debugger can rub this out. */
	subs pc, r14, #4

/* dummy handler for abort */
.weak vector_abort
vector_abort:
	b vector_abort 		/* infinite loop, debugger can rub this out. */
	subs pc, r14, #8

/* dummy handler for FIQ - disables further FIQs, then returns from FIQ [UNTESTED] */
.weak vector_fiq
vector_fiq:
	cpsid f /* disable FIQ */
	subs pc, r14, #4

/* dummy handler for IRQ - disables further IRQs, then returns from IRQ [UNTESTED] */
.weak vector_irq
vector_irq:
	cpsid i /* disable IRQ */
	subs pc, r14, #4

/* dummy handler for SWI [UNTESTED] */
.weak vector_swi
vector_swi:
	// some debug print
	ldr r0, =uart0_base
	mov r1, #'@'
	str r1, [r0, #0]
	movs pc, r14
