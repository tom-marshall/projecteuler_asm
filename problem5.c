#include <stdio.h>
#include <stdlib.h>


#define RANGETO 20

int factor[RANGETO + 1] = { 0 };


int main()
{
    //unsigned long long start = 232792560;
    //unsigned long long start = 116396250;
    unsigned long long start = RANGETO + 1;

    for (unsigned long long num = start; ; ++num) {
        factor[2]  = !(num & 1);

        factor[3]  = num %  3 == 0;
        factor[4]  = num %  4 == 0;
        factor[5]  = num %  5 == 0;
        factor[7]  = num %  7 == 0;
        factor[8]  = num %  8 == 0;
        factor[9]  = num %  9 == 0;
        factor[11] = num % 11 == 0;
        factor[12] = num % 12 == 0;
        factor[13] = num % 13 == 0;
        factor[16] = num % 16 == 0;
        factor[17] = num % 17 == 0;
        factor[19] = num % 19 == 0;
        factor[20] = num % 20 == 0;

        //based on previous
        factor[6]  = factor[2] & factor[3];
        factor[10] = factor[2] & factor[5];
        factor[14] = factor[2] & factor[7];
        factor[15] = factor[3] & factor[5];
        factor[18] = factor[2] & factor[9];

        int factor_count = 0;

        for (int i = 2; i <= RANGETO; ++i)
            factor_count += factor[i];
        
        if (factor_count == RANGETO - 1) {
            printf("Yay! %llu is the number!\n", num);
            exit (EXIT_SUCCESS);
        }
    }
}

