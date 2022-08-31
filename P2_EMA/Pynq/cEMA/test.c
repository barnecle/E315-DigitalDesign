
#include <stdio.h>
#include <stdlib.h>

#include "ema.h"

//these values should match those in the IPython Notebook.
const uint32_t x [] = { 2000, 2370, 1537, 2995, 1297, 3308, 1416, 3234, 1892, 2845};
const uint32_t expect_y1 [] = {1250, 1529, 1530, 1895, 1744, 2135, 1954, 2273, 2177, 2343};
const uint32_t expect_y3 [] = {1015, 1054, 1106, 1184, 1263, 1360, 1452, 1555, 1650, 1747};

int main()
{

    uint32_t size = sizeof(x) / sizeof(uint32_t);

    uint32_t * c_y1 = alloca( sizeof(x) );
    uint32_t * c_y2 = alloca( sizeof(x) );
    uint32_t * c_y3 = alloca( sizeof(x) );

    printf("Input X: ["); 
    for (int i = 0; i < size; ++i){
        printf(" %u", x[i]);
    }
    printf(" ]\n");

    printf("\nComputing Simple EMA (Y1)\n");
    // run simple_ema on the x values
    for (int i = 0; i < size; ++i){
        c_y1[i] = ema_simple(x[i]);
    }

    printf("\nSimple EMA (Y1): ["); 
    for (int i = 0; i < size; ++i){
        printf(" %u", c_y1[i]);
    }
    printf(" ]\n");

    printf("\nChecking Simple EMA (Y1): ");
    for (int i = 0; i < size; ++i){
        if (c_y1[i] != expect_y1[i]){
            printf("FAILED!\n\tFound Mismatch at Index: %d\n", i);
            printf("\tExpected: %u\n", expect_y1[i]);
            printf("\tFound: %u\n", c_y1[i]);
            exit(-1);
        }
    }
    printf("PASSED!\n");

    printf("\nCompute Triple EMA (Y3)\n");
    // run simple_ema two more times on the results
    ema_reset();
    for (int i = 0; i < size; ++i){
        c_y2[i] = ema_simple(c_y1[i]);
    }
    // and run it again
    ema_reset();
    for (int i = 0; i < size; ++i){
        c_y3[i] = ema_simple(c_y2[i]);
    }

    printf("\nTriple EMA (Y3): ["); 
    for (int i = 0; i < size; ++i){
        printf(" %u", c_y3[i]);
    }
    printf(" ]\n");

    printf("\nChecking Triple EMA (Y3): ");
    for (int i = 0; i < size; ++i){
        if (c_y3[i] != expect_y3[i]){
            printf("FAILED!\n\tFound Mismatch at Index: %d\n", i);
            printf("\tExpected: %u\n", expect_y3[i]);
            printf("\tFound: %u\n", c_y3[i]);
            exit(1);
        }
    }
    printf("PASSED!\n");

            
    return 0;

}
