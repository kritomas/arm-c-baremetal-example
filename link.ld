OUTPUT_ARCH(arm)
MEMORY {
	RAM (rwx) : ORIGIN = 0x40000000, LENGTH = 0x8000000 /*Define RAM (length and origin obtained from dtb)*/
}
ENTRY(_vector)

__stack_top = ORIGIN(RAM) + LENGTH(RAM); /*Set __stack_top to the end of RAM*/

SECTIONS
{
    . = 0x0; /*Force load to address 0x0*/
    .text : { start.o (.vector_table) *(.text) } /*Load section .vector_table at the address specified above, followed immediately by section .text*/
    . = ALIGN(8); /*8 byte alignment*/
}