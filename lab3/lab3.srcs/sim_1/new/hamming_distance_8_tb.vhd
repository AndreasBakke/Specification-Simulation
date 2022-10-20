LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;


ENTITY hamming_distance_8_tb IS
BEGIN
END hamming_distance_8_tb;

ARCHITECTURE beh OF hamming_distance_8_tb IS
    COMPONENT hamming_distance_8 IS
        PORT(a,b: IN std_logic_vector(7 DOWNTO 0);
        result: OUT std_logic_vector(3 DOWNTO 0));
    END COMPONENT;
    
    SIGNAL a_s, b_s: std_logic_vector(7 DOWNTO 0);
    SIGNAL result_s: std_logic_vector(3 DOWNTO 0);
    
BEGIN
    comp_to_test: entity work.hamming_distance_8(Behav) PORT MAP(a_s, b_s, result_s);
    PROCESS
    BEGIN
    a_s <= "00010011"; b_s <= "10010010";
    WAIT FOR 10ns;
    a_s <= "00000000"; b_s <= "10000000";
    WAIT FOR 10ns;
    a_s <= "ZZZZZZZZ"; b_s <= "10101010";
    WAIT FOR 10ns;
    a_s <= "ZZZZZZZZ"; b_s <= "ZZZZZZZZ";
    WAIT FOR 10ns;
    a_s <= "11111111"; b_s <= "00000000";

    WAIT;
    END PROCESS;
END beh;