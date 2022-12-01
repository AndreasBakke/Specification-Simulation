LIBRARY ieee;
USE ieee.std_logic_1164.ALL;



ENTITY programmable_osp_gen_tb IS
BEGIN
END programmable_osp_gen_tb;


ARCHITECTURE TBarch of programmable_osp_gen_tb IS
    COMPONENT programmable_osp_gen IS
    PORT(
        go, stop: IN std_logic;
        output: OUT std_logic;
        clk: IN std_logic
        );
    END COMPONENT;
    
    signal go_s, stop_s, output_s, clk_s: std_logic;
    signal output_dp: std_logic;
    constant clk_period: time := 10ns;
BEGIN
    dut: entity work.programmable_osp_gen(HLSM) PORT MAP(go => go_s, stop => stop_s, output => output_s, clk => clk_s);
    dut2: entity work.programmable_osp_gen(CtrlDpBEh) PORT MAP(go => go_s, stop => stop_s, output => output_dp, clk => clk_s);
    
    clk_process: PROCESS
    BEGIN
        clk_s <= '0';
        WAIT FOR clk_period/2;
        clk_s <= '1';
        WAIT FOR clk_period/2;
    END PROCESS; --clk_process;
    
    testVector: PROCESS
    BEGIN
        go_s <= '0'; stop_s <= '1';
        wait for clk_period*(5/4);
        go_s <='1'; stop_s <= '1'; --start programming
        wait for clk_period;
        stop_s <= '0';
        go_s <= '1';
        wait for 2*clk_period;-- 1 clk cycle for setup
        go_s <= '1';
        wait for clk_period;
        go_s <= '0';
        wait for clk_period*2; --should have programmed 011 as target.
        
        go_S <= '1';
        wait for clk_period;
        go_s <= '0';
        wait for clk_period*10;
        go_s <= '1';
        wait for clk_period;
        go_s <= '0';
        wait for clk_period*2;
        stop_s <= '1';
        WAIT;
    END PROCESS; --testVector
    
END TBarch;
