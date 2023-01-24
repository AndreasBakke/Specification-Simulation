LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


ENTITY lcm_FSM IS
    PORT(
        clk, RSTn : IN std_logic;
        load_a, load_b, add_a, add_b: OUT std_logic; --control signals
        a_lt_b, b_lt_a, a_eq_b: IN std_logic; --status signals
        start: IN std_logic
    );
BEGIN
END lcm_FSM;


ARCHITECTURE Behav OF lcm_FSM IS
    TYPE StateType IS (IDLE, SETUP, DECIDE, A_ADD, B_ADD, DISPLAY); -- Renamed states to A_ADD, B_ADD to resolve conflict with add_a and add_b signals
    SIGNAL currState, nextState: StateType;
BEGIN

    stateReg: PROCESS(clk, RSTn) BEGIN
        IF (RSTn = '0') THEN
            currState <= IDLE;
        ELSIF rising_edge(clk) THEN
            currState <= nextState;
        END IF;
    END PROCESS; --stateReg
    
    combLogic: PROCESS(start, a_lt_b, b_lt_a, a_eq_b, currState)
    BEGIN
        CASE(currState) IS
            WHEN IDLE =>
                load_a <= '0'; load_b <= '0'; add_a <= '0'; add_b <= '0';
                IF(start = '1') THEN
                    nextState <= SETUP;
                ELSE
                    nextState <= IDLE;
                END IF;
            WHEN SETUP =>
                load_a <= '1'; load_b <= '1'; add_a <= '0'; add_b <= '0';
                 nextState <= DECIDE;
            WHEN DECIDE =>
                load_a <= '0'; load_b <= '0'; add_a <= '0'; add_b <= '0';
                 IF(a_lt_b = '1') THEN
                    nextState <= A_ADD;
                 ELSIF(b_lt_a = '1') THEN
                    nextState <= B_ADD;
                 ELSIF (a_eq_b = '1') tHEN
                    nextState <= DISPLAY;
                 ELSE
                    nextState <= DECIDE;               
                 END IF;
            WHEN A_ADD =>
                load_a <= '0'; load_b <= '0'; add_a <= '1'; add_b <= '0';
                 IF(a_lt_b = '1') THEN
                    nextState <= A_ADD;
                 ELSIF(b_lt_a = '1') THEN
                    nextState <= B_ADD;
                 ELSIF (a_eq_b = '1') tHEN
                    nextState <= DISPLAY;
                 ELSE
                    nextState <= DECIDE;
                 END IF;
            WHEN B_ADD =>
                load_a <= '0'; load_b <= '0'; add_a <= '0'; add_b <= '1';
                 IF(a_lt_b = '1') THEN
                    nextState <= A_ADD;
                 ELSIF(b_lt_a = '1') THEN
                    nextState <= B_ADD;
                 ELSIF (a_eq_b = '1') tHEN
                    nextState <= DISPLAY;
                 ELSE
                    nextState <= DECIDE;
                 END IF;
            WHEN DISPLAY =>
                load_a <= '0'; load_b <= '0'; add_a <= '0'; add_b <= '0';
                nextState <= IDLE; --ready assign in datapath so just use 1 clock cycle to display
        END CASE;
    END PROCESS; --combLogic
END Behav;