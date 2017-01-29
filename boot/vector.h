#ifndef VECTOR_H
#define VECTOR_H

extern void (*vector_table[8])(void);

/* NOTE: On ARMv7-M the interrupt type is ignored, and the attribute means the function may be called with a word-aligned stack pointer. */
void vector_swi(int r0, int r1, int r2, int r3) __attribute__((interrupt("SWI")));
void vector_irq(void) __attribute__((interrupt("IRQ")));
void vector_fiq(void) __attribute__((interrupt("FIQ")));

extern void vector_init(void);
#endif
