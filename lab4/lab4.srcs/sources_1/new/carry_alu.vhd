LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY carry_alu IS
    GENERIC(N: integer:= 4); -- 4 is default value of no value is assigned on initialization of entity.
    PORT(
        enable: IN std_logic;
        src0, src1: IN std_logic_vector(N-1 DOWNTO 0);
        c_in: IN std_logic;
        ctrl: IN std_logic_vector(2 DOWNTO 0);
        result: OUT std_logic_vector(N-1 DOWNTO 0);
        c_out: OUT std_logic);
BEGIN
END carry_alu;

ARCHITECTURE Datafl OF carry_alu IS
    
    SIGNAL buff: std_logic_vector(N DOWNTO 0);
BEGIN
    
    WITH ctrl SELECT buff <=
        '0' & std_logic_vector(signed(src0) + signed(src1) + ('0' & c_in)) WHEN "100",
        '0' & std_logic_vector(signed(src0) - signed(src1) + ('0' & c_in)) WHEN "101",
        '0' & src0 AND src1 WHEN "110",
        '0' & src0 OR src1 WHEN "111",
        '0' & std_logic_vector(signed(src0)+1+('0' & c_in)) WHEN OTHERS;
    WITH enable SELECT result <=
        buff(N-1 DOWNTO 0) WHEN '1',
        (OTHERS => '0') WHEN OTHERS;
        
    WITH enable SELECT c_out <=
        buff(N) WHEN '1',
        '0' WHEN OTHERS;
END Datafl;


