LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY BIST_RAM_top IS
    PORT(
    go: IN std_logic; --start signal
    fin: OUT std_logic;
    clk, Rst: IN std_logic --active low reset async.
    );
BEGIN

END BIST_RAM_top;



ARCHITECTURE Struct of BIST_RAM_top IS
    COMPONENT BIST IS
        PORT(
            go: IN std_logic;  -- start signal for test.
            Rst: IN std_logic; --active high reset signal
            fin: OUT std_logic; --signals that testing has finished;
            A, X: OUT std_logic_vector(15 downto 0); --data signals out
            Z: IN std_logic_vector(15 downto 0); --data signal in
            clr, rw: out std_logic; --memory controll signals
            clk: IN std_logic
        );
    END COMPONENT; --BIST
    
    COMPONENT RAM IS
        GENERIC (n: natural := 16; p: natural := 256;
        k: natural := 8; Td: time := 40ns);
      
        PORT (X: IN std_logic_vector(n-1 DOWNTO 0);
        A: IN std_logic_vector(k-1 DOWNTO 0);
        Z: OUT std_logic_vector(n-1 DOWNTO 0);
        Clr, RW, Clk: IN std_logic);
    END COMPONENT; --RAM
    
    
    SIGNAL A, X, Z : std_logic_vector(15 downto 0); 
    SIGNAL clr, rw: std_logic;
BEGIN
    RAM_block: RAM GENERIC MAP(n => 16, p => 2**16, k => 16, td => 1ns) PORT MAP(X => X, A => A, Z => Z, Clr => clr, RW => rw, clk => clk);
    BIST_block: BIST PORT MAP(go => go, Rst => Rst, fin => fin, A => A, X => X, Z => Z, Clr => Clr, Rw => rw, clk => clk);
END Struct;