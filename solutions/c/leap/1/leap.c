#include "leap.h"
#include "stdio.h"


bool leap_year(int year)
{
    int value = 0;

    if(0 == year%100)
    {
        value = year%400;
        printf("value for 100s %d\n", value);
    } else
    {
        value = year%4;
        printf("value %d\n", value);
    }
    return !value;
}