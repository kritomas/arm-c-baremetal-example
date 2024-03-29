.section .vector_table, "x"
.global _vector /*Expose _vector to linker script*/
_vector: /*Vector map*/
	b _start
    b . /* 0x4  Undefined Instruction */
    b . /* 0x8  Software Interrupt */
    b . /* 0xC  Prefetch Abort */
    b . /* 0x10 Data Abort */
    b . /* 0x14 Reserved */
    b . /* 0x18 IRQ */
    b . /* 0x1C FIQ */

.section .text
_start:
	ldr sp, =__stack_top /*Set the stack pointer to the top*/
	mov lr, sp /*Set the link register to the stack pointer*/
	bl cstart /*Call cstart() from cstart.c*/
	b . /*Infinite loop that does nothing*/
