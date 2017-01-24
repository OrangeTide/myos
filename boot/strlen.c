#include <stdint.h>
#include "clib.h"

int
strlen(const char *s)
{
	const char *p = s;
	while (*p) {
		p++;
	}
	return p - s;
}
