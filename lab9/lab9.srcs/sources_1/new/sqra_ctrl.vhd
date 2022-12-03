LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


ENTITY sqra_ctrl IS
    PORT(
        start: IN std_logic;
        clk: IN std_logic;
        RSTn: IN std_logic;
        ready: OUT std_logic;
        r1_s, r3_s: OUT std_logic_vector(1 downto 0);
        r2_s: out std_logic_vector(2 downto 0)
    );
BEGIN 

END sqra_ctrl;



ARCHITECTURE Behav of sqra_ctrl IS
    TYPE stateType IS (S0, S1, S2, S3, S4, S5, S6);
    
    SIGNAL currState, nextState: stateType;
BEGIN

    stateReg: PROCESS(clk, RSTn)
    BEGIN
        IF RSTn = '0' THEN
            currState <= S0;
        ELSIF rising_edge(clk) THEN
            currState <= nextState;
        END IF;
    END PROCESS; --stateReg
    
    combLogic: PROCESS(currState, start)
    BEGIN
        CASE currState IS
            WHEN S0 =>
                r1_s <= "01";-- 1 on mux will be first used operation for all
                r2_s <= "001";
                r3_s <= "01";
                IF start = '1' THEN
                    nextState <= S1;
                ELSE
                    nextState <= S0;
                END IF;
            WHEN S1 =>
                nextstate <= s2;
                ready <= '0';
                r1_s <= "10";
                r2_s <= "010";
                r3_s <= "01";
            WHEN S2 =>
                nextstate <= S3;
                r1_s <= "11";
                r2_s <= "011";
                r3_s <= "01";
            WHEN S3 =>
                nextstate <= S4;
                r1_s <= "00";
                r2_s <= "100";
                r3_s <= "10";
            WHEN S4 =>
                nextstate <= S5;
                r1_s <= "00";
                r2_s <= "101";
                r3_s <= "00";
            WHEN S5 =>
                nextstate <= S6;
                r1_s <= "00";
                r2_s <= "000";
                r3_s <= "11";
            WHEN S6 =>   
                IF start = '1' THEN
                    nextState <= S1;
                ELSE
                    nextState <= S6;
                END IF;
                ready <= '1';
                r1_s <= "01";
                r2_s <= "001";
                r3_s <= "00";
            WHEN OTHERS =>
                ready <= '0';
                r1_s <= "01";
                r2_s <= "001";
                r3_s <= "01";
        END CASE;     
    END PROCESS; --combLogic;

END Behav;