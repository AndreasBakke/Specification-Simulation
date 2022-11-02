LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY digit_counter_3 IS
    PORT(
    clk: IN std_logic;
    RSTn: IN std_logic;
    count: OUT std_logic_vector(11 DOWNTO 0)
    );
BEGIN
END digit_counter_3;



ARCHITECTURE Struct of digit_counter_3 IS
    COMPONENT mod10_counter IS
        GENERIC (N: integer := 1);
        PORT(
            enableSignals: IN std_logic_vector(N*4-1 DOWNTO 0); -- N signals of size 4 bit from past counters (ex 0-9 and 0-9)
            clk: IN std_logic;
            RSTn: IN std_logic;
            o: OUT std_logic_vector(3 DOWNTO 0)
            );
    END COMPONENT;
    signal c0,c1,c2: std_logic_vector(3 DOWNTO 0);
    signal en1 : std_logic_vector(7 DOWNTO 0);
BEGIN
    mod10_counter_1: mod10_counter
        GENERIC MAP(N => 0)
        PORT MAP(enablesignals => "", clk => clk, RSTn => RSTn, o => c0);
    mod10_counter_2: mod10_counter
        GENERIC MAP(N => 1)
        PORT MAP(enablesignals => c0, clk => clk, RSTn => RSTn, o => c1);
    en1 <= c1 & c0;
    mod10_counter_3: mod10_counter
        GENERIC MAP(N => 2)
        PORT MAP(enablesignals => en1, clk => clk, RSTn => RSTn, o => c2);
    
    count <= c2 & c1 & c0;

END Struct;
