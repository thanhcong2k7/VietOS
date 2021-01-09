void printf(char* st)
{
    unsigned int currenti=0;
    static unsigned short* mem = (unsigned short*)0xb8000;
    for (int i=0; st[i]!='\0'; ++i)
    {
        mem[i]=(mem[i]&0xFF00)|st[i];
        ++currenti;
    }
    for (int i=(currenti/80+1)*80; i<2000; ++i) mem[i]=133;
}
extern "C" void kernelMain(const void* multiboot_structure, unsigned int /*multiboot_magic*/)
{
    printf("VietOS - Operating System written from scratch");
    while(1);
}
