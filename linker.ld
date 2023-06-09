ENTRY(_start) /* Entry point of our Kernel */

SECTIONS
{
    . = 0x7C00; /* Set location counter to 0x7C00 */

    .text :
    {
        *(.boot) /* .boot section (Bootloader) */
        *(.text) /* .text section (Kernel code) */
    }

    .data :
    {
        *(.data) /* .data section */
    }

    .bss :
    {
        *(.bss) /* .bss section */
    }
}
