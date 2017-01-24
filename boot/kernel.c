//
// raspi1 peripheral base address : 0x20000000
// raspi2/raspi3 peripheral base address : 0x3F000000
//

#include <stddef.h>
#include <stdint.h>
#include "vector.h"
#include "interrupt.h"
#include "clib.h"

/***
 * error values
 */
#define SUCCESS (0)
#define EPERM (-1)
#define ENOENT (-2)
#define EINTR (-4)
#define EIO (-5)
#define EAGAIN (-11)
#define ENOMEM (-12)
#define EBUSY (-16)
#define EEXIST (-17)
#define ENODEV (-19)
#define EINVAL (-22)
#define ENOSPC (-28)
#define EDOM (-33)
#define ERANGE (-34)

// extern uint32_t rpi_base_io[];
extern uint32_t uart0_base[];

/***
 * mmio32
 */

static inline void
mmio32_write(uintptr_t base, uint32_t reg, uint32_t data)
{
	*(volatile uintptr_t *)(base + reg) = data;
}

static inline uint32_t
mmio32_read(uintptr_t base, uint32_t reg)
{
	return *(volatile uintptr_t *)(base + reg);
}

/***
 * serial/uart driver
 */
#define UARTX_DR     (0x00)
#define UARTX_RSRECR (0x04)
#define UARTX_FR     (0x18)
#define UARTX_ILPR   (0x20)
#define UARTX_IBRD   (0x24)
#define UARTX_FBRD   (0x28)
#define UARTX_LCRH   (0x2C)
#define UARTX_CR     (0x30)
#define UARTX_IFLS   (0x34)
#define UARTX_IMSC   (0x38)
#define UARTX_RIS    (0x3C)
#define UARTX_MIS    (0x40)
#define UARTX_ICR    (0x44)
#define UARTX_DMACR  (0x48)
#define UARTX_ITCR   (0x80)
#define UARTX_ITIP   (0x84)
#define UARTX_ITOP   (0x88)
#define UARTX_TDR    (0x8C)

struct ser_device {
	const char *name;
	uintptr_t base;
};

#define SER_DEVICE_MAX 8 /* maximum number of serial ports */
struct ser_device ser_device[SER_DEVICE_MAX];
unsigned ser_device_cnt;

struct ser_device *
ser_allocate(const char *name, uintptr_t base)
{
	struct ser_device *dev = &ser_device[ser_device_cnt++];
	dev->name = name;
	dev->base = base;
	return dev;
}

struct ser_device *
ser_get_by_index(int idx)
{
	if (idx >= ser_device_cnt)
		return NULL;

	struct ser_device *dev = &ser_device[idx];
	return dev;
}

int
ser_init(const char *name, uintptr_t base)
{
	struct ser_device *dev = ser_allocate(name, base);
	if (!dev)
		return ENOMEM;

	/* disable uart */
	mmio32_write(dev->base, UARTX_CR, 0x0000);

	// TODO: follow the GPIO programming from the manual

	/* select divider and fractional part for ~115200 */
	mmio32_write(dev->base, UARTX_IBRD, 1);
	mmio32_write(dev->base, UARTX_FBRD, 40);

	/* fifo on, 8n1 */
	mmio32_write(dev->base, UARTX_LCRH, 0x0070);

	/* mask all interrupts */
	mmio32_write(dev->base, UARTX_IMSC, 0x07f2);

	/* clear pending interrupts */
	mmio32_write(dev->base, UARTX_ICR, 0x07FF);

	/* enable uart */
	mmio32_write(dev->base, UARTX_CR, 0x0301);

	return SUCCESS;
}


int
ser_waituart(struct ser_device *dev)
{
	while (mmio32_read(dev->base, UARTX_FR) & (1u << 5));
	return SUCCESS;
}

int
ser_putchar(struct ser_device *dev, char c)
{
	if (ser_waituart(dev) != SUCCESS)
		return EIO;
	mmio32_write(dev->base, UARTX_DR, c);
	return SUCCESS;
}

int
ser_write(struct ser_device *dev, size_t n, void *p)
{
	char *s = p;
	while (n) {
		if (ser_putchar(dev, *s) != SUCCESS)
			return EIO;
		s++;
		n--;
	}
	return SUCCESS;
}

void vector_swi(void) __attribute__((interrupt("SWI")));
void
vector_swi(void)
{
#if 0 // TODO: does not work
	uint32_t swi_instr;
	asm volatile ("ldr %0, [lr, #-4]" : "=r" (swi_instr) ); /* read SWI opcode that triggered this exception */

	switch (swi_instr & 0xffffff) { /* mask off so we have only the immediate part of the SWI operation */
	case 0: // TODO: handle swi #0
		break;
	case 1: // TODO: handle swi #1
		break;
	case 6: { /* user debug */
		struct ser_device *dev = ser_get_by_index(0);
		ser_putchar(dev, 'U');
		break;
		}
	// TODO: ...
	}
#endif
	// This?? asm volatile ("movs pc, lr");
	// Or this?? asm volatile ("subs pc, r14, #4");
}

void
vector_irq(void)
{
	// TODO: implement this
}

void
vector_fiq(void)
{
	// TODO: implement this
}

/* a user debug SVC */
static inline void
call_swi6(void)
{
	asm volatile("svc %0" : : "i"(6) : "r14");
}

void
system_main(uint32_t a, uint32_t b, uint32_t c)
{
	uint32_t mach_type = c;
	disable_fiq();
	vector_init();

	ser_init("uart0", (uintptr_t)&uart0_base);

	char buf[32];

	itoa(buf, mach_type);
	ser_write(&ser_device[0], 10, "mach_type=");
	ser_write(&ser_device[0], strlen(buf), buf);
	ser_write(&ser_device[0], 2, "\r\n");

	ser_write(&ser_device[0], 14, "Hello Potato\r\n");

	ser_write(&ser_device[0], 9, "Welcome\r\n");

	// TODO: doesn't work:
	// call_swi6();
}
