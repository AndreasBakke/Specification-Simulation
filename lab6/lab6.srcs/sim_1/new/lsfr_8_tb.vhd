LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY lsfr_8_tb IS
BEGIN

END lsfr_8_tb;


ARCHITECTURE TBarch of lsfr_8_tb IS
    COMPONENT lsfr_8 IS
    PORT(
        seed: IN std_logic_vector(7 DOWNTO 0);
        clk: IN std_logic;
        RSTn: IN std_logic;
        output: OUT std_logic_vector(7 DOWNTO 0)
        );
    END COMPONENT;
    
    
    SIGNAL seed_s, output_s: std_logic_vector(7 DOWNTO 0);
    SIGNAL clk_s, RSTn_s: std_logic;
    
    CONSTANT clock_period: time := 10ns;
BEGIN

    dut: lsfr_8 PORT MAP(seed => seed_s, clk => clk_s, RSTn => RSTn_s, output => output_s);
    
    
    clockGenerator: PROCESS
    BEGIN
    clk_s <= '0';
    wait for(clock_period/2);
    clk_s <= '1';
    wait for(clock_period/2);
    END PROCESS; --clockGenerator


    testVector: PROCESS
    BEGIN
    RSTn_s <= '0'; seed_s <= "10000000"; 
    wait for (clock_period/4);
    RSTn_s <= '1'; 
    WAIT;
    END PROCESS; --testVector
END TBarch;