LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY BIST_RAM_top_tb IS
BEGIN
END BIST_RAM_top_tb;


ARCHITECTURE TBArch OF BIST_RAM_top_tb IS

    COMPONENT BIST_RAM_top IS
        PORT(
        go: IN std_logic; --start signal
        fin: OUT std_logic;
        clk, Rst: IN std_logic --active low reset async.
        );
    END COMPONENT; --BIST_RAM_top

    SIGNAL go_s, fin_s, clk_s, Rst_s: std_logic;
    CONSTANT clock_period: time := 2ns;
BEGIN
    uut: BIST_RAM_top PORT MAP(clk => clk_s, Rst => rst_S, go => go_s, fin => fin_s);
    
    clk_gen: PROCESS
    BEGIN
        clk_s <= '0';
        wait for clock_period/2;
        clk_s <= '1';
        wait for clock_period/2;
    END PROCESS; --clk_gen
    
    
    test_vector: PROCESS
    BEGIN
    go_s <= '0'; Rst_s <= '1';
    wait for clock_period*2;
    go_s <= '1'; Rst_s <= '0';
    wait for clock_period*2;
    go_s <= '0';
    
    
    WAIT;
    END PROCESS;
END TBARCH;