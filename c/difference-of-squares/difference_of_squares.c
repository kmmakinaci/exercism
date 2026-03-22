#include "difference_of_squares.h"


unsigned int sum_of_squares(unsigned int number)
{//n(n+1)(2n+1)/6
    unsigned int a = 0, sum = 0;
    if (number == 0)
        return 0;
    
    for(a = 0; a <= number; a++)
    {
        sum += a*a;
    }

    return sum;
}

unsigned int square_of_sum(unsigned int number)
{
    unsigned int sum = (number*(number+1))>>1;  //n(n+1)/2

    return sum*sum;

}

unsigned int difference_of_squares(unsigned int number)
{
    return square_of_sum(number) - sum_of_squares(number);
}