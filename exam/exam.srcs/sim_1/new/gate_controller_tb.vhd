LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


ENTITY gate_controller_tb IS
BEGIN
END gate_controller_tb;

ARCHITECTURE TBArch OF gate_controller_tb IS
    COMPONENT gate_controller IS
        PORT(
            F, B, OK: IN std_logic; -- status signals
            TL: OUT std_logic_vector(1 DOWNTO 0); --control signal
            clk, RSTn : IN std_logic  --assuming asynch active low reset
        );
    END COMPONENT;
    SIGNAL F_s, B_s, OK_s, clk_s, RSTn_s: std_logic;
    SIGNAL TL_s: std_logic_vector(1 DOWNTO 0);
    
    CONSTANT clk_period: time:= 10ns;
BEGIN
    dut: gate_controller PORT MAP(F => F_s, B => B_s, OK => OK_s, clk => clk_s, RSTn => RSTn_s, TL => TL_s);

    clockDriver: PROCESS BEGIN --Simulates clock
        clk_s <= '0';
        wait for clk_period/2;
        clk_s <= '1';
        wait for clk_period/2;
    END PROCESS; --clockDriver
    
    testVector: PROCESS BEGIN
        F_s <= '0'; B_s <= '0'; OK_s <= '0'; RSTn_s <= '0';
        wait for clk_period/4;
        RSTn_s <= '1';
        ASSERT(TL_s = "00") REPORT ("Failed test 1"); --System should still be IDLE
        wait for clk_period;
        F_s <= '1';
        wait for clk_period/2;
        ASSERT(TL_s = "10") REPORT ("Failed test 2"); --System should have gone to "read" and display red light
        wait for clk_period*3/2;
        OK_s <= '1';
        wait for clk_period/2;
        ASSERT(TL_s = "01") REPORT ("Failed test 3"); --System should have moved on to GateOpen state and display green light
        OK_s <= '0';
        wait for clk_period*3/2;
        ASSERT(TL_s = "01") REPORT("Failed Test 4"); --Light should still be green as F is still 1;
        F_s <= '0';
        wait for clk_period;
        ASSERT(TL_s = "10") REPORT ("Failed test 5"); -- Light should be red if B has not become 1 yet
        B_s <= '1';
        wait for clk_period;
        ASSERT(TL_s = "00") REPORT ("Failed test 5"); --Should be back to IDLE
        wait; --endless wait
    END PROCESS;
END TBArch;