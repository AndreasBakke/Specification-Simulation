LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


ENTITY majority_vote_alu_tb IS
BEGIN
END majority_vote_alu_tb;

ARCHITECTURE Beh of majority_vote_alu_tb IS
    COMPONENT majority_vote_alu IS
        PORT(A,B,C,D,E,F: IN std_logic_vector(7 DOWNTO 0);
        ctrl: IN std_logic_vector(2 DOWNTO 0);
        decision: OUT std_logic_vector(7 DOWNTO 0);
        data_valid: OUT std_logic
        );
    END COMPONENT;

    SIGNAL A_s, B_s, C_s, D_s, E_s, F_s, decision_s: std_logic_vector(7 DOWNTO 0);
    SIGNAL ctrl_s: std_logic_vector(2 DOWNTO 0);
    SIGNAL data_valid_s: std_logic;
BEGIN
    dut: entity work.majority_vote_alu
        PORT MAP(A=> A_s, B => B_s, C => C_s, D => D_s, E => E_s, F => F_s, ctrl => ctrl_s, decision => decision_s, data_valid => data_valid_s);
    
    PROCESS
    BEGIN
    A_s <= "00000000"; B_s <= "00000000"; C_s <= "00000000"; D_s <= "00000000"; E_s <= "00000000"; F_s <= "00000000"; ctrl_s <= "000";
    WAIT FOR 10ns;
    ASSERT decision_s = "00000001" AND data_valid_s = '1' REPORT "FIRST ASSERTION FAILED";
    WAIT FOR 10ns;

    A_s <= "00000110"; B_s <= "00000000"; C_s <= "00000110"; D_s <= "00000000"; E_s <= "00000000"; F_s <= "00000000"; ctrl_s <= "000";
    WAIT FOR 10ns;
    ASSERT decision_s = "00000111" AND data_valid_s = '1' REPORT "SECOND ASSERTION FAILED";
    WAIT FOR 10ns;

    A_s <= "00000001"; B_s <= "00000000"; C_s <= "00000010"; D_s <= "00000000"; E_s <= "00000000"; F_s <= "00000000"; ctrl_s <= "000";
    WAIT FOR 10ns;
    ASSERT decision_s = "ZZZZZZZZ" AND data_valid_s = '0' report "THIRD ASSERTION FAILED";
    WAIT FOR 10ns;

    A_s <= "00100100"; B_s <= "00000011"; C_s <= "00100100"; D_s <= "00000011"; E_s <= "00100100"; F_s <= "00000000"; ctrl_s <= "100";
    WAIT FOR 10ns;
    ASSERT decision_s = "00100111" AND data_valid_s = '1' report "FOUrTH ASSERTION FAILED";
    WAIT FOR 10ns;

    A_s <= "00100100"; B_s <= "00000010"; C_s <= "00100100"; D_s <= "00000011"; E_s <= "00100100"; F_s <= "00000000"; ctrl_s <= "100";
    WAIT FOR 10ns;
    ASSERT decision_s = "ZZZZZZZZ" AND data_valid_s = '0' report "FIFTH ASSERTION FAILED";
    WAIT FOR 10ns;

    A_s <= "00000000"; B_s <= "00000000"; C_s <= "00000000"; D_s <= "00000000"; E_s <= "00000000"; F_s <= "00000000"; ctrl_s <= "000";
    WAIT FOR 10ns;
    ASSERT decision_s = "00000001" AND data_valid_s = '1' report "SIXTH ASSERTION FAILED";
    WAIT FOR 10ns;

    A_s <= "10000001"; B_s <= "01111111"; C_s <= "10000001"; D_s <= "01111111"; E_s <= "10000000"; F_s <= "01111110"; ctrl_s <= "100";
    WAIT FOR 10ns;
    ASSERT decision_s = "00000000" AND data_valid_s = '1' report "SEVENTH ASSERTION FAILED";
    WAIT FOR 10ns;

    A_s <= "00000000"; B_s <= "00000000"; C_s <= "00000000"; D_s <= "00000000"; E_s <= "00000000"; F_s <= "00000000"; ctrl_s <= "000";
    WAIT FOR 10ns;
    ASSERT decision_s = "00000001" AND data_valid_s = '1' report "EIGHT ASSERTION FAILED";
    WAIT FOR 10ns;
    
    
    
    WAIT;
    END PROCESS;
    
    
    
END Beh;