#include "leap.h"

bool leap_year(int year)
{
    int value = 0;

    if(0 == year%100)
    {
        value = year%400;
    } else
    {
        value = year%4;
    }
    return !value;
}