#ifndef VECTOR_H
#define VECTOR_H

extern void (*vector_table[8])(void);

void vector_swi(void) __attribute__((interrupt("SWI")));
void vector_irq(void) __attribute__((interrupt("IRQ")));
void vector_fiq(void) __attribute__((interrupt("FIQ")));

extern void vector_init(void);
#endif
