LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


ENTITY request_arbiter_2 IS
    PORT(
    clk: IN std_logic;
    RSTn: IN std_logic;
    req1, req0: IN std_logic;
    grant1, grant0: OUT std_logic
    );
BEGIN
END request_arbiter_2;

ARCHITECTURE Behav_pri of request_arbiter_2 IS
    Type StateType IS (waiting, closed_1, closed_0);
    signal currstate, nextstate: StateType;
BEGIN

    stateReg: PROCESS(clk, RSTn) IS
    BEGIN
        IF (RSTn ='0') THEN
            currstate <= waiting;
        ELSIF rising_Edge(clk) THEN
            currstate <= nextstate;
        END IF;
    END PROCESS; --stateReg
    
    
    combLogic: PROCESS(currstate, req1, req0) IS
    BEGIN
        CASE currstate IS
        WHEN waiting =>
            grant1 <= '0'; grant0 <= '0';
            IF req1 = '1' THEN
                nextstate <= closed_1;
            ELSIF req0 = '1' THEN
                nextstate <= closed_0;
            ELSE
                nextstate <= waiting;
            END IF;
        WHEN closed_1 =>
            grant1 <= '1'; grant0 <= '0';
            IF req1 = '1' THEN
                nextstate <= closed_1;
            ELSIF req0 = '1' THEN
                nextstate <= closed_0;
            ELSE
                nextstate <= waiting;
            END IF;
        WHEN closed_0 =>
            grant0 <= '1'; grant1 <= '0';
            IF req0 = '1' THEN
                nextstate <= closed_0;
            ELSIF req1 = '1' THEN
                nextstate <= closed_1;
            ELSE
                nextstate <= waiting;
            END IF;
        END CASE;
    END PROCESS; --combLogic
END Behav_pri;


ARCHITECTURE Behav_track OF request_arbiter_2 IS
    Type StateType IS (waiting_1, waiting_0, closed_1, closed_0);
    signal currstate, nextstate: StateType;
BEGIN

    stateReg: PROCESS(clk, RSTn) IS
    BEGIN
        IF (RSTn = '0') THEN
            currstate <= waiting_1;
        ELSIF rising_Edge(clk) THEN
            currstate <= nextstate;
        END IF;
    
    END PROCESS; --stateReg


    combLogic: PROCESS(currstate, req1, req0) IS
    BEGIN
        CASE currstate IS
        WHEN waiting_1 =>
            grant1 <= '0'; grant0 <='0'; 
            IF (req1 = '1') THEN
                nextstate <= closed_1;
            ELSIF (req0 = '1') THEN
                nextstate <= closed_0;
            ELSE
                nextstate <= waiting_1;
            END IF;
        WHEN waiting_0 =>
            grant1 <= '0'; grant0 <='0'; 
            IF (req0 = '1') THEN
                nextstate <= closed_0;
            ELSIF (req1 = '1') THEN
                nextstate <= closed_1;
            ELSE
                nextstate <= waiting_0;
            END IF;
        WHEN closed_1 =>
            grant1 <= '1'; grant0 <= '0';
            IF (req1 ='1') THEN
                nextstate <= closed_1;
            ELSIF req0 = '1' THEN
                nextstate <= closed_0;
            ELSE
                nextstate <= waiting_0; --give next priority to 0;
            END IF;
        WHEN closed_0 =>
            grant0 <= '1'; grant1 <= '0';
            IF (req0 = '1') THEN
                nextstate <= closed_0;
            ELSIF req1 = '1' THEN
                nextstate <= closed_1;
            ELSE
                nextstate <= waiting_1; --give next priority to 1;
            END IF;
        END CASE;
    
    END PROCESS; --combLogic
END Behav_track;

