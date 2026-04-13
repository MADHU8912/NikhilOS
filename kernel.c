void kernel_main() {
    char *video = (char*) 0xb8000;
    char msg[] = "Kernel Loaded Successfully";
    int i = 0;

    while (msg[i] != '\0') {
        video[i * 2] = msg[i];
        video[i * 2 + 1] = 0x07;
        i++;
    }

    while (1) { }
}