LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Mux_4_9 IS
    PORT(
        i0, i1, i2, i3: std_logic_vector(8 downto 0);
        sel: IN std_logic_vector(1 downto 0);
        o: OUT std_logic_vector(8 DOWNTO 0)
    );
BEGIN
END Mux_4_9;


ARCHITECTURE Behav of Mux_4_9 IS
    signal test: std_logic;
    TYPE muxArray IS ARRAY(0 TO 3) of std_logic_vector(8 downto 0);
    SIGNAL m: muxArray;
BEGIN
    m <= (i0, i1, i2, i3);
    o <= m(to_integer(unsigned(sel)));
END Behav;