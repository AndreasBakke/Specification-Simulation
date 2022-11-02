LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY mod10_counter_tb IS
BEGIN

END mod10_counter_tb;


ARCHITECTURE TBarch of mod10_counter_tb IS 
    COMPONENT mod10_counter IS
        GENERIC (N: integer := 1);
        PORT(
            enableSignals: IN std_logic_vector(N*4-1 DOWNTO 0); -- N signals of size 4 bit from past counters (ex 0-9 and 0-9)
            clk: IN std_logic;
            RSTn: IN std_logic;
            o: OUT std_logic_vector(3 DOWNTO 0) --should be modified to also include past signals!
            );
    END COMPONENT;
    CONSTANT N: integer := 2;
    signal enableSignals_s: std_logic_Vector(N*4-1 DOWNTO 0);
    signal clk_s, RSTn_s: std_logic;
    signal o_s: std_logic_vector(3 DOWNTO 0);

BEGIN
    dut: mod10_counter
        GENERIC MAP(N => N)
        PORT MAP(enableSignals => enableSignals_s, clk => clk_s, RSTn => RSTn_s, o => o_s);
    
    clock: PROCESS
    BEGIN
    clk_s <= '0';
    wait for 2ns;
    clk_s <= '1';
    wait for 2ns;
    END PROCESS;
        
    
    
    reset: process
    BEGIN
    RSTn_s <= '0';
    wait for 1ns;
    RSTn_s <= '1';
    
    
    wait;
    END PROCESS;

    testVector: PROCESS(clk_s)
    BEGIN
    IF rising_edge(clk_s) THEN
        IF unsigned(enableSignals_s(3 DOWNTO 0)) <9 THEN
            enableSignals_s(3 dOWNTO 0)<= std_logic_vector(unsigned(enableSignals_s(3 DOWNTO 0))+1);
        ELSE
            enableSignals_s(3 DOWNTO 0) <= (OTHERS => '0');
        END IF;
    END IF;
    END PROCESS;
    
    
    testVector2: PROCESS(enableSignals_s(3 DOWNTO 0))
    BEGIN
        IF unsigned(enableSignals_s(3 DOWNTO 0)) = 0 THEN
            IF unsigned(enableSignals_s(7 DOWNTO 4)) <9 THEN
                enableSignals_s(7 dOWNTO 4)<= std_logic_vector(unsigned(enableSignals_s(7 DOWNTO 4))+1);
            ELSE
                enableSignals_s(7 DOWNTO 4) <= (OTHERS => '0');
            END IF;
        END IF;
    END PROCESS;
END TBarch;