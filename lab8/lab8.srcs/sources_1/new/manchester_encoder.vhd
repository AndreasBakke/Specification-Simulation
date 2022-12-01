LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY manchester_encoder IS --Using IEEE 802.3 convention of high-low for 0, low-high for 1.

    PORT(
    data, valid: IN std_logic;
    clk, RSTn: IN std_logic;
    output: OUT std_logic
    );

BEGIN
END manchester_encoder;



ARCHITECTURE Behav OF manchester_encoder IS

--Is not affected by mid-cycle switches of data, will finish encoding of bit present at beginning.

TYPE StateType IS (IDLE, LOW0, HIGH0, LOW1, HIGH1);
    Signal currState, nextState: StateType;
    
BEGIN

    stateRegister: PROCESS(clk, RSTn) IS
    BEGIN
        IF RSTn = '0' THEN
            currState <= IDLE;
        ELSIF rising_edge(clk) THEN
            currState <= nextstate;
        END IF;
    END PROCESS; --stateRegister


    combLogic: PROCESS(currState, data, valid) IS
    BEGIN
        IF  valid = '0' THEN
            nextstate <= IDLE;
        ELSE --as per specifications if valid = Z we should still transmit (stupid)
            CASE currState IS
            WHEN IDLE =>
                output <= '0';           
                IF data = '1' THEN
                    nextState <= LOW1;
                ELSIF data = '0' THEN
                    nextSTATE <= HIGH0;
                END IF; 
            WHEN HIGH0 => 
                output <= '1';
                nextState <= LOW0;
            WHEN LOW0 => 
                output <= '0';
                IF data = '0' THEN
                    nextState <= HIGH0;
                ELSIF data = '1' THEN
                    nextState <= LOW1;
                END IF;
            
            WHEN LOW1 =>
                output <= '0';
                nextState <= HIGH1;
            WHEN HIGH1 =>
                output <= '1';
                IF data = '0' THEN
                    nextState <= HIGH0;
                ELSIF data = '1' THEN
                    nextState <= LOW1;
                END IF;
            WHEN OTHERS => --if entering illegal state
                output <= '0';
                nextState <= IDLE;
            END CASE;
           
        END IF;
    END PROCESS; --combLogic;


END Behav;