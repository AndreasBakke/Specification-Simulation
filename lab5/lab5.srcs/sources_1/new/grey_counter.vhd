LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY grey_counter IS
    GENERIC(N: integer := 4);
    PORT(
    enable: IN std_logic;
    count: OUT std_logic_vector(N-1 DOWNTO 0);
    clk, RSTn: IN std_logic
    );
BEGIN
END grey_counter;
  


ARCHITECTURE Behav OF grey_counter IS
 SIGNAL Currstate, Nextstate, hold, next_hold: std_logic_vector (N-1 DOWNTO 0);
BEGIN

  StateReg: PROCESS (Clk)
  BEGIN
    IF (Clk = '1' AND Clk'EVENT) THEN
      IF (RSTn = '0') THEN
        Currstate <= (OTHERS =>'0');
      ELSIF (enable = '1') THEN
        Currstate <= Nextstate;
      END IF;
    END IF;
  END PROCESS;

  hold <= Currstate XOR ('0' & hold(N-1 DOWNTO 1));
  next_hold <= std_logic_vector(unsigned(hold) + 1);
  Nextstate <= next_hold XOR ('0' & next_hold(N-1 DOWNTO 1)); 
  count <= Currstate;

END Behav;







