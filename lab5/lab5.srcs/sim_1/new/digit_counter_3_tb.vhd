LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


ENTITY digit_counter_3_tb IS
BEGIN
END digit_counter_3_tb;

ARCHITECTURE TBarch OF digit_counter_3_tb IS
    COMPONENT digit_counter_3 IS
        PORT(
        clk: IN std_logic;
        RSTn: IN std_logic;
        count: OUT std_logic_vector(11 DOWNTO 0)
        );
    END COMPONENT;
    
    SIGNAL clk_s, RSTn_s: std_logic;
    SIGNAL count_s: std_logic_vector(11 DOWNTO 0);
    
    CONSTANT clock_period: time:= 1ns;
BEGIN
    dut: digit_counter_3 PORT MAP(clk => clk_s, RSTn => RSTn_s, count => count_s);



    clockDriver: PROCESS
    BEGIN
    clk_s <= '0';
    wait for (clock_period/2);
    clk_s <= '1';
    wait for(clock_period/2);
    END PROCESS;
    
    resetDriver: PROCESS
    BEGIN
    RSTn_s <='0';
    wait for (clock_period/4);
    RSTn_s <='1';
    --wait for(clock_period*10);
    --RSTn_s <='0';
    --wait for(clock_period);
    --RSTn_s <='1';
    wait;
    END PROCESS;
    
END TBarch;