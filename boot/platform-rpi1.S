#define IO_BASE 0x20200000
.globl io_base
io_base = IO_BASE
.globl uart0_base
uart0_base = (IO_BASE + 0x00001000)
