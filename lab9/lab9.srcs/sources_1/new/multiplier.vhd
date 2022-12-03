LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;



ENTITY multiplier IS --squential add multiplier
    PORT(
        A, B: IN std_logic_vector(7 downto 0);
        start:IN std_logic;
        res:    OUT std_logic_vector(15 downto 0);
        ready: OUT std_logic;
        clk: IN std_logic;
        RSTn: IN std_logic
    );
BEGIN

END multiplier;


ARCHITECTURE HLSM OF multiplier IS
    TYPE StateType IS (IDLE, SETUP, COMPARE, CALCULATE, DISPLAY);
    SIGNAL currState, nextState: StateType;
    signal outputRegister, a_reg: std_logic_vector(15 downto 0);
    signal b_reg: std_logic_vector(7 downto 0);
    SIGNAL P: unsigned(15 downto 0);
    SIGNAL N: unsigned(3 downto 0);

BEGIN
    stateReg: PROCESS(clk, RSTn)
    BEGIN
        IF RSTn = '0' THEN
            currstate <= IDLE;
        ELSIF rising_edge(clk) THEN
            currstate <= nextstate;
        END IF;
        
    END PROCESS; --stateReg
    
    comblogic: PROCESS(currState, A, B, start)
    BEGIN
        CASE currState IS
        WHEN IDLE =>
            IF start = '1' THEN
                nextState <= SETUP;
            ELSE
                nextState <= IDLE;
            END IF;
        WHEN SETUP =>
            a_reg <= std_logic_vector(resize(unsigned(A), 16));
            b_reg <= B;
            outputRegister <= (OTHERS => '0');
            ready <= '0';
            P <= (Others => '0');
            N <= "1000";
            nextState <= COMPARE;
        WHEN COMPARE =>
            IF N<=0 THEN
                nextState <= DISPLAY;
            ELSE
                nextState <= CALCULATE;
            END IF;
        WHEN CALCULATE =>
            IF b_reg(0) = '1' THEN
                P <= P + to_integer(unsigned(a_reg));
            END IF;
            --shift a
            a_reg(15 downto 1) <= a_reg(14 downto 0);
            a_reg(0) <= '0';
            --shift b
            b_reg(6 downto 0) <= b_reg(7 downto 1);
            b_reg(7) <= '0';

            N <= N-1;
            nextState <= COMPARE;
        WHEN DISPLAY =>
            ready <= '1';
            outputRegister <= std_logic_vector(P);
            nextState <= IDLE;
        END CASE;
    END PROCESS; --combLogic;
    res <= outputRegister;
END HLSM;




ARCHITECTURE FSM_D OF multiplier IS
    COMPONENT multiplier_dp IS
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
    END COMPONENT;
    
    COMPONENT multiplier_ctrl IS
        PORT(
            start: IN std_logic;
            a_ld, b_ld: OUT std_logic;
            N_eq_0: IN std_logic;
            N_dec, N_rst: OUT std_logic;
            P_rst: OUT std_logic;
            ready: OUT std_logic;
            clk: IN std_logic;
            RSTn: IN std_logic
        );
    END COMPONENT;

    ---INTERCONNECT SIGNALS
    SIGNAL ready_s, a_ld, b_ld, N_dec, N_rst, P_rst, N_eq_0: std_logic;
    
BEGIN
    ready <= ready_s;
    datapath: multiplier_dp PORT MAP(A => A, B => B, ready => ready_s, res => res, clk => clk, a_ld => a_ld, b_ld => b_ld, N_dec => N_dec, N_rst => N_rst, P_rst => P_rst, n_eq_0 => n_eq_0);
    controller: multiplier_ctrl PORT MAP(start => start, a_ld => a_ld, b_ld => b_ld, N_eq_0 => n_eq_0, N_dec => N_dec, N_rst => N_rst, P_rst => P_rst, ready => ready_s, clk => clk, RSTn => RSTn);
END FSM_D;