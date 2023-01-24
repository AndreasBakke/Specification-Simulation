LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY lcm IS
    PORT(
        a, b : IN std_logic_vector(7 downto 0);
        lcm: OUT std_logic_vector(15 downto 0);
        start, clk, RSTn: IN std_logic; --async active low reset
        ready: OUT std_logic
    );
BEGIN
END lcm;


ARCHITECTURE HLSM of LCM IS
    TYPE StateType IS(IDLE, SETUP, DECIDE, ADD_A, ADD_B, DISPLAY);
    SIGNAL currState, nextState: StateType;
    SIGNAL a_reg, b_reg, a_reg_next, b_reg_next: unsigned(15 downto 0) := (OTHERS => '0');

BEGIN
    stateReg: Process(clk, RSTn) BEGIN
        IF(RSTn = '0') THEN
            currState <= IDLE;
        ELSIF rising_edge(clk) THEN
            currState <= Nextstate;
            a_reg <= a_reg_next;
            b_reg <= b_reg_next;
        END IF;
    END PROCESS; --StateReg
    
    logic: PROCESS(a,b, a_reg, b_reg, a_reg_next, b_reg_next, start, currstate)
        variable n,m : unsigned(15 downto 0) := (OTHERS => '0');
    BEGIN
        CASE(currState) IS
            WHEN IDLE =>
                IF(start = '1') THEN
                    nextState <= SETUP;
                ELSE
                    nextState <= IDLE;
                END IF;
                ready <= '0';
            WHEN SETUP =>
                a_reg_next <= X"00" & unsigned(a);
                b_reg_next <= X"00" & unsigned(b);
                m:= X"00" & unsigned(a);
                n:= X"00" & unsigned(b);
                nextState <= DECIDE;
            WHEN DECIDE =>
                IF(a_reg_next = b_reg_next) THEN
                    nextState <= DISPLAY;
                ELSIF (a_reg_next < b_reg_next) THEN
                    nextState <= ADD_A;
                ELSIF (b_reg_next < a_reg_next) THEN
                    nextState <= ADD_B;
                ELSE
                    nextState <= IDLE; --go back to idle if we have erros. (Could also stay at setup)
                END IF;
            WHEN ADD_A =>
                a_reg_next <= a_reg + m;
                IF(a_reg_next = b_reg_next) THEN
                    nextState <= DISPLAY;
                ELSIF (a_reg_next < b_reg_next) THEN
                    nextState <= ADD_A;
                ELSIF (b_reg_next < a_reg_next) THEN
                    nextState <= ADD_B;
                ELSE
                    nextState <= IDLE; --go back to idle if we have erros. (Could also stay at setup)
                END IF;
            WHEN ADD_B =>
                b_reg_next <= b_reg +n;
                IF(a_reg_next = b_reg_next) THEN
                    nextState <= DISPLAY;
                ELSIF (a_reg_next < b_reg_next) THEN
                    nextState <= ADD_A;
                ELSIF (b_reg_next < a_reg_next) THEN
                    nextState <= ADD_B;
                ELSE
                    nextState <= IDLE; --go back to idle if we have erros. (Could also stay at setup)
                END IF;
            WHEN DISPLAY =>
                ready <= '1';
                nextState <= IDLE;
        END CASE;
        lcm <= std_logic_vector(a_reg);
    END PROCESS; --logic

END HLSM;





ARCHITECTURE struct OF lcm IS
    COMPONENT lcm_FSM IS
        PORT(
            clk, RSTn : IN std_logic;
            load_a, load_b, add_a, add_b: OUT std_logic; --control signals
            a_lt_b, b_lt_a, a_eq_b: IN std_logic; --status signals
            start: IN std_logic
        );
    END COMPONENT;
    
    COMPONENT lcm_dp IS
        PORT(
            clk, RSTn: IN std_logic; 
            a, b : IN std_logic_vector(7 downto 0); --Data signals in
            ready: OUT std_logic; --data signal out
            lcm: OUT std_logic_vector(15 downto 0); --data signal out
            a_lt_b, b_lt_a, a_eq_b: OUT std_logic; --status signals
            load_a, load_b, add_a, add_b: IN std_logic --control signals
        );
    END COMPONENT;
    
    SIGNAL  a_lt_b, b_lt_a, a_eq_b, load_a, load_b, add_a, add_b: std_logic;
BEGIN 

    fsm: lcm_FSM PORT MAP(clk => clk, RSTn => RSTn,
                          load_a => load_a, load_b => load_b, add_a => add_a, add_b => add_b,
                          a_lt_b => a_lt_b, b_lt_a => b_lt_a, a_eq_b => a_eq_b,
                          start => start
                        );
    dp: lcm_dp PORT MAP( clk => clk, RSTn => RSTn,
                         a => a, b => b,
                         ready => ready,
                         lcm => lcm,
                         load_a => load_a, load_b => load_b, add_a => add_a, add_b => add_b,
                          a_lt_b => a_lt_b, b_lt_a => b_lt_a, a_eq_b => a_eq_b
                        );
    
    


END struct;