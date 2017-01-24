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
