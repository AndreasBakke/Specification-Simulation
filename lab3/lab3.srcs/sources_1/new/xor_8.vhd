library ieee;
USE ieee.std_logic_1164.ALL;


entity xor_8 IS
    PORT(
    x,y: IN std_logic_vector(7 DOWNTO 0);
    F: OUT std_logic_vector(7 DOWNTO 0));
BEGIN
END xor_8;


ARCHITECTURE Behav OF xor_8 IS
BEGIN
    F <= x XOR y;
END Behav;