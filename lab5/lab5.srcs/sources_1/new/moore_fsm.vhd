--Task 1
LIBRARY ieee;
use ieee.std_logic_1164.ALL;

ENTITY moore_fsm IS
    PORT(
    P, Clk, RSTn: IN std_logic;
    R: OUT std_logic
    );

BEGIN
END moore_fsm;


ARCHITECTURE Behav_2pro OF moore_fsm IS
    TYPE Statetype IS
    (A, B, C, D);
    SIGNAL currstate, nextstate: Statetype;
BEGIN

    StateReg: PROCESS(clk, RSTn)
    BEGIN
        IF RSTn = '0' THEN
            currstate <= A;
        ELSIF rising_edge(clk) THEN
            currstate <= nextstate;
        END IF;
    END PROCESS;
    
    CombLogic: PROCESS(currstate, P) --if state or input changes, compute next state and output.
    BEGIN
    CASE currstate IS
        WHEN A =>
            R <= '0';
            IF P = '1' THEN
            nextstate <= B;
            ELSE
            nextstate <= A;
            END IF;
        WHEN B =>
            R <= '0';
            IF P = '1' THEN
            nextstate <= C;
            ELSE
            nextstate <= B;
            END IF;
        WHEN C =>
            R <= '0';
            IF P = '1' THEN
            nextstate <= D;
            ELSE
            nextstate <= C;
            END IF;
        WHEN D =>
            R <= '1';
            IF P = '1' THEN
            nextstate <= C;
            ELSE
            nextstate <= A;
            END IF;
        WHEN OTHERS =>
            R <= 'Z';
            nextstate <= A;
    
    END CASE;
    
    END PROCESS;

END Behav_2pro;



ARCHITECTURE Behav_1pro OF moore_fsm IS --OBS FUNKER IKKE
    TYPE Statetype IS
    (A, B, C, D);
    SIGNAL currstate, nextstate: Statetype;
BEGIN
    statemachine: PROCESS(clk, RSTn, currstate, P)
    BEGIN
    IF RSTn = '0' THEN
        currstate <= A;
    ELSIF rising_edge(clk) THEN
        currstate <= nextstate;
    ELSE
        CASE currstate IS
            WHEN A =>
                R <= '0';
                IF P = '1' THEN
                nextstate <= B;
                ELSE
                nextstate <= A;
                END IF;
            WHEN B =>
                R <= '0';
                IF P = '1' THEN
                nextstate <= C;
                ELSE
                nextstate <= B;
                END IF;
            WHEN C =>
                R <= '0';
                IF P = '1' THEN
                nextstate <= D;
                ELSE
                nextstate <= C;
                END IF;
            WHEN D =>
                R <= '1';
                IF P = '1' THEN
                nextstate <= C;
                ELSE
                nextstate <= A;
                END IF;
            WHEN OTHERS =>
                R <= 'Z';
                nextstate <= A;
        END CASE;
    END IF;
    
    
    END PROCESS;

END Behav_1pro;