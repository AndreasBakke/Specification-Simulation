LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


entity combinational_multiplier_tb IS
BEGIN
END;


ARCHITECTURE TBarch OF combinational_multiplier_tb IS
    COMPONENT combinational_multiplier IS
        PORT(
            a, b: IN std_logic_vector(3 DOWNTO 0);
            p: OUT std_logic_vector(7 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL a_s,b_s: std_logic_vector(3 DOWNTO 0);
    SIGNAL p_s: std_logic_vector(7 DOWNTO 0);

BEGIN
    dut: entity work.combinational_multiplier(OptimizedDatafl) PORT MAP(a=> a_s, b => b_s, p => p_s);
    
    testing: PROCESS
    BEGIN
    a_s <= "0000"; b_s <= "0000";
    wait for 10 ns;
    ASSERT p_s = "00000000" REPORT "INITIALIZATION FAILED";
    wait for 10ns;
    a_s <= "1010"; b_s <= "0000";
    wait for 10 ns;
    ASSERT p_s = "00000000" REPORT "FIRST TEST FAILED";
    wait for 10ns;
    a_s <= "0000"; b_s <= "0101";
    wait for 10 ns;
    ASSERT p_s = "00000000" REPORT "SECOND TEST FAILED";
    wait for 10ns;
    a_s <= "0001"; b_s <= "1010";
    wait for 10 ns;
    ASSERT p_s = "00001010" REPORT "THIRD TEST FAILED";
    wait for 10ns;
    a_s <= "0110"; b_s <= "0010";
    wait for 10 ns;
    ASSERT p_s = "00001100" REPORT "FOURTH FAILED";
    wait for 10ns;
    a_s <= "0111"; b_s <= "0011";
    wait for 10 ns;
    ASSERT p_s = "00010101" REPORT "FIFTH FAILED";
    wait for 10ns;
    a_s <= "1101"; b_s <= "1010";
    wait for 10 ns;
    ASSERT p_s = "10000010" REPORT "SIXTH FAILED";
    wait for 10ns;
    a_s <= "1111"; b_s <= "1111";
    wait for 10 ns;
    ASSERT p_s = "11100001" REPORT "SIXTH FAILED";
    wait for 10ns;
    
    
    
    wait;
    END PROCESS;



END;