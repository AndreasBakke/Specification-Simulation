LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY KeyFile IS
    PORT(
    key_in: IN std_logic_vector(15 downto 0);
    rep_ptr: IN std_logic_vector(1 downto 0);
    wr_en: IN std_logic;    
    
    addr_out: OUT std_logic_vector(1 downto 0);
    hit: OUT std_logic;
    clk, RSTn: IN std_logic
    );
BEGIN
END KeyFile;


ARCHITECTURE Behav of KeyFile IS


BEGIN


END Behav;