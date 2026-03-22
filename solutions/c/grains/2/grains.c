#include "grains.h"

uint64_t square(uint8_t index)
{
	uint64_t result = 1;

	if (index == 1 || index == 0)
		return index;

	uint8_t i = 1;
	for (i = 1; i < index; i++)
		result *= 2;

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
