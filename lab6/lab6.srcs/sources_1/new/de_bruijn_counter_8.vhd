LIBRARY ieee;
USE ieee.std_logic_1164.ALL;



ENTITY de_bruijn_counter_8 IS
    PORT(
    seed: IN std_logic_vector(7 DOWNTO 0);
    clk: IN std_logic;
    RSTn: IN std_logic;
    output: OUT std_logic_vector(7 DOWNTO 0)
    );
BEGIN
END de_bruijn_counter_8;


ARCHITECTURE Behav of de_bruijn_counter_8 IS
    signal registers: std_logic_Vector(7 DOWNTO 0);
    signal f, f_mod: std_logic := '0';
BEGIN
    PROCESS(clk, RSTn)
    BEGIN
        if RSTn = '0' THEN
            registers <= seed;
        ELSIF rising_Edge(clk) THEN
            registers(6 DOWNTO 0) <= registers(7 DOWNTO 1);
            f <= registers(0) XOR registers(1);
            f_mod <= f XOR ( NOT registers(7) AND NOT registers(6) AND NOT registers(5) AND NOT registers(4) AND NOT registers(3) AND NOT registers(2) AND NOT registers(1));
            registers(7) <= f_mod;
        END IF;
    END PROCESS;
    output <= registers;
    

END Behav;


ARCHITECTURE Behav_2 of de_bruijn_counter_8 IS
    signal currstate, nextstate: std_logic_vector(7 DOWNTO 0);
    signal f, f_mod, allzero: std_logic := '0';
BEGIN
    PROCESS(clk, RSTn)
    BEGIN
        if RSTn = '0' THEN
            currstate <= seed;
        ELSIF rising_Edge(clk) THEN
            currstate <= nextstate;
        END IF;
    END PROCESS;
    
    nextstate(6 DOWNTO 0) <= currstate( 7 DOWNTO 1);   
     f <= currstate(0) XOR currstate(1);
     allzero <=  '1' WHEN currstate(7 DOWNTO 0) = "00000000" ELSE '0';
     f_mod <= f XOR allzero;
     nextstate(7) <= f_mod;
     
    output <= currstate;
END Behav_2;