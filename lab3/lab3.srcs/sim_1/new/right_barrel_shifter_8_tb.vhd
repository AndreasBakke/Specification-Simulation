LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


ENTITY right_barrel_shifter_8_tb IS
BEGIN
END right_barrel_shifter_8_tb;

ARCHITECTURE TBarch OF right_barrel_shifter_8_tb IS
    COMPONENT right_barrel_shifter_8 IS
        PORT (input: IN std_logic_vector(7 DOWNTO 0);
        lar: IN std_logic_vector(1 DOWNTO 0);
        amt: IN std_logic_vector(2 DOWNTO 0);
        output: OUT std_logic_vector(7 DOWNTO 0));
    END COMPONENT;
    
    SIGNAL input_s: std_logic_vector(7 DOWNTO 0);
    SIGNAL lar_s: std_logic_vector (1 DOWNTO 0);
    SIGNAL amt_s: std_logic_vector(2 DOWNTO 0);
    SIGNAL output_s: std_logic_vector(7 DOWNTO 0);
BEGIN
    comp_to_test: entity work.right_barrel_shifter_8(Behav) PORT MAP(input_s, lar_s, amt_s, output_s);
    PROCESS
    BEGIN
        input_s <= "10011000"; lar_s <= "00"; amt_s <="000";
        WAIT FOR 10ns;
        input_s <= "10011000"; lar_s <= "00"; amt_s <="001";
        WAIT FOR 10ns;
        input_s <= "10011000"; lar_s <= "00"; amt_s <="011";
        WAIT FOR 10ns;
        input_s <= "10011000"; lar_s <= "00"; amt_s <="101";
        WAIT FOR 10ns;
        
        input_s <= "10011000"; lar_s <= "01"; amt_s <="000";
        WAIT FOR 10ns;
        input_s <= "10011000"; lar_s <= "01"; amt_s <="001";
        WAIT FOR 10ns;
        input_s <= "10011000"; lar_s <= "01"; amt_s <="011";
        WAIT FOR 10ns;
        input_s <= "10011000"; lar_s <= "01"; amt_s <="101";
        WAIT FOR 10ns;        
        
        input_s <= "10011000"; lar_s <= "10"; amt_s <="000";
        WAIT FOR 10ns;
        input_s <= "10011000"; lar_s <= "10"; amt_s <="001";
        WAIT FOR 10ns;
        input_s <= "10011000"; lar_s <= "10"; amt_s <="011";
        WAIT FOR 10ns;
        input_s <= "10011000"; lar_s <= "10"; amt_s <="101";

        WAIT;
    END PROCESS;
    
    
END TBarch;