LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


ENTITY moore_fsm_tb IS
BEGIN
END moore_fsm_tb;



ARCHITECTURE TBarch of moore_fsm_tb IS
    COMPONENT moore_fsm IS
        PORT(
        P, Clk, RSTn: IN std_logic;
        R: OUT std_logic
        );
    END COMPONENT;
    
    signal P_s, clk_s, RSTn_s, R_s: std_logic;
BEGIN
 -- TODO: TestVector from file, and save output to file. See 5. Testbenches and assertions.
    dut: moore_fsm PORT MAP(P => P_s, clk => clk_s, RSTn => RSTn_s, R => R_s);
    
    clock: PROCESS
    BEGIN
    clk_s <= '0';
    wait for 10ns;
    clk_s <= '1';
    wait for 10ns;
    END PROCESS; --clock
    
    
    testing: PROCESS
    BEGIN
    wait for 15ns;
    P_s <= '0'; RSTn_S <= '0';
    wait for 7ns; -- 22ns
    P_s <= '0'; RSTn_s <= '1';
    wait for 20ns; --42ns
    P_s <= '1';
    wait for 20ns;--62
    P_s <= '0';
    wait for 20ns; --82
    P_s <= '1';
    wait for 160ns; --242
    RSTn_s<= '0';
    wait for 2ns;
    RSTn_S <= '1';
    wait for 60ns;
    P_s <= '0';
    wait;
    END PROCESS; --testing
    
END TBarch;