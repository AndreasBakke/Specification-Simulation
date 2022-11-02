LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY grey_code_incrementer IS
    GENERIC(N: integer:= 4); -- 4 is default value of no value is assigned on initialization of entity.
    PORT(
    g: IN std_logic_vector(N-1 DOWNTO 0);
    o: OUT std_logic_vector(N-1 DOWNTO 0)
    );
BEGIN
END grey_code_incrementer;

ARCHITECTURE Datafl of grey_code_incrementer IS
    SIGNAL b, b_2: std_logic_vector(N DOWNTO 0);
--    signal b_temp: std_logic_vector(N DOWNTO 0);
BEGIN
--    o <= (OTHERS =>  '0');
    b(N) <= '0'; --Set first bit to 0
TO_BIN:  
    FOR i IN N-1 DOWNTO 0 GENERATE
        b(i) <= g(i) XOR b(i+1);
--        b<= b_temp;
    END GENERATE;
INC_BIN:
    b_2 <= std_logic_vector(unsigned(b)+1);
TO_GREY:
    FOR i IN N-1 DOWNTO 0 GENERATE
        o(i) <= b_2(i+1) XOR b_2(i);
    END GENERATE;
END Datafl;