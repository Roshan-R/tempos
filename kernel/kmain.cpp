#include "../drivers/vga.h"
#include "../drivers/port_io.h"
#include "../libs/string.h"

extern "C" void kmain()
{
	/* Initialize terminal interface */
	terminal_initialize();
    terminal_fill(VGA_COLOR_BLUE);
    terminal_setcolor(VGA_COLOR_BLUE, VGA_COLOR_LIGHT_MAGENTA);
    terminal_center_text("Welcome to the awesome world of VGA Graphics!");
}

