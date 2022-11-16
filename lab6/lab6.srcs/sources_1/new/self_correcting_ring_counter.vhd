LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;



ENTITY self_correcting_ring_counter IS
    GENERIC(N: integer:= 4);
    PORT(
    clk: IN std_logic;
    enable: IN std_logic;
    RSTn: IN std_logic;
    count: OUT std_logic_vector(N-1 DOWNTO 0)
    );
BEGIN
END self_correcting_ring_counter;


ARCHITECTURE Behav of self_correcting_ring_counter IS
    SIGNAL currstate, nextstate: std_logic_vector(N-1 DOWNTO 0);
BEGIN
    stateReg: PROCESS(clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF RSTn = '0' THEN
                currstate <= (OTHERS => '0');
            ELSIF enable ='1' THEN
                currstate <= nextstate;
            END IF;  
        END IF;
    END PROCESS; --statereg
    
    combLogic: FOR i IN N-1 DOWNTO 0 GENERATE
        f: IF i = N-1 GENERATE
            PROCESS(currstate)
            BEGIN
                IF currstate(N-1 DOWNTO 1) = (currstate(N-1 DOWNTO 1)'range => '0') THEN
                nextstate(N-1) <= '1';
                ELSE
                nextstate(N-1) <= '0';
                END IF;
            END PROCESS;
        END GENERATE;
       r: IF i<N-1 GENERATE
            nextstate(i) <= currstate(i+1);
        END GENERATE;
--        r: IF i> 0 GENERATE
--            nextstate(i) <= nextstate(i-1);
--        END GENERATE;
--        f: IF i = 0 GENERATE
--            PROCESS(currstate)
--            BEGIN
--                IF currstate(N-1 DOWNTO 1) = (currstate(N-1 DOWNTO 1)'range => '0') THEN
--                nextstate(0) <= '1';
--                ELSE
--                nextstate(0) <= '0';
--                END IF;
--            END PROCESS;
--        END GENERATE;
       
    END GENERATE;
    count <= currstate;
END Behav;