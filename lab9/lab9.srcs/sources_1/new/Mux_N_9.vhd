LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

package arrayInput IS
    TYPE signalArray IS ARRAY (integer range <>) OF std_logic_vector(8 DOWNTO 0);
end package;


LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.arrayInput;

ENTITY Mux_N_9 IS
    GENERIC(
    N: integer := 4; --num of signals in
    S: integer := 2 -- selection signal size (Should be done automatically, but numeric doesnt have log2
    );
    
    PORT(
        i: IN arrayInput.signalArray(0 TO N);
        sel: IN std_logic_vector(S-1 downto 0);
        o: OUT std_logic_vector(8 DOWNTO 0)
    );
BEGIN
END Mux_N_9;


ARCHITECTURE Behav of Mux_N_9 IS
    signal test: std_logic;
BEGIN
    o <= i(to_integer(unsigned(sel)));
END Behav;