#include "../drivers/vga.h"
#include "../drivers/port_io.h"
#include "../libs/string.h"

extern "C" void kmain()
{
	/* Initialize terminal interface */
	terminal_initialize();
    terminal_setcolor(VGA_COLOR_CYAN);
    terminal_writestring("Tesing Makefile");
}
