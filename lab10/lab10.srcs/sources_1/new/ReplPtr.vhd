LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY ReplPtr IS
    PORT(
    hit: IN std_logic;
    clk: IN std_logic;
    RSTn: IN std_logic;
    pointer: OUT std_logic_vector(1 downto 0)
    );
BEGIN

END ReplPtr;


ARCHITECTURE Behav of ReplPtr IS
    signal currPoint, nextPoint: std_logic_vector(1 downto 0) := (Others => '0');
BEGIN

    seq: PROCESS(clk, RSTn)
    BEGIN
        IF RSTn = '0' THEN
            currPoint <= (OThers => '0');
        ELSIF rising_edge(clk) THEN
            currPoint <= nextPoint;
        END IF;
    END PROCESS; --seq
    
    combLogic: PROCESS(hit, currPoint)
    BEGIN
    IF hit= '1' THEN
        nextPoint <= std_logic_vector(unsigned(currPoint) +1);
    END IF;
    END PROCESS; --combLogic
    pointer <= currPoint;
END Behav;