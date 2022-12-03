LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


ENTITY square_root_approximator_tb IS
BEGIN
END square_root_approximator_tb;


ARCHITECTURE TBarch OF square_root_approximator_tb IS
    COMPONENT square_root_approximator
        PORT(
            A, B: IN std_logic_vector(7 DOWNTO 0);
            start: IN std_logic;
            res : OUT std_logic_vector(8 DOWNTO 0);
            ready: OUT std_logic;
            clk, RSTn: IN std_logic
        );
    END COMPONENT;
    
    SIGNAL A_s, B_s: std_logic_vector(7 DOWNTO 0);
    SIGNAL res_s, res_2: std_logic_vector(8 DOWNTO 0);
    SIGNAL start_s, ready_S, clk_s, RSTn_s, ready_2: std_logic;
    
    
    CONSTANT clk_period: time := 10ns;
    
BEGIN
    
    dut: entity work.square_root_approximator(HLSM) PORT MAP(clk => clk_s, RSTn=>RSTn_s, A=> A_s, B => B_s, start => start_S, res=> res_s, ready => ready_s);
    dut2: entity work.square_root_approximator(FSM_d) PORT MAP(clk => clk_s, RSTn=>RSTn_s, A=> A_s, B => B_s, start => start_S, res=> res_2, ready => ready_2);

    clock_gen: PROCESS
    BEGIN
        clk_s <= '0';
        wait for clk_period/2;
        clk_s <= '1';
        wait for clk_period/2;
    END PROCESS; --clock_gen
    
    
    test_vector: PROCESS
    BEGIN
        A_s <= (OTHERS => '0'); B_s <= (OTHERS => '0'); start_s <= '0'; RSTn_s <= '0';
        wait for clk_period/4;
        A_s <= "01010011"; B_s <= "10011001"; RSTn_s <= '1';
        wait for clk_period;
        start_s <= '1';
        wait for clk_period;
        start_s <= '0';
        wait for 8*clk_period;
        A_s <= "00000000"; B_s <= "00001001";
        start_s <= '1';
        wait for clk_period;
        RSTn_s <= '0';
        wait for clk_period/8;
        RSTn_s <= '1';
        wait for clk_period;
        start_s <= '0';
        
        wait;
    END PROCESS; --test_vector

END TBarch;