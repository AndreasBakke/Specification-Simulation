LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY alu IS
    GENERIC(N: integer:= 4); -- 4 is default value of no value is assigned on initialization of entity.
    PORT(
        src0, src1: IN std_logic_vector(N-1 DOWNTO 0);
        ctrl: IN std_logic_vector(2 DOWNTO 0);
        result: OUT std_logic_vector(N-1 DOWNTO 0));
BEGIN
END alu;

ARCHITECTURE Datafl OF alu IS
BEGIN
    WITH ctrl SELECT result <=
        std_logic_vector(signed(src0) + signed(src1)) WHEN "100",
        std_logic_vector(signed(src0) - signed(src1)) WHEN "101",
        src0 AND src1 WHEN "110",
        src0 OR src1 WHEN "111",
        std_logic_vector(signed(src0)+1) WHEN OTHERS;

END Datafl;