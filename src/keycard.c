#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void gadget() {
    printf("\n[!] ACCESS GRANTED. Printing flag...\n");
    system("/bin/cat flag.txt");
}

void authorize() {
    volatile int key = 0x12345678;
    char name[32];

    printf("Enter name: ");
    // The classic vulnerability: no length check!
    scanf("%s",name); 

    if(key == 0xdeadbeef) {
        gadget();
    } else {
        printf("\nAccess Denied! Invalid Keycard.\n", key);
    }
}

int main() {
    printf("--- Secure Door System  ---\n");
    authorize();
    return 0;
}
