Library ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY div_mod_dp IS
    PORT(
        X, Y : IN std_logic_vector(7 downto 0);
        ready: OUT std_logic;
        q: OUT std_logic_vector(7 downto 0);-- Maximum quotient is X/1 = X = 8 bit!
        r: OUT std_logic_vector(7 downto 0); --maximum remaninder  is 11111110 / 1111111 = 11111110 8 bit!
        load_x, load_y, disp, rst_count: IN std_logic; --control signals
        r_lt_y: OUT std_logic; --status signals
        clk, RSTn: IN std_logic
    );
BEGIN
END div_mod_dp;



ARCHITECTURE Behav OF div_mod_dp IS
    SIGNAL y_reg, r_reg: std_logic_vector(7 downto 0);
    SIGNAL y_reg_next, r_reg_next: std_logic_vector(7 downto 0);
    SIGNAL r_subbed: std_logic_vector(7 downto 0);
    signal r_lt_y_sig: std_logic;
    SIGNAL count_reg, count_reg_next: std_logic_vector (7 downto 0);
BEGIN

    registers: PROCESS(clk, RSTn) IS
    BEGIN
        IF( RSTn = '0') THEN
            y_reg <= (OThers => '0');
            r_reg <= (Others => '0');
            count_Reg <= (Others => '0');
        ELSIF rising_edge(clk) THEN
            y_reg <= y_reg_next;
            r_reg <= r_reg_next;
            count_reg <= count_reg_next;
        END IF;
    END PROCESS; --registers
    
    combLogic: PROCESS(X, Y, load_x, load_y, disp, y_reg, r_reg) 
    BEGIN
       -- y_reg_next <= Y when load_y='1' else y_reg;
        IF (load_y = '1') THEN
            y_reg_next <= Y;
        ELSE
            y_reg_next <= y_reg;
        END IF;
        
        --R_reg
        IF load_x = '1' THEN
            r_reg_next <= X;
        ELSE
            r_reg_next <=  r_subbed;
        END IF;
        
        
        IF (unsigned(r_reg) < unsigned(y_reg)) THEN
            r_lt_y_sig <= '1';
        ELSE
            r_lt_y_sig <= '0';
        END IF;
        
       r_subbed <=  std_logic_vector(unsigned(r_reg) - unsigned(Y_reg));
       
       --COUNTER
        IF (rst_count = '1') THEN
            count_reg_next <= (OThers => '0');
        ELSIF ( NOT r_lt_y_sig = '1' ) THEN
            count_reg_next <= std_logic_vector(unsigned(count_reg) +1);
        ELSE
            count_reg_next <= count_reg;
        END IF;
       
       
       q <= count_reg;
       ready <= (r_lt_y_sig AND disp );
       r_lt_y <= r_lt_y_sig;
       r <= r_reg;
    END PROCESS; --registers
END Behav;