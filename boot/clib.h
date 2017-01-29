#ifndef CLIB_H
#define CLIB_H

void halt(void); /* defined in boot.S */

void itoa(char *s, long n);
void itox(char *s, unsigned long n);

int strlen(const char *s);

#endif
