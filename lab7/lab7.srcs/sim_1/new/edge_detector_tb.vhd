LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;


ENTITY edge_detector_tb IS
BEGIN
END edge_detector_tb;


ARCHITECTURE TBarch of edge_detector_tb IS
    COMPONENT edge_detector IS
        PORT(
        strobe: IN std_logic;
        clk: IN std_logic;
        RSTn: IN std_logic;
        edge: OUT std_logic
        );
    END COMPONENT; --edge detector;
    
    
    signal strobe_s, clk_s, RSTn_s, edge_mo, edge_me: std_logic;
    constant clk_period: time:= 10ns;

BEGIN
    dut_mealy: entity work.edge_detector(mealy) PORT MAP(strobe => strobe_s, clk => clk_s, RSTn => RSTn_s, edge => edge_me);
    dut_moore: entity work.edge_detector(moore) PORT MAP(strobe => strobe_s, clk => clk_s, RSTn => RSTn_s, edge => edge_mo);
    
    
    clockDriver: PROCESS
    BEGIN
        clk_s <= '0';
        WAIT FOR (clk_period/2);
        clk_s <= '1';
        WAIT FOR (clk_period/2);
    END PROCESS;
     
     
     testVector: PROCESS
     BEGIN
     RSTn_s <= '0'; strobe_s <='0';
     wait for clk_period/4;
     RSTn_s <= '1';
     wait for clk_period;
     strobe_s <= '1';
     wait for clk_period;
     strobe_s <= '0';
     wait for clk_period;
     strobe_s <= '1';
     wait for clk_period/10;
     strobe_s <= '0';
     
     
     WAIT;
     
     
     END PROCESS; --testVector

END TBarch;