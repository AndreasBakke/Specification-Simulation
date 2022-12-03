LIBRARY ieee;
USE ieee.std_logic_1164.ALL;



ENTITY multiplier_ctrl IS
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
BEGIN
END multiplier_ctrl;


ARCHITECTURE Behav OF multiplier_ctrl IS
    TYPE StateType IS (IDLE, SETUP, COMPARE, CALCULATE, DISPLAY);
    SIGNAL currState, nextState: StateType;
BEGIN
    
    stateReg: PROCESS(clk, RSTn)
    BEGIN
        IF (RSTn = '0') THEN
            currState <= IDLE;
        ELSIF rising_Edge(clk) THEN
            currState <= nextState;
        END IF; 
    END PROCESS; --stateREg

    combLogic: PROCESS(currState, start, n_eq_0)
    BEGIN
        CASE currstate IS
        WHEN IDLE =>
        -- should drive signals 
            IF start =  '1' THEN
                nextState <= SETUP;
            ELSE
                nextState <= IDLE;
            END IF;
        WHEN SETUP =>
            nextState <= COMPARE;
            ready <= '0';
            N_dec <= '0';
            N_rst <= '1'; P_rst <= '1';
            A_ld <= '1'; B_ld <= '1';
        WHEN COMPARE =>
            N_dec <= '0';
            N_rst <= '0'; P_rst <= '0';
            A_ld <= '0'; B_ld <= '0';
            IF N_eq_0 = '1' THEN
                nextState <= DISPLAY;
            ELSE
                nextState <= CALCULATE;
            END IF;
        WHEN CALCULATE =>
            N_dec <= '1';
            nextState <= COMPARE;
        WHEN DISPLAY =>
            ready <= '1';
            nextState <= IDLE;
        END CASE;
    
    END PROCESS; --combLogic
END Behav;