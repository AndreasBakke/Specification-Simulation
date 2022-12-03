LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY multiplier_dp IS
    PORT(
    A, B: IN std_logic_vector(7 downto 0);
    a_ld, b_ld: IN std_logic; --register load signals
    N_dec, N_rst: IN std_logic;
    N_eq_0: OUT std_logic;
    P_rst: IN std_logic;
    clk: IN std_logic;
    ready: IN std_logic;
    res: OUT std_logic_vector(15 downto 0)
    );
BEGIN

END multiplier_dp;


ARCHITECTURE Behav of multiplier_dp IS


    SIGNAL b_reg, b_regNext: std_logic_vector(7 downto 0);
    SIGNAL a_reg, a_regNext: std_logic_vector(15 downto 0);
    SIGNAL P, p_next: unsigned(15 downto 0);
    SIGNAL N, N_next: unsigned(3 downto 0);
    SIGNAL a_shift, b_shift: std_logic;
    SIGNAL n_eq_0_internal: std_logic;
BEGIN
    
    regUpdate: PROCESS(clk)
    BEGIN
        IF rising_edge(clk) THEN
            N <= N_next;
            P <= P_next;
            a_reg <= a_regNext;
            b_reg <= b_regNext;
            
            
            
        END IF;
        
    END PROCESS; --regUpdate
    
    
    
    combLogic: PROCESS(a_reg, b_reg, P, N, N_dec, N_rst, P_rst, a_ld, b_ld, a_shift, b_shift, ready)
    BEGIN
        ---- Standard combinatorial logic ----
        a_shift <= (NOT N_eq_0_internal) AND N_dec; --Should only shift while we are decrementing and N is not 0!
        b_shift <= (NOT N_eq_0_internal) AND N_Dec;
        -- A AND B register:
        IF a_ld = '1' THEN
            a_regNext <= std_logic_vector(resize(unsigned(A), 16));
        ELSIF a_shift = '1' THEN
            a_regNext(15 downto 1) <= a_reg(14 downto 0);
            a_regNext(0) <= '0';
        ELSE
            a_regNext <= A_reg;
        END IF;
        
        IF b_ld = '1' THEN
            b_regNExt <= B;
        ELSIF b_shift = '1' THEN
        --shift b
            b_regNext(6 downto 0) <= b_reg(7 downto 1);
            b_regNext(7) <= '0';
        ELSE
            b_regNExt <= B_reg;
        END IF;
        
        
        
        --- DRIVE N
        IF (N_dec AND NOT n_eq_0_internal) = '1' THEN --Stop decrementing if we have reached 0
            N_next <= N-1;
        ELSIF n_rst = '1' THEN
            N_next <= "1000";
        ELSE
            n_next <= N;
        END IF;
        
        --DRIVE P
        IF( b_reg(0) AND N_dec) = '1' THEN --USE N_dec as a sort of verifing that we are in state CALCULATE
            P_next <= P + unsigned(a_reg);
        ELSIF P_rst = '1' THEN
            P_next <= (OTHERS => '0');
        ELSE
            P_next <= P;
        END IF;
        
        ---N EQ signal
        IF N=0 THEN
            n_eq_0_internal <= '1';
        ELSE
            n_eq_0_internal <= '0';
        END IF;
        n_eq_0 <= n_eq_0_internal;
        
        
        
        IF ready = '1' THEN
                res <= std_logic_vector(P);
            ELSE
                res <= (OTHERS =>  'Z');
            END IF;
    END PROCESS; --combLogic;


END Behav;