LIBRARY ieee;
USE ieee.std_logic_1164.ALL;



entity reconfigurable_alu_tb IS
BEGIN

END reconfigurable_alu_tb;

ARCHITECTURE TBarch of reconfigurable_alu_tb IS
    COMPONENT reconfigurable_alu IS
        PORT(
            A, B: IN std_logic_vector(15 DOWNTO 0);
            nibble: IN std_logic_vector(3 DOWNTO 0);
            ctrl: IN std_logic_vector(2 DOWNTO 0);
            result: OUT std_logic_Vector(15 DOWNTO 0)
        );
    END COMPONENT;
    
    SIGNAL A_s, B_s, result_s: std_logic_vector(15 DOWNTO 0);
    SIGNAL nibble_s: std_logic_vector(3 DOWNTO 0);
    SIGNAL ctrl_s: std_logic_vector(2 DOWNTO 0);
BEGIN
    dut: reconfigurable_alu PORT MAP(A=> A_s, B=> B_s, nibble=> nibble_s, ctrl => ctrl_s, result => result_s);
    
    testing: PROCESS
    BEGIN
    A_s <= "1111111111111111"; B_s <= "1111111111111111"; nibble_s <= "0000"; ctrl_s <= "000";
    wait for 10ns;
    assert result_s = "0000000000000000" report "INITIALIZATION FAILED";
    wait for 10ns;
    A_s <= "1111111111111110"; B_s <= "1111111111111111"; nibble_s <= "0001"; ctrl_s <= "001";
    wait for 10ns;
    assert result_s = "0000000000001111" report "First test FAILED";
    wait for 10ns;
    A_s <= "0000000000000001"; B_s <= "1111111111111111"; nibble_s <= "0101"; ctrl_s <= "001";
    wait for 10ns;
    assert result_s = "0000000100000010" report "Second test FAILED";
    wait for 10ns;
    A_s <= "0010100101111001"; B_s <= "1111111111111111"; nibble_s <= "1101"; ctrl_s <= "110";
    wait for 10ns;
    assert result_s = "0010100100001001" report "THIRD test FAILED";
    wait for 10ns;
    A_s <= "1111111111111111"; B_s <= "1111111111111111"; nibble_s <= "0101"; ctrl_s <= "110";
    wait for 10ns;
    assert result_s = "0000111100001111" report "Fourth test FAILED";
    wait for 10ns;
    A_s <= "1010010101010110"; B_s <= "1111111111111111"; nibble_s <= "1101"; ctrl_s <= "111";
    wait for 10ns;
    assert result_s = "1111111100001111" report "fifth test FAILED";
    wait for 10ns;
    A_s <= "0000000011111010"; B_s <= "0100000100111001"; nibble_s <= "1101"; ctrl_s <= "100";
    wait for 10ns;
    assert result_s = "0100000100000011" report "fifth test FAILED";
    wait for 10ns;
    A_s <= "0001001100000011"; B_s <= "0010110100000101"; nibble_s <= "1101"; ctrl_s <= "100";
    wait for 10ns;
    assert result_s = "0011000000001000" report "fifth test FAILED";
    wait for 10ns;
    wait; 
    END PROCESS; -- testing
END TBarch;
