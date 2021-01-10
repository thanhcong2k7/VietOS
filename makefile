GCCPARAMS = -m32 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore
ASPARAMS = --32
LDPARAMS = -melf_i386

objects = loader.o kernel.o



%.o: %.cpp
	gcc $(GCCPARAMS) -c -o $@ $<

%.o: %.s
	as $(ASPARAMS) -o $@ $<

vietos.bin: linker.ld $(objects)
	ld $(LDPARAMS) -T $< -o $@ $(objects)
	rm -rf loader.o
	rm -rf kernel.o

vietos.iso: vietos.bin
	cp $< iso/boot
	grub-mkrescue --output=$@ iso
run: vietos.iso
	qemu-system-x86_64 vietos.iso
