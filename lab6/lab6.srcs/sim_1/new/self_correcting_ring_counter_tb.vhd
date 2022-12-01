LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY self_correcting_ring_counter_tb IS
BEGIN
END self_correcting_ring_counter_tb;


ARCHITECTURE TBarch of self_correcting_ring_counter_tb IS

    COMPONENT self_correcting_ring_counter IS
        GENERIC(N: natural := 4);
        PORT(
            clk: IN std_logic;
            enable: IN std_logic;
            RSTn: IN std_logic;
            count: OUT std_logic_vector(N-1 DOWNTO 0)
        );
    END COMPONENT;
    CONSTANT N: natural:= 4;
    CONSTANT clock_period: time:= 10ns;
    SIGNAL clk_s, enable_s, RSTn_s : std_logic;
    SIGNAL count_s: std_logic_vector(N-1 DOWNTO 0);
BEGIN
    dut: entity work.self_correcting_ring_counter(Behav)
        GENERIC MAP(N=>N)
        PORT MAP(clk => clk_s, enable => enable_s, RSTn => RSTn_s, count => count_s);
        
    clock_generator: PROCESS
    BEGIN
        clk_s <= '0';
        wait for (clock_period/2);
        clk_s <= '1';
        wait for (clock_period/2);
    END PROCESS; --clock_generator;
    
    
    testvector: PROCESS
    BEGIN
    RSTn_s <= '0'; enable_s <= '0';
    wait for clock_period*(3/2);
    RSTn_s <= '1';
    wait for clock_period;
    enable_s <= '1';
    wait;
    END PROCESS; --testvector
        
    
END TBarch;