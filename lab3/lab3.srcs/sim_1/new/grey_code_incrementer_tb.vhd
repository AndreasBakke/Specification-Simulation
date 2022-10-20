LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY grey_code_incrementer_tb IS
BEGIN
END grey_code_incrementer_tb;

ARCHITECTURE TBarch of grey_code_incrementer_tb IS
    constant N: natural := 5;
    SIGNAL g_s, o_s: std_logic_vector(N-1 DOWNTO 0);
    
    COMPONENT grey_code_incrementer IS
        PORT(g: IN std_logic_vector(N-1 DOWNTO 0);
        o: OUT std_logic_vector(N-1 DOWNTO 0));
    END COMPONENT;
    
BEGIN
    comp_to_test: entity work.grey_code_incrementer
        GENERIC MAP(N => N)
        PORT MAP(g_s, o_s) ;
    PROCESS
    BEGIN
    g_s<= (others => '0');
    WAIT FOR 10ns;
    g_s<= o_s;
    WAIT FOR 10ns;
    g_s<= o_s;
    WAIT FOR 10ns;
    g_s<= o_s;
    WAIT FOR 10ns;
    g_s<= o_s;
    WAIT FOR 10ns;
    g_s<= o_s;
    WAIT FOR 10ns;
    g_s<= o_s;
    WAIT FOR 10ns;
    g_s<= o_s;
    WAIT FOR 10ns;
    g_s<= o_s;
    WAIT FOR 10ns;
    g_s<= o_s;
    WAIT FOR 10ns;
    g_s<= o_s;
    WAIT FOR 10ns;
    g_s<= o_s;
    WAIT FOR 10ns;
    g_s<= o_s;
    WAIT FOR 10ns;
    g_s<= o_s;
    WAIT FOR 10ns;
    g_s<= o_s;
    WAIT FOR 10ns;
    g_s<= o_s;
    WAIT FOR 10ns;
    WAIT;
    END PROCESS;

END TBarch;