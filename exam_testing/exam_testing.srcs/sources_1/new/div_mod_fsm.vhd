Library ieee;
USE ieee.std_logic_1164.ALL;


ENTITY div_mod_fsm IS
    PORT(
        start: in std_logic;
        clk, RSTn: IN std_logic;
        rst_count, load_y, load_x, disp: OUT std_logic; --control signal
        r_lt_y: IN std_logic -- status signal
    );
BEGIN
END div_mod_fsm;



ARCHITECTURE Behav OF div_mod_fsm IS
    TYPE StateType IS (IDLE, SETUP, CALCULATE, DISPLAY);
    SIGNAL currState, nextState: StateType;
BEGIN

    stateReg: process(clk, rstn) IS
    BEGIN
        IF(rstn = '0') THEN
            currState <=  IDLE;
        ELSIF rising_edge(clk) THEN
            currState <= nextState;
        END IF;  
    END PROCESS; --stateREg;

    combLogic: PROCESS(r_lt_y, start, currState) IS
    BEGIN
        CASE(currState) IS
            WHEN IDLE =>
                load_y <= '0'; load_x <= '0'; disp <= '0'; rst_count <= '0';
                IF start = '1' THEN
                    nextState <= SETUP;
                ELSE 
                    nextState <= IDLE;
                END IF;
            WHEN SETUP =>
                load_y <= '1'; load_x <= '1'; disp <= '0'; rst_count <= '1';
                nextState <= CALCULATE;
            WHEN CALCULATE =>
                load_y <= '0'; load_x <= '0'; disp <= '0'; rst_count <= '0';
                IF r_lt_y = '1' THEN
                    nextState <= DISPLAY;
                ELSE
                    nextState <= IDLE;
                END IF;
            WHEN DISPLAY =>
                load_y <= '0'; load_x <= '0'; disp <= '1'; rst_count <= '0';
                nextState <= IDLE;
        END CASE;
    
    END PROCESS; --combLogic;
END Behav;