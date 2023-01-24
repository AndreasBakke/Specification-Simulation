Library ieee;
USE ieee.std_logic_1164.ALL;


ENTITY div_mod IS
    PORT(
        X, Y : IN std_logic_vector(7 downto 0);
        start: in std_logic;
        ready: OUT std_logic;
        q: OUT std_logic_vector(7 downto 0);-- Maximum quotient is X/1 = X = 8 bit!
        r: OUT std_logic_vector(7 downto 0); --maximum remaninder  is 11111110 / 1111111 = 11111110 8 bit!
        clk, RSTn: IN std_logic
    );
BEGIN
END div_mod;


ARCHITECTURE FSMD OF div_mod IS
    COMPONENT div_mod_dp IS
        PORT(
            X, Y : IN std_logic_vector(7 downto 0);
            ready: OUT std_logic;
            q: OUT std_logic_vector(7 downto 0);-- Maximum quotient is X/1 = X = 8 bit!
            r: OUT std_logic_vector(7 downto 0); --maximum remaninder  is 11111110 / 1111111 = 11111110 8 bit!
            load_x, load_y, disp, rst_count: IN std_logic; --control signals
            r_lt_y: OUT std_logic; --status signals
            clk, RSTn: IN std_logic
        );
    END COMPONENT;
    
    
    COMPONENT div_mod_fsm IS
        PORT(
            start: in std_logic;
            clk, RSTn: IN std_logic;
            rst_count, load_y, load_x, disp: OUT std_logic; --control signal
            r_lt_y: IN std_logic -- status signal
        );
    END COMPONENT;
    
    SIGNAL load_x_s, load_y_S, disp_s, rst_count_s, r_lt_y_s: std_logic;
BEGIN

    fsm: div_mod_fsm PORT MAP(start => start, clk => clk, RSTn => RSTn, rst_count => rst_count_s, load_y => load_y_s, load_x => load_x_s, disp => disp_s ,r_lt_y => r_lt_y_s);
    dp: div_mod_dp PORT MAP(X=> X, Y=>Y, ready => ready, q => q, r => r, load_x => load_x_s, load_y => load_y_s, disp => disp_s, rst_count => rst_count_s, r_lt_y => r_lt_y_s, clk => clk, RSTn => RSTn);

END FSMD;