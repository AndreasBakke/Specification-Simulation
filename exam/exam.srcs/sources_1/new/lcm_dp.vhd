LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL; --unsigned data-typ

ENTITY lcm_dp IS
    PORT(
        clk, RSTn: IN std_logic; 
        a, b : IN std_logic_vector(7 downto 0); --Data signals in
        ready: OUT std_logic; --data signal out
        lcm: OUT std_logic_vector(15 downto 0); --data signal out
        a_lt_b, b_lt_a, a_eq_b: OUT std_logic; --status signals
        load_a, load_b, add_a, add_b: IN std_logic --control signals
    );
    
BEGIN
END lcm_dp;



ARCHITECTURE Behav OF lcm_dp IS
    SIGNAL A_reg, A_next, B_reg, B_next : std_logic_vector(15 downto 0);
    signal m,n: unsigned (15 downto 0);
BEGIN

    stateRegs: PROCESS(clk, RSTn) BEGIN
        IF(RSTn= '0') THEN
            A_reg <= (OTHERS => '0');
            B_reg <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            A_reg <= A_next;
            B_Reg <= B_next;
        END IF;
    END PROCESS; --stateRegs
    
    
    combLogic: PROCESS(a,b,load_a,load_b,add_a,add_b, A_reg, B_reg)
    BEGIN
        --A_reg:
        IF(load_a = '1') THEN
            A_next <= X"00" & a; m <= X"00" & unsigned(a);
        ELSIF(add_a = '1') THEN
            A_next <= std_logic_vector(unsigned(A_reg) +m);
        ELSE
            A_next <= A_reg;
        END IF;
        
        --B_reg:
        IF(load_b = '1') THEN
            B_next <= X"00" & b; n <= X"00" & unsigned(b);
        ELSIF(add_b = '1') THEN
            B_next <= std_logic_vector(unsigned(B_reg) +n);
        ELSE
            B_next <= B_reg;
        END IF;
        
        lcm <= A_reg;
        
        --Status signals
        IF(unsigned(A_reg) < unsigned(B_Reg)) THEN
            a_lt_b <= '1';
        ELSE
            a_lt_b <= '0';
        END IF;
        
        IF(unsigned(A_reg)> unsigned(B_reg)) THEN
            b_lt_a <= '1';
        ELSE
            b_lt_a <= '0';
        END IF;
        
        IF(unsigned(A_reg) = unsigned(B_Reg)) THEN
            a_eq_b <= '1'; ready <= '1';
        ELSE
            a_eq_b <= '0'; ready <= '0';
        END IF;
    END PROCESS; --CombLogic
END Behav;