LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


ENTITY manchester_encoder_tb IS
BEGIN
END manchester_encoder_tb;

ARCHITECTURE TBarch OF manchester_encoder_tb IS
    COMPONENT manchester_encoder IS
        PORT(
        data, valid: IN std_logic;
        clk, RSTn: IN std_logic;
        output: OUT std_logic
        );
    
    END COMPONENT;


    SIGNAL data_s, valid_s, clk_s, RSTn_s, output_s: std_logic;
    CONSTANT clk_period: time := 10ns;
BEGIN
    DUT: entity work.manchester_encoder(Behav) PORT MAP(data => data_s, valid => valid_s, clk => clk_s, RSTn => RSTn_s, output => output_s);

    
    clkDriver: PROCESS
    BEGIN
        clk_s <=  '0';
        wait for clk_period/2;
        clk_s <= '1';
        wait for clk_period/2;
    END PROCESS; --clkDriver

    testVector: PROCESS
    BEGIN
        data_s <= '0'; valid_s <= '0'; RSTn_s <= '0';
        wait for clk_period/4;
        data_s <= '0'; valid_s <= '0'; RSTn_s <= '1';
        wait for clk_period;
        data_s <= '0'; valid_s <= '1';
        wait for clk_period;
        data_s <= '1';
        wait for clk_period*3;
        data_s <= '0';
        wait for clk_period;
        data_s <= '1';
        wait for clk_period;
        data_s <= '0';
        wait for clk_period*10+clk_period/9;
        RSTn_s <= '0';
        
        wait;
    END PROCESS;

END TBarch;