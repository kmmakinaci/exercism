#include "grains.h"

uint8_t chess_board_size = 64;

uint64_t square(uint8_t index)
{
	if (index > chess_board_size || index == 0)
		return 0;

	return 1ULL << (index - 1);
}

uint64_t total(void)
{
	uint64_t result = 0;
	uint8_t i = 0;

	for (i = 1; i <= chess_board_size; i++)
		result += square(i);

	return result;
}
