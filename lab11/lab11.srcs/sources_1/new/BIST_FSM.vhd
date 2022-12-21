LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY BIST_FSM IS
    PORT(
    go: IN std_logic;
    z_eq_0, z_eq_1, cnt_lt_256: IN std_logic; --status signals
    cnt_inc, cnt_rst, clr, set_x, set_A, rw: OUT std_logic; -- control signals clr connectecd to RAM
    x: OUT std_logic_vector(15 downto 0);
    fin: out std_logic;
    clk, Rst: IN std_logic --Clock and async active high reset
    );
BEGIN

END BIST_FSM;



ARCHITECTURE Behav of BIST_FSM IS
    TYPE StateType IS (IDLE, INIT_0, INIT_1, VER_0, VER_1, READ_0, READ_1, WRITE, FAULT, FINISHED);
    SIGNAL currState, nextState: StateType;
    
BEGIN
    stateReg: PROCESS(clk, Rst)
    BEGIN
        IF Rst = '1' THEN
            currState <= IDLE;
        ELSIF rising_Edge(clk) THEN
            currState <= nextState;
        END IF;
    END PROCESS; --stateReg


    combLogic: PROCESS(currState, go,z_eq_0, z_eq_1, cnt_lt_256)
    BEGIN
    
        CASE currState IS
        WHEN IDLE =>
            set_A <= '0'; --sets A to Z
            set_x <= '0'; --sets X to Z
            cnt_rst <= '1'; cnt_inc <= '0'; rw <= '0';
            IF go = '1' THEN
                nextState <= INIT_0;
            ELSE
                nextState <= IDLE;
            END IF;
        WHEN INIT_0 =>
            fin <= '0'; clr <= '1';
            set_x <= '1'; set_a <= '1';
            nextState <= VER_0;
            cnt_rst <= '1';
            
        WHEN INIT_1 =>
            rw <= '0';
            cnt_rst <= '1';
            nextState <= VER_1;
            
        WHEN VER_0 =>
            cnt_inc <= '0'; cnt_rst <= '0'; clr <= '0';
            rw <= '0';
            IF  cnt_lt_256 = '1' THEN
                nextState <= INIT_1; --Start reading 1s
            ELSE
                nextState <= READ_0;
            END IF;      
              
        WHEN VER_1 =>
            IF cnt_lt_256 = '1' THEN
                nextSTate <= FINISHED;
            ELSE    
                nextState <= READ_1;       
            END IF;
            cnt_rst <= '0';
            cnt_inc <= '0';
        WHEN READ_0 =>
            IF NOT Z_eq_0 = '1' THEN
                nextState <= FAULT;
            ELSE
                nextState <= WRITE;
            END IF;
            cnt_inc <= '0';

        WHEN READ_1 =>
            cnt_inc <= '1';
            IF  Z_eq_1 = '1' THEN
                nextState <= VER_1;
            ELSE
                nextState <= FAULT;
            END IF;
            
        WHEN WRITE =>
            rw <= '1';
            cnt_inc <= '1';
            nextState <= VER_0;
        WHEN FAULT =>
            nextState <= FAULT;
        WHEN FINISHED =>
            fin <= '1';
            nextState <= IDLE;
        END CASE;
    END PROCESS; --combLogic
END BEHAV;