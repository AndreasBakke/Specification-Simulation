LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY RAM IS
    GENERIC (n: natural := 16; p: natural := 256;
    k: natural := 8; Td: time := 40 ns);
  
    PORT (X: IN std_logic_vector(n-1 DOWNTO 0);
    A: IN std_logic_vector(k-1 DOWNTO 0);
    Z: OUT std_logic_vector(n-1 DOWNTO 0);
    Clr, RW, Clk: IN std_logic);
END RAM;



ARCHITECTURE Beh OF RAM IS
    SUBTYPE WordT IS std_logic_vector(n-1 DOWNTO 0);
    TYPE StorageT IS ARRAY(0 TO p-1) OF WordT;
    SIGNAL Memory: StorageT;
BEGIN
    WrProc: PROCESS (Clk)
    BEGIN
        IF (rising_edge(Clk)) THEN
            IF (Clr = '1') THEN
                Memory <= (OTHERS => (OTHERS =>'0'));
            ELSIF (RW = '1') THEN
            Memory(to_integer(unsigned(A))) <= X;
            END IF;
        END IF;
    END PROCESS;
   
    RdProc: PROCESS (RW, A, Memory)
    BEGIN
        IF (RW = '0') THEN
            Z <= Memory(to_integer(unsigned(A))) AFTER Td;
        ELSE
            Z <= (OTHERS =>'Z') AFTER Td;
        END IF;
    END PROCESS;
END Beh;