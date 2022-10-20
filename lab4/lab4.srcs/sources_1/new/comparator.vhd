-- N BIT comparator

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;



ENTITY comparator IS
    GENERIC(N: integer:= 4);
    PORT(x, y: IN std_logic_vector(N-1 DOWNTO 0);
    eq: OUT std_logic);
--    AgtB: OUT std_logic;
--    AltB: OUT std_logic);
BEGIN
END comparator;



ARCHITECTURE Behav of comparator IS
BEGIN
    PROCESS(x,y)
    BEGIN
        IF (signed(x) = signed(y)) THEN
            eq <= '1';-- AgtB <= '0'; AltB <= '0';
--        ELSIF (signed(A)>signed(B)) THEN
--            eq <= '0'; AgtB <= '1'; AltB <= '0';
--        ELSIF (signed(A)<signed(B)) THEN
--            eq <= '0'; AgtB <= '0'; AltB <= '0';
        ELSE eq <= '0';
        END IF;
    END PROCESS;
END;