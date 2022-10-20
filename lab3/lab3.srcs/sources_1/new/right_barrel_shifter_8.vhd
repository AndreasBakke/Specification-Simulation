LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY right_barrel_shifter_8 IS
    PORT (input: IN std_logic_vector(7 DOWNTO 0);
        lar: IN std_logic_vector(1 DOWNTO 0);
        amt: IN std_logic_vector(2 DOWNTO 0);
        output: OUT std_logic_vector(7 DOWNTO 0));
BEGIN
END right_barrel_shifter_8;

ARCHITECTURE Behav of right_barrel_shifter_8 IS
BEGIN
    PROCESS(input, lar, amt)
        VARIABLE pos: integer RANGE 0 TO 15;
        VARIABLE buff: std_logic_vector(7 DOWNTO 0);
    BEGIN
    IF LAR = "00" THEN -- Logical right shift
        FOR i IN 7 DOWNTO 0 LOOP
            pos := i+to_integer(unsigned(amt));
            IF i > 7-to_integer(unsigned(amt)) THEN
                buff(i) := '0';
            ELSIF i>=0 THEN
                buff(i) := input(pos);
            END IF;
        END LOOP;
        output <= buff;
    ELSIF LAR = "01" THEN
        FOR i IN 7 DOWNTO 0 LOOP
            pos := i+to_integer(unsigned(amt));
            IF i > 7-to_integer(unsigned(amt)) THEN
                buff(i) := input(7);
            ELSIF i>=0 THEN
                buff(i) := input(pos);
            END IF;
        END LOOP;
        output <= buff;
    ELSIF LAR = "10" THEN  -- Rotate right
        FOR i IN 7 DOWNTO 0 LOOP
            pos := i+to_integer(unsigned(amt));
            IF pos>7 THEN
                pos := pos-8;
            END IF;
            buff(i):= input(pos);
        END LOOP;
        output <= buff;
     ELSE output <= input;
     END IF;
    END PROCESS;
END Behav;


