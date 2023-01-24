LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY gate_controller IS
    PORT(
        F, B, OK: IN std_logic; -- status signals
        TL: OUT std_logic_vector(1 downto 0); --control signal
        clk, RSTn : IN std_logic  --assuming asynch active low reset
    );
BEGIN
END gate_controller;


ARCHITECTURE Behav OF gate_controller IS
    TYPE StateType IS (IDLE, READ, GATEOPEN, CROSSING); --OPEN state renamed as "OPEN" is a reserved VHDL statement
    SIGNAL currState, nextState: StateType;
BEGIN

    stateReg: PROCESS(clk, RSTn) BEGIN
        IF(RSTn = '0') THEN
            currState <= IDLE;
        ELSIF rising_edge(clk) THEN
            currState <= nextState;
        END IF;
    END PROCESS; --stateReg
    
    
    combLogic: PROCESS(currState, F, B, OK) BEGIN
        CASE(currState) IS
            WHEN IDLE =>
                IF(F='1') THEN --Reordered IF statement to be better. IF this was ment to be a combinational circuit my forgetting of "else" would force sequential logic
                    nextState<= READ;
                    TL <= "10";
                ELSE
                    nextState <= IDLE;
                    TL <= "00";
                END IF;
            WHEN READ =>
                IF(OK = '1') THEN --Plate read successfull
                    nextState <= GATEOPEN;
                    TL <= "01";
                ELSE
                    nextState <= READ;
                    TL <= "10";
                END IF;
            WHEN GATEOPEN =>
                IF(F='0') THEN --Car has passed front sensor
                    nextState <= CROSSING;
                    TL <= "10";
                ELSE
                    nextState <= GATEOPEN;
                    TL <= "01"; -- Keep light green until the car is away from the front sensor
                END IF;
            WHEN CROSSING =>
                IF (B='1') THEN --Car has successfully crossed gate
                    nextState <= IDLE;
                    TL <= "00"; --turn of light
                ELSE
                    nextState <= CROSSING;
                    TL <= "10";
                END IF;
        END CASE;
    END PROCESS; --combLogic
END BEhav;