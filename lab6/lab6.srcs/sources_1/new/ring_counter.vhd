LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ring_counter IS
    GENERIC(N: natural := 4);
    PORT(
    clk: IN std_logic;
    enable: IN std_logic;
    RSTn: IN std_logic;
    count: OUT std_logic_vector(N-1 DOWNTO 0)
    );
BEGIN

END ring_counter;


ARCHITECTURE Behav of ring_counter IS
    SIGNAL currstate, nextstate: std_logic_vector(N-1 DOWNTO 0);
BEGIN
    statereg: PROCESS(clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF RSTn = '0' THEN
                currstate <= (0 => '1', OTHERS => '0');
            ELSIF enable ='1' THEN
                currstate <= nextstate;
            END IF;
        END IF;
    END PROCESS;
    
    combLogic: FOR i IN N-1 DOWNTO 0 GENERATE
       f: IF i = N-1 GENERATE
            nextstate(i) <= currstate(0);
        END GENERATE;
       r: IF i<N-1 GENERATE
            nextstate(i) <= currstate(i+1);
        END GENERATE;
    END GENERATE;

    count <= currstate;
END Behav;



ARCHITECTURE Struct of ring_counter IS
    SIGNAL s: std_logic_vector(N-1 DOWNTO 0);
    COMPONENT register_1 IS
        GENERIC(rstValue: std_logic := '0');
        PORT(
            input: IN std_logic;
            enable: IN std_logic;
            RSTn: IN std_logic; --active low synchronous reset signal
            clk: IN std_logic; --clock signal
            output: OUT std_logic
        );
    END COMPONENT;
BEGIN
    
    ring_counter: FOR i IN N-1 DOWNTO 0 GENERATE
        r: IF i>0 GENERATE
            r_i: register_1
                GENERIC MAP(rstValue => '0')
                PORT MAP(input => s(i), enable => enable, clk => clk, RSTn => RSTn, output => s(i-1));
        END GENERATE;
    
        f: IF i = 0 GENERATE
            rN_1: register_1
                GENERIC MAP(rstValue => '1')
                PORT MAP(input => s(0), enable => enable, clk => clk, RSTn => RSTn, output => s(N-1));
        END GENERATE;
    END GENERATE;
    
    count <= s;
    
        
     

END Struct;