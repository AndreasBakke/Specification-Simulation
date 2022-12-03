LIBRARY ieee;
USE ieee.std_logic_1164.ALL;



ENTITY multiplier_tb IS
BEGIN
END multiplier_tb;

ARCHITECTURE TBarch OF multiplier_tb IS
    COMPONENT multiplier IS
    PORT(
        A, B: IN std_logic_vector(7 downto 0);
        start:IN std_logic;
        res:    OUT std_logic_vector(15 downto 0);
        ready: OUT std_logic;
        clk: IN std_logic;
        RSTn: IN std_logic
    );
    END COMPONENT;

    SIGNAL  A_s, B_s: std_logic_vector(7 downto 0);
    SIGNAL start_s, ready_1, ready_2, clk_s, RSTn_s: std_logic;
    SIGNAL res_1, res_2: std_logic_vector(15 downto 0);
    
    CONSTANT clk_period: time := 10ns;
BEGIN
    dut: entity work.multiplier(FSM_d) PORT MAP(A => A_s, B => B_s, start => start_s, res => res_1, ready => ready_1, clk => clk_s, RSTn => RSTn_s);
    dut2: entity work.multiplier(HLSM) PORT MAP(A => A_s, B => B_s, start => start_s, res => res_2, ready => ready_2, clk => clk_s, RSTn => RSTn_s);
    
    
    clk_signal: PROCESS
    BEGIN
        clk_s <= '0';
        wait for clk_period/2;
        clk_S <= '1';
        wait for clk_period/2;
    END PROCESS; --clk_signal


    testVector: PROCESS
    BEGIN
    A_s <= (OTHERS => '0'); B_s <= (OTHERS => '0'); start_s <= '0'; RSTn_s <= '0';
    wait for clk_period/4;
    A_s <= "00001001"; B_s <= "01000000"; RSTn_s <= '1';
    wait for clk_period;
    start_s <= '1';
    wait for clk_period;
    start_s <= '0';
    
    
    
    
    WAIT;
    END PROCESS; --testVector
END TBarch;