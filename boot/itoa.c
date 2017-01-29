#include "clib.h"

/* output an integer as a decimal string */
void
itoa(char *s, long n)
{
	if (n < 0) {
		*s++ = '-';
		n = -n;
	}
	char *p = s;
	int m = n;
	do {
		m /= 10;
		p++;
	} while (m);
	*p = 0;

	do {
		char x = (n % 10) + '0';
		n /= 10;
		*(--p) = x;
	} while (n);
}

/* output an unsigned integer as a hexadecimal string */
void
itox(char *s, unsigned long n)
{
	char *p = s;
	int m = n;
	do {
		m >>= 4;
		p++;
	} while (m);
	*p = 0;

	do {
		unsigned char x = n & 15;

		if (x < 10)
			x = x + '0';
		else
			x = x - 10 + 'A';
		n >>= 4;
		*(--p) = x;
	} while (n);
}
#if 0 // TEST CODE

#include <stdlib.h>
#include <stdio.h>

int main(int argc, char **argv)
{
	char buf[16];
	itoa(buf, atoi(argv[1]));
	puts(buf);
	return 0;
}
#endif
