#define IO_BASE 0x3f200000
.globl io_base
io_base = IO_BASE
.globl uart0_base
uart0_base = (IO_BASE + 0x00001000)
.globl vector_dest
vector_dest = 0x0 /* on other platforms we'd use 0xffff0000 */
