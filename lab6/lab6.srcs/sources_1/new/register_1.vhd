LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY register_1 IS
    GENERIC(rstValue: std_logic := '0');
    PORT(
    input: IN std_logic;
    enable: IN std_logic;
    RSTn: IN std_logic; --active low synchronous reset signal
    clk: IN std_logic; --clock signal
    output: OUT std_logic
    );
BEGIN
END register_1;


ARCHITECTURE Behav OF register_1 IS
    SIGNAL currstate, nextstate: std_logic;
BEGIN
    stateReg: PROCESS(clk)
    BEGIN
        IF(RSTn = '0') THEN
            currstate <= rstValue;
        ELSIF rising_edge(clk) THEN
            IF enable ='1' THEN
                currstate <= nextstate;
            END IF;
        END IF;
    END PROCESS;
    
    nextstate <= input;
    output <= currstate;
END Behav;


