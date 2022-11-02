
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY mod10_counter IS
    GENERIC (N: integer := 1);
    PORT(
        enableSignals: IN std_logic_vector(N*4-1 DOWNTO 0); -- N signals of size 4 bit from past counters (ex 0-9 and 0-9)
        clk: IN std_logic;
        RSTn: IN std_logic;
        o: OUT std_logic_vector(3 DOWNTO 0)
        );
BEGIN
END mod10_counter;


ARCHITECTURE Behav of mod10_counter IS
    signal currstate, nextstate: std_logic_vector(3 DOWNTO 0);
    signal enable:std_logic_vector(n-1 DOWNTO 0);
BEGIN
    enableLogic: PROCESS(enableSignals)
    BEGIN
    IF N>0 THEN
        FOR i IN 0 TO N-1 LOOP
            IF unsigned(enableSignals(4*(i+1)-1 DOWNTO 4*(i))) = 9 THEN -- 8 since the enable = '1' check wont fire this round.
                 enable(i) <= '1';
            ELSE
                enable(i) <= '0';
            END IF;
        END LOOP;
    ELSE enable <= (OTHERS => '1'); --We know it will be 1 bit, but i suspect a error will be thrown if not declared like this.
    END IF;
    END PROCESS; --enable



    StateReg: PROCESS(clk, RSTn)
    BEGIN
        IF RSTn = '0' THEN
            currstate <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            
            IF enable = (enable'range => '1') THEN -- compares to vector of equal length consisting of 1s
                currstate <= nextstate;
            END IF;   
        END IF;
    END PROCESS; -- StateReg
    
    counter: PROCESS(currstate)
    BEGIN
    IF unsigned(currstate) < 9 THEN
        nextstate <= std_logic_vector(unsigned(currstate)+1);
    ELSE
        nextstate <= (others => '0');
    END IF;
    END PROCESS;
    o <= currstate;
END Behav;