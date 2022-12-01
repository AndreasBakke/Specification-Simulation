LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY programmable_osp_gen IS
    PORT(
        go, stop: IN std_logic;
        output: OUT std_logic;
        clk: IN std_logic
        );
BEGIN
END programmable_osp_gen;


ARCHITECTURE HLSM OF programmable_osp_gen IS
    TYPE StateType IS (S0, S1, S2, L0, L1);
    SIGNAL stateReg: StateType;
    SIGNAL target: std_logic_vector (2 downto 0);
BEGIN

    one_procsess: PROCESS(clk)
    variable i,l: integer;
    BEGIN
        IF rising_edge(clk) THEN
            IF (stop = '1' AND NOT go = '1' ) THEN
                stateReg <= S0;
                target <= "000";
                --output <= '0';
             ELSE
             CASE stateReg IS
             WHEN S0 =>
               -- output <= '0';
               
                IF ((go AND NOT stop) = '1') THEN
                    stateReg <= S1;
                ELSIF ((go AND stop)='1') THEN
                    stateReg <= L0;
                --ELSE
                --    stateReg <= S0;
                END IF;
             WHEN L0 =>
                target <= (Others => '0');
                i := 0;
                stateReg <= L1;
             WHEN L1 =>
                IF i<=2 THEN
                    stateReg <= L1;
                    target(i) <= go;
                    i := i +1;
                ELSE
                    stateReg <= S0;
                END IF;
             WHEN S1 =>
                l:=0;
                stateReg <= S2;
             WHEN S2 =>
                --output <= '1';
                l:=l+1;
                IF (stop = '1') THEN
                    stateReg <= S0;
                ELSIF (l<unsigned(target)) THEN
                    stateReg <= S2;
                ELSE
                    stateReg <= S0;
                END IF;
             WHEN OTHERS =>
                stateReg <= S0;
                --output <= '0';
             END CASE;
             END IF;
        
        END IF;
        
    END PROCESS;
    
    
    outputPro: PROCESS(stateReg)
    BEGIN
    IF stateReg = S2 THEN
            output <= '1';
         ELSE
            output <= '0';
         END IF;
    END PROCESS;
END HLSM;



ARCHITECTURE CtrlDpBeh OF programmable_osp_gen IS
    --DATAPATH SIGNALS
    
    signal t_load: std_logic;
    signal curr_i, next_i : std_logic_vector(1 downto 0);
    signal curr_target, next_target, curr_l, next_l: std_logic_vector(2 downto 0);
    --CONTROLLER STATE SIGNALS
    TYPE stateType IS (S0, S1, S2, L0, L1);   
    signal currState, nextState: stateType;
        
    --SHARED SIGNALS
    signal  l_clr, l_inc, i_clr, i_inc, t_clr: std_logic;
    signal i_lt_3, l_lt_t, a_pulse: std_logic;

BEGIN

    ------ DATA PATH PROCESSES -------
    DpStateReg: PROCESS(clk) IS
   
    BEGIN
         
        IF rising_edge(clk) THEN
            --- i register ---
            IF (i_clr = '1') THEN
                curr_i <= (Others => '0');
            ELSE
                curr_i <= next_i;
            END IF;
            
            --- l register ---
            IF (l_clr = '1') THEN
                curr_l <= (OTHERS => '0');
            ELSE
                curr_l <= next_l;
            END IF;
            
            --- shift register ---
            IF (t_clr = '1') THEN
                curr_target <= (OTHERS => '0');
            ELSIF t_load = '1' THEN
                curr_target <= next_target;
            END IF;
        END IF;     
    END PROCESS; --DpStateReg
    
    DpCombLogic: PROCESS(go, l_clr, l_inc, i_inc, i_clr, t_clr, a_pulse, l_lt_t, i_lt_3, curr_i, curr_l, curr_target, t_load)
    BEGIN
        t_load <= i_lt_3;
        ---CMP_i ---
        IF (unsigned(curr_i) < 3) THEN
            i_lt_3 <= '1';
        ELSE 
            i_lt_3 <= '0';
        END IF;
        
        --- next i ---
        IF ((i_inc AND i_lt_3 )= '1') THEN
            next_i <= std_logic_vector(unsigned(curr_i) + 1);
        ELSE
            next_i <= curr_i;
        END IF;
        
        --- next l ---
        IF(l_inc = '1') THEN
            next_l <= std_logic_vector(unsigned(curr_l)+1);
        END IF;
        
        --- target ---
        --IF(t_load = '1') THEN
            next_target(0) <= curr_target(1);
            next_target(1) <= curr_target(2);
            next_target(2) <= go;
        --END IF;
        
        --- CMP l ---
        IF (unsigned(curr_l) < unsigned(curr_target)) THEN
            l_lt_t <= '1';
        ELSE
            l_lt_t <= '0';
        END IF;
        
        output <= a_pulse AND l_lt_t; -- a_pulse provided by controller to output a pulse. IF pulse and l_lt_t then 1.
    END PROCESS; --DpCombLogic
    
    --- CONTROLLER STATE PROCESSES ---
    CtrlStateReg: PROCESS(clk, stop)
    BEGIN
        IF(rising_Edge(clk)) THEN
            IF((stop AND NOT go)='1') THEN
                currstate <= S0;
              --  a_pulse <= '0';
            ELSE
               currstate <= nextstate;
            END IF;
        END IF;
    END PROCESS; --CtrlStateReg
    
    CtrlCombLogic: PROCESS(currstate, go, stop, i_lt_3, l_lt_t)
    BEGIN
    
     CASE currstate IS
                WHEN S0 =>
                    a_pulse <= '0'; 
                    --i_clr <= '1'; l_clr <= '1';
                    i_inc <= '0'; l_inc <= '0';
                    IF (GO AND STOP) = '1' THEN
                        nextstate <= L0;
                    ELSIF (GO AND NOT STOP) = '1' THEN
                        nextstate <= S1;
                    ELSE
                        nextstate <= S0;
                    END IF;
                 
                WHEN L0 =>
                    t_clr <= '1';
                    i_clr <= '1';
                    nextstate <= L1;
                WHEN L1=> 
                    t_clr <= '0'; i_clr <= '0';
                    i_inc <= '1';
                    IF(i_lt_3 = '0') THEN
                        nextstate <= S0;
                    ELSE
                        nextstate <= L1;
                    END IF;
                WHEN S1 =>
                    l_clr <= '1';
                    nextstate <= S2;
                WHEN S2 =>
                    l_clr <= '0';
                    l_inc <= '1';
                    a_pulse <= '1';
                    IF (l_lt_t = '1') THEN
                        nextstate <= S2;
                    ELSE
                        nextstate <= S0;
                    END IF;
                
                END CASE;
    END PROCESS; --CtrlCombLogic;
END CtrlDpBeh;