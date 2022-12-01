LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY lsfr_8 IS
    PORT(
    seed: IN std_logic_vector(7 DOWNTO 0);
    clk: IN std_logic;
    RSTn: IN std_logic;
    output: OUT std_logic_vector(7 DOWNTO 0)
    );
BEGIN
END lsfr_8;


ARCHITECTURE Behav OF LSFR_8 IS
    signal registers: std_logic_Vector(7 DOWNTO 0);
BEGIN
    PROCESS(clk, RSTn)
    BEGIN
        if RSTn = '0' THEN
            registers <= seed;
        ELSIF rising_Edge(clk) THEN
            registers(6 DOWNTO 0) <= registers(7 DOWNTO 1);
            registers(7) <= registers(0) XOR registers(1);
        END IF;
    END PROCESS;
    output <= registers;
END Behav;