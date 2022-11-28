LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


ENTITY edge_detector IS

    PORT(
    strobe: IN std_logic;
    clk: IN std_logic;
    RSTn: IN std_logic;
    edge: OUT std_logic
    );
BEGIN
END edge_detector;


ARCHITECTURE Mealy OF edge_detector IS --Mealy: output dependant on input and state
    TYPE StateType IS (low, high); --Could introduce "rising" and falling" to perhaps increase timing accuracy.
    Signal currstate, nextstate: StateType;
    
BEGIN


    stateRegister: PROCESS(clk, RSTn) IS
    BEGIN
        IF (RSTn = '0') THEN
            currstate <= low;
        ELSIF rising_Edge(clk) THEN
            currstate <= nextstate;
        END IF;
    END PROCESS;

    combLogic: PROCESS(currstate, strobe) IS
    BEGIN
        CASE currstate IS
        WHEN low =>
            IF (strobe = '1') THEN
                nextstate <= high;
                edge <= '1';
            ELSE
                nextstate <= low;
                edge <= '0';
            END IF;
        
        WHEN high =>       
            edge <= '0';
            IF (STROBE = '1') THEN
                nextstate <= high;
            ELSE
                nextstate <= low;
            END IF;
        END CASE;
    END PROCESS;
END Mealy;


ARCHITECTURE Moore OF edge_detector IS
    TYPE StateType IS (low, rising, high);
    SIGNAL currstate, nextstate: StateType;
BEGIN
    
    stateRegister: PROCESS(clk, RSTn) IS
    BEGIN
        IF (RSTn = '0') THEN
            currstate <= low;
        ELSIF rising_edge(clk) THEN
            currstate <= nextstate;
        END IF;
    END PROCESS; --stateRegister


    combLogic: PROCESS(currstate, strobe) IS
    BEGIN
        CASE currstate IS
        WHEN low =>
            edge <= '0';
            IF (strobe = '1') THEN
                nextstate <= rising;
            ELSE
                nextstate <= low;
            END IF;
        WHEN rising =>
            edge <= '1';
            IF (strobe ='1') THEN
                nextstate <= high;
            ELSE
                nextstate <= low;
            END IF;
        WHEN high =>
            edge <= '0';
            IF (strobe = '1') THEN
                nextstate <= high;
            ELSE
                nextstate <= low;
            END IF;
        END CASE;
    END PROCESS; --combLogic
END Moore;