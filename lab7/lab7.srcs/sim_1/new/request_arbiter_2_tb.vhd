LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;


ENTITY request_arbiter_2_tb IS
BEGIN
END request_arbiter_2_tb;


ARCHITECTURE TBarch of request_arbiter_2_tb IS
    COMPONENT request_arbieter_2 IS
        PORT(
        clk: IN std_logic;
        RSTn: IN std_logic;
        req1, req0: IN std_logic;
        grant1, grant0: OUT std_logic
        );
    END COMPONENT;
    
    SIGNAL clk_s, RSTn_s, req1_s, req0_s, grant1_pri, grant1_track, grant0_pri, grant0_track: std_logic;
    CONSTANT clk_period: time := 10ns;

BEGIN
    dut_1: entity work.request_arbiter_2(Behav_pri) PORT MAP(clk => clk_s, RSTn => RSTn_s, req1 => req1_s, req0 => req0_s, grant1=> grant1_pri, grant0 => grant0_pri);
    dut_2: entity work.request_arbiter_2(Behav_track) PORT MAP(clk => clk_s, RSTn => RSTn_s, req1 => req1_s, req0 => req0_s, grant1=> grant1_track, grant0 => grant0_track);


    clockDriver: PROCESS
    BEGIN
        clk_s <= '0';
        WAIT FOR clk_period/2;
        clk_s <= '1';
        WAIT FOR clk_period/2;
    END PROCESS; --clockDriver

    testVector: PROCESS
    BEGIN
    RSTn_s <= '0'; req1_s <= '0'; req0_s <= '0';
    wait for clk_period/4;
    RSTn_S <= '1';
    wait for clk_period;
    req1_s <= '1';
    wait for clk_period/2;
    req0_s <= '1';
    wait for clk_period;
    req1_s <= '0';
    wait for clk_period;
    req0_s <='0';
    wait for clk_period;
    req1_s <= '1'; req0_s <='1';
    wait for clk_period;
    req1_s <= '0';
    wait for clk_period;
    req0_s <= '0';
    req1_s <= '1';
    wait for clk_period;
    req0_s <= '0'; req1_s <= '0';
    wait for clk_period;
    req0_s <= '1'; req1_s <= '1';
    WAIT; --end of sim
    END PROCESS;
END TBARCH;