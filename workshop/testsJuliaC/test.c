// test.c

#include <stdio.h>
#include <stdlib.h>

int main()
{
    int A[100][100][100];
    int i,j,k,loop;
    for (loop=0; loop <1000; loop++)
    {
        for (i=0; i<100; i++)
        {
            for (j=0; j<100; j++)
            {
                for (k=0; k<100; k++)
                {
                    A[i][j][k] = loop;
                }
            }
        }
        printf("%d\n", A[99][99][99]);
    }
    return 0;
}
// z = zeros(5,1)

// time ./test2025

