#include "grains.h"

static uint64_t pow_of_two(uint64_t n)
{
	uint64_t result = 1;

	if (n == 0)
		return 1;

	uint8_t i = 0;

	for (i = 1; i <= n; i++)
		result = i * 2;

	return result;
}

uint64_t square(uint8_t index)
{
	uint64_t result = 0;
	result = pow_of_two(index-1);
	return result;
}

uint64_t total(void)
{
	uint64_t result = 0;

	uint8_t chess_board_size = 64;
	uint8_t i = 0;

	for (i = 0; i < chess_board_size; i++)
		result += square(i);

	return result;
}
