--TASK 2

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mealy_fsm IS
    PORT(
    UpDw: IN std_logic;
    count: OUT std_logic_vector(3 DOWNTO 0);
    clk, RSTn: IN std_logic
    );
BEGIN
END mealy_fsm;



ARCHITECTURE Behav of mealy_fsm IS
    TYPE StateType IS (S0, S1, S2, S3);
    signal currstate, nextstate: StateType;
BEGIN
    StateReg: PROCESS(clk, RSTn)
    BEGIN
        IF RSTn = '0' THEN
        currstate <= s0;
        ELSIF rising_edge(clk) THEN
            currstate <= nextstate;
        END IF;
    END PROCESS;

    CombLogic: PROCESS(currstate, UpDw)
    BEGIN
    CASE currstate IS
    WHEN S0 =>
        IF UpDw = '0' THEN
            count <= "0001";
            nextstate <= S3;
        ELSE
            count <= "0100";
            nextstate <= S1;
        END IF;
    WHEN S1 =>
        IF UpDw = '0' THEN
            count <= "1000";
            nextstate <= S0;
        ELSE
            count <= "0010";
            nextstate <= S2;
        END IF;
    WHEN S2 =>
        IF UpDw = '0' THEN
            count <= "0100";
            nextstate <= S1;
        ELSE
            count <= "0001";
            nextstate <= S3;
        END IF;
    WHEN S3 =>
        IF UpDw = '0' THEN
            count <= "0010";
            nextstate <= S2;
        ELSE
            count <= "1000";
            nextstate <= S0;
        END IF;
    END CASE;
    END PROCESS;

END Behav;