# Author: Michael Wirth, re-engineered by Jovana Kusic
# Student #: 0955683
# Date: April 5th, 2019
# File: spigot.py
# Description: this program reads in a file name from the user and then
# writes to the file the full value calculated for Pi

def calcPi(file):
    j = 0
    nines = 0
    predigit = 0
    N = 1000
    len = (10*N/3)+1
    # Initialize A to (2,2,2,2,2,...,2)
    a = [2] * len

    # Loops n times
    for j in range(0,1000+1):
        q = 0
        for i in range(len, 0, -1):
            x = 10 * a[i-1] + q*i
            a[i-1] = x % (2*i-1)
            q = x / (2*i-1)
        
        a[0] = q % 10
        q = q / 10
        # Counts the number of 9's to display
        if q == 9:
            nines = nines + 1
        elif q == 10:
            file.write(str(predigit+1))
            for k in range(0, nines):
                file.write("0")
            predigit = 0
            nines = 0
        else:
            file.write(str(predigit))
            predigit = q
            # Prints the amount of 9's determined
            if nines != 0:
                for k in range(0, nines):
                    file.write("9")
                nines = 0
    # The final number is displayed
    file.write(str(predigit))
    file.write(str(9))
    
    return;
    

print("*-*-**-*-**-*-**-*-**-*-**-*-**-*-*")
print("---------Spigot Algorithm---------")
print("*-*-**-*-**-*-**-*-**-*-**-*-**-*-*\n")
# Reads in file name from user input
print("Enter name of file to save to: ")
fileName = raw_input()
# Opens/ creates the file to be written to
file = open(fileName, "w")
print("Calculating value of PI..")
calcPi(file)
file.close()
