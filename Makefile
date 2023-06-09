CC					= gcc
NASM	 			= nasm

C_FLAGS 			= -nostdlib -m32

KERNEL_BIN	 		= kernel.bin
KERNEL_IMG 			= kernel.img
LINKER_SCRIPT       = linker.ld

C_SOURCES 			= $(wildcard %.c)
C_OBJECTS			= $(patsubst %.c,%.o,$(C_SOURCES))
BOOT_ASM 			= boot.s
BOOT_OBJECT 		= boot.o

all: $(KERNEL_IMG)

debug: $(KERNEL_IMG)
	qemu-system-x86_64 -hda $< -monitor stdio


$(KERNEL_IMG): $(KERNEL_BIN)
	dd if=/dev/zero of=$@ bs=1024 count=1440
	dd if=$< of=$@ conv=notrunc

$(KERNEL_BIN): $(BOOT_OBJECT) $(C_OBJECTS)
	$(CC) $(C_FLAGS) -o $@ -T $(LINKER_SCRIPT) $^

$(BOOT_OBJECT): $(BOOT_ASM)
	$(NASM) -f elf32 $< -o $@

$(C_OBJECTS): $(C_SOURCES)
	$(CC) $(C_FLAGS) -c $< -o $@
