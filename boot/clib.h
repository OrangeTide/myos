#ifndef CLIB_H
#define CLIB_K

void halt(void); /* defined in boot.S */

void itoa(char *s, long n);

int strlen(const char *s);

#endif
