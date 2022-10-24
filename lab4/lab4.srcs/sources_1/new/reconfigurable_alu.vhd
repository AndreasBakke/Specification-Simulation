LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY reconfigurable_alu IS
    PORT(
    A, B: IN std_logic_vector(15 DOWNTO 0);
    nibble: IN std_logic_vector(3 DOWNTO 0);
    ctrl: IN std_logic_vector(2 DOWNTO 0);
    result: OUT std_logic_Vector(15 DOWNTO 0)
    );
BEGIN
END reconfigurable_alu;



ARCHITECTURE Struct of reconfigurable_alu IS
    CONSTANT N: integer := 4;
    COMPONENT carry_alu IS
        GENERIC(N: integer:= 4); -- 4 is default value of no value is assigned on initialization of entity.
        PORT(
            enable: IN std_logic;
            src0, src1: IN std_logic_vector(N-1 DOWNTO 0);
            c_in: IN std_logic;
            ctrl: IN std_logic_vector(2 DOWNTO 0);
            result: OUT std_logic_vector(N-1 DOWNTO 0);
            c_out: OUT std_logic);
    END COMPONENT;
    
    signal S1,S2, S3, S4: std_logic;
    
BEGIN --Problem: ved src0+1, vil alle aluer legge til en, men bare den første bør gjøre det....
    carry_alu_1: carry_alu  GENERIC MAP(N=> N) PORT MAP(enable => nibble(0), src0 => A(3 DOWNTO 0), src1 => B(3 DOWNTO 0),c_in => '0', ctrl => ctrl, result => result(3 DOWNTO 0), c_out=>s1);
    carry_alu_2: carry_alu  GENERIC MAP(N=> N) PORT MAP(enable => nibble(1), src0 => A(7 DOWNTO 4), src1 => B(7 DOWNTO 4),c_in => s1, ctrl => ctrl, result => result(7 DOWNTO 4), c_out=>s2);
    carry_alu_3: carry_alu  GENERIC MAP(N=> N) PORT MAP(enable => nibble(2), src0 => A(11 DOWNTO 8), src1 => B(11 DOWNTO 8),c_in => s2, ctrl => ctrl, result => result(11 DOWNTO 8), c_out=>s3);
    carry_alu_4: carry_alu  GENERIC MAP(N=> N) PORT MAP(enable => nibble(3), src0 => A(15 DOWNTO 12), src1 => B(15 DOWNTO 12),c_in => s3, ctrl => ctrl, result => result(15 DOWNTO 12), c_out=>s4);
END Struct;