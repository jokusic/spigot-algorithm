! Author: Michael Wirth, re-engineered by Jovana Kusic
! Student #: 0955683
! Date: April 5th, 2019
! File: spigot.f95
! Description: this program reads in a file name from the user and then
! writes to the file the full value calculated for Pi

program main 
    ! Ensures no implicit variables can be used
    implicit none
    call calcPi() 
end program

subroutine calcPi () 
    integer :: i = 0, j = 0, k = 0, q = 0, x = 0
    integer :: len, nines=0, predigit=0
    integer :: N=1000
   
    character(len = 256) :: fileName
   
    integer :: a(0:3333) 
    len = (10*N/3)+1
   
    print*,'*-*-**-*-**-*-**-*-**-*-**-*-**-*-*'
    print*,'---------Spigot Algorithm---------'
    print*,'*-*-**-*-**-*-**-*-**-*-**-*-**-*-*'
    ! Reads in file name from user input
    print*,'Enter name of file to save to:  ' 
    read (*,*) fileName
    ! Opens/ creates the file to be written to
    open(1, file = fileName, status = 'unknown')
    print*,'Calculating value of PI..' 

    ! Initialize A to (2,2,2,2,2,...,2)
    do i = 0, len, 1
        a(i) = 2
    end do
    
    ! Loops n times
    do j = 0, N, 1
        q = 0
        do i = len, 1, -1
            x = 10 * a(i-1) + q*i
            a(i-1) = mod(x, (2*i-1))
            q = x / (2*i-1)
        end do
        a(0) = mod(q, 10)
        q = q / 10
        ! Counts the number of 9's to display
        if(q == 9) then
            nines = nines + 1
        else if(q == 10) then
            write(1,'(i0)', advance = 'no') predigit+1
            do k = 0, nines-1, 1
                write(1,'(i0)', advance = 'no') 0
            end do
            predigit = 0
            nines = 0
        else
            write(1,'(i0)', advance = 'no') predigit
            predigit = q
            ! Prints the amount of 9's determined
            if(nines /= 0) then
                do k = 0, nines-1, 1
                    write(1,'(i0)', advance = 'no') 9
                end do
                nines = 0
            end if
        end if
    end do
    ! The final number is displayed
    write(1,'(i0)', advance = 'no') predigit
    write(1,'(i0)') 9
    
    close(1)
end
