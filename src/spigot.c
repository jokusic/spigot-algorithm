/* Author: Michael Wirth, re-engineered by Jovana Kusic
 * Student #: 0955683
 * Date: April 5th, 2019
 * File: spigot.c
 * Description: this program reads in a file name from the user and then
 * writes to the file the full value calculated for Pi
 */
 
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

void spigot();

int main(void) {
    spigot();
    return 0;
}

void spigot() {
    int i, j, k, q, x;
    int len, nines=0, predigit=0;
    int N=1000;
   
    char fileName[256];
    FILE * fp;
   
    len = (10*N/3)+1;
    int a[len];
   
    printf("*-*-**-*-**-*-**-*-**-*-**-*-**-*-*\n");
    printf("---------Spigot Algorithm---------\n");
    printf("*-*-**-*-**-*-**-*-**-*-**-*-**-*-*\n\n");
    // Reads in file name from user input
    printf("Enter name of file to save to: ");
    fgets(fileName, 256, stdin);
    fileName[strlen(fileName)-1] = '\0'; 
    // Opens/ creates the file to be written to
    fp = fopen(fileName, "w");
    printf("Calculating value of PI..\n");
   
    if(fp == NULL) {
        printf("Error creating and opening file");
        exit(0);
    }

    // Initialize A to (2,2,2,2,2,...,2)
    for (i=0; i<len; i=i+1) {
        a[i] = 2;
    }

    // Loops n times
    for (j=1; j<=1000; j=j+1) {
        q = 0;
        for (i=len; i>0; i=i-1) {
            x = 10 * a[i-1] + q*i;
            a[i-1] = x % (2*i-1);
            q = x / (2*i-1);
        }
        a[0] = q % 10;
        q = q / 10;
        // Counts the number of 9's to display
        if (q == 9) {
            nines = nines + 1;
        } else if (q == 10) {
            fprintf(fp, "%d", predigit+1);
            for (k=0; k<nines; k=k+1) {
                fprintf(fp, "%d", 0);
            }
            predigit = 0;
            nines = 0;
        } else {
            fprintf(fp, "%d", predigit);
            predigit = q;
            // Prints the amount of 9's determined
            if (nines != 0) {
                for (k=0; k<nines; k=k+1) {
                    fprintf(fp, "%d", 9);
                }
                nines = 0;
            }
        }
    }
    // The final number is displayed
    fprintf(fp, "%d", predigit);
    fprintf(fp, "%d", 9);
    fclose(fp);
}
