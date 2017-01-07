#ifndef INTERRUPT_H
#define INTERRUPT_H

static inline void
disable_irq(void)
{
	asm volatile("cpsid i");
}

static inline void
enable_irq(void)
{
	asm volatile("cpsie i");
}

static inline void
disable_fiq(void)
{
	asm volatile("cpsid f");
}

static inline void
enable_fiq(void)
{
	asm volatile("cpsie f");
}

#endif
