-- Author: Michael Wirth, re-engineered by Jovana Kusic
-- Student #: 0955683
-- Date: April 5th, 2019
-- File: spigot.adb
-- Description: this program reads in a file name from the user and then
-- writes to the file the full value calculated for Pi

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure spigot is
    fileName : string(1..256);
    i : integer;
    outputFile : File_Type;

    procedure calcPi(outputFile: in out File_Type) is
        nines : integer := 0;
        predigit : integer := 0;
        q, x : integer;
        N : constant integer := 1000;
        len : constant integer := (10*N/3)+1;
        a : array(0..len+1) of integer;
    
        begin
        set_output(outputFile);
        
        for i in 0..len loop
            a(i) := 2;
        end loop;
        
        -- Loops n times
        for j in 0..1000 loop
            q := 0;
            for i in reverse 1..len loop
                x := 10 * a(i-1) + q*i;
                a(i-1) := x mod (2*i-1);
                q := x / (2*i-1);
            end loop;
            a(0) := q mod 10;
            q := q / 10;
            -- Counts the number of 9's to display
            if q = 9 then
                nines := nines + 1;
            elsif q = 10 then
                put(predigit+1, width => 0);
                put(outputFile, "");
                for k in 0..nines-1 loop
                    put(0, width => 0);
                end loop;
                predigit := 0;
                nines := 0;
            else
                put(predigit, width => 0);
                predigit := q;
                -- Prints the amount of 9's determined
                if nines /= 0 then
                    for k in 1..nines loop
                        put(9, width => 0);
                    end loop;
                    nines := 0;
                end if;
            end if;
        end loop;
        -- The final number is displayed
        put(predigit, width => 0);
        put(9, width => 0);
        
        set_output(standard_output);
  
    end calcPi;
    
    begin
    
    put_line("*-*-**-*-**-*-**-*-**-*-**-*-**-*-*");
    put_line("---------Spigot Algorithm---------");
    put_line("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*");
    new_line;
    -- Reads in file name from user input
    put_line("Enter name of file to save to: ");
    get_line(fileName, i);
    -- Opens/ creates the file to be written to
    Create (File => outputFile, Mode => Out_File, Name => fileName);
    put_line("Calculating value of PI..");
    calcPi(outputFile);
    Close(outputFile);


end spigot;
