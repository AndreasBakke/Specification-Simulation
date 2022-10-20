LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY alu_tb IS
BEGIN
END alu_tb;

ARCHITECTURE TBarch of alu_tb IS
    CONSTANT N: natural := 4;
    SIGNAL src0_s, src1_s: std_logic_vector(N-1 DOWNTO 0);
    SIGNAL ctrl_s: std_logic_vector(2 DOWNTO 0);
    SIGNAL result_s: std_logic_vector(N-1 DOWNTO 0);
    
    COMPONENT alu IS
        PORT(
        src0, src1: IN std_logic_vector(N-1 DOWNTO 0);
        ctrl: IN std_logic_vector(2 DOWNTO 0);
        result: OUT std_logic_vector(N-1 DOWNTO 0));
    END COMPONENT;
BEGIN
    comp_to_test: entity work.alu
        GENERIC MAP(N=>N)
        PORT MAP(src0_s, src1_s, ctrl_s, result_s);
    PROCESS
    BEGIN
    src0_s <= "0001"; src1_s <="0000"; ctrl_s <="000";
    WAIT FOR 10ns;
    
    src0_s <= "0001"; src1_s <="0010"; ctrl_s <="100";
    WAIT FOR 10ns;
    src0_s <= "0001"; src1_s <="0011"; ctrl_s <="100";
    WAIT FOR 10ns;
    src0_s <= "0001"; src1_s <="1001"; ctrl_s <="100";
    WAIT FOR 10ns;
    src0_s <= "0011"; src1_s <="0110"; ctrl_s <="100";
    WAIT FOR 10ns;
    
    
    src0_s <= "0011"; src1_s <="0001"; ctrl_s <="101";
    WAIT FOR 10ns;
    src0_s <= "1011"; src1_s <="0001"; ctrl_s <="101";
    WAIT FOR 10ns;
    src0_s <= "1110"; src1_s <="0101"; ctrl_s <="101";
    WAIT FOR 10ns;
    src0_s <= "0011"; src1_s <="0111"; ctrl_s <="101";
    WAIT FOR 10ns;
    src0_s <= "0011"; src1_s <="1111"; ctrl_s <="101";
    WAIT FOR 10ns;
    
    src0_s <= "0011"; src1_s <="0001"; ctrl_s <="110";
    WAIT FOR 10ns;
    src0_s <= "1011"; src1_s <="1001"; ctrl_s <="110";
    WAIT FOR 10ns;
    src0_s <= "0011"; src1_s <="1100"; ctrl_s <="110";
    WAIT FOR 10ns;
    src0_s <= "1111"; src1_s <="1111"; ctrl_s <="110";
    WAIT FOR 10ns;
    
    src0_s <= "0011"; src1_s <="0001"; ctrl_s <="111";
    WAIT FOR 10ns;
    src0_s <= "1011"; src1_s <="1001"; ctrl_s <="111";
    WAIT FOR 10ns;
    src0_s <= "0011"; src1_s <="1100"; ctrl_s <="111";
    WAIT FOR 10ns;
    src0_s <= "1111"; src1_s <="1111"; ctrl_s <="111";
    WAIT FOR 10ns;
    
    
    WAIT;
    END PROCESS;
END TBarch;
