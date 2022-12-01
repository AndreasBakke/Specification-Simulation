LIBRARY ieeE;
use ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY nand_n IS
    GENERIC(N: integer := 2);
    PORT(
    A, B : IN std_logic_vector(N-1 DOWNTO 0);
    Y: OUT std_logic);
END nand_n;



Architecture Behav of nand_n IS
BEGIN
    PROCESS(A, B)
    BEGIN
        IF A = B THEN
           Y <= '0';
        ELSE 
            Y <= '1';
        END IF;
    END PROCESS;
END Behav;