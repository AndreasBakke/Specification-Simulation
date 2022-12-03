LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.arrayInput.ALL;



ENTITY square_root_approximator IS
    PORT(
    A, B: IN std_logic_vector(7 DOWNTO 0);
    start: IN std_logic;
    res : OUT std_logic_vector(8 DOWNTO 0);
    ready: OUT std_logic;
    clk, RSTn: IN std_logic
    );

BEGIN

END square_root_approximator;


ARCHITECTURE HLSM OF square_root_approximator IS
    TYPE stateType IS  (S0, S1, S2, S3, S4, S5, S6);
    SIGNAL currState, nextState: stateType;
    SIGNAL reg1, reg2, reg3 : std_logic_vector(8 downto 0); -- Only 3 registers needed
    SIGNAL nextReg1, nextReg2, nextReg3 : std_logic_vector( 8 downto 0);
    
BEGIN
    states: PROCESS(clk, RSTn)
    BEGIN--assuming async reset
        IF(RSTn = '0') THEN
            currState <= S0;
         ELSIF rising_edge(clk) THEN
            currState <= nextState;
            reg1 <= nextReg1;
            reg2 <= nextReg2;
            reg3 <= nextReg3;
         END IF;
    
    END PROCESS; --states

    combLogic: PROCESS(currstate, reg1, reg2, reg3, a,b,start)
    BEGIN
    CASE currState IS
        WHEN S0 =>
            ready <= '0';
            nextReg1 <= std_logic_vector(resize(signed(a),9));
            nextReg2 <= std_logic_vector(resize(signed(b),9));
            nextReg3 <= (OTHERS => '0');
            IF (start = '1') THEN
                nextState <= S1;
            ELSE
                nextState <= S0;
            END IF;
        WHEN S1 =>
            nextState <= S2;
            nextreg1 <= std_logic_vector(abs(signed(reg1))); --reg1 = a -> reg1 = t1
            nextreg2 <= std_logic_vector(abs(signed(reg2))); -- reg2 =b -> reg2 = t2
            nextreg3 <= reg3;
            ready <= '0';
        WHEN S2 =>
            ready <= '0';
            nextState <= S3;
            IF(signed(reg1) >= signed(reg2) ) THEN
                nextreg1 <= reg1; -- -> reg 1 = x
                nextreg2 <= reg2; -- -> reg 2 = y;
                nextreg3 <= std_logic_Vector(signed(reg1)/8); -- reg3 = x/8 = t3
            ELSE
                nextreg1 <= reg2;
                nextreg2 <= reg1;
                nextreg3 <= std_logic_Vector(signed(reg2)/8); --reg3 = x/8
            END IF;
        WHEN S3 =>
            ready <= '0';
            nextState <= S4;
            nextreg1 <= reg1;
            nextreg2 <= std_logic_vector(signed(reg2)/2); -- reg2 = y/4
            nextreg3 <= std_logic_vector(signed(reg1) - signed(reg3)); -- reg3 = x- t3
        WHEN S4 =>
            ready <= '0';
            nextState <= S5;
            nextreg1 <= reg1;
            nextreg2 <= std_logic_vector(signed(reg2) + signed(reg3)); 
            nextreg3 <= reg3;
        WHEN S5 =>
            ready <= '0';
            nextState <= S6;
            nextreg1 <= reg1;
            nextreg2 <= reg2;
            IF (signed(reg1) >= signed(reg2)) tHEN
                nextreg3 <= reg1;
            ELSE
                nextreg3 <= reg2;
            END IF;
        WHEN S6 =>
            nextreg1 <= reg1;
            nextreg2 <= reg2;
            nextreg3 <= reg3;
            ready <= '1';
            IF (start = '1') THEN
                    nextState <= S1;
                ELSE
                    nextState <= S6;
            END IF;
            
        WHEN OTHERS =>
            nextreg1 <= reg1;
            nextreg2 <= reg2;
            nextreg3 <= reg3;
            nextstate <= S0;
        END CASE;
        --res <= reg3;
    END PROCESS; --combLogic
END HLSM;


ARCHITECTURE FSM_d OF square_root_approximator IS

    COMPONENT sqra_dp
        PORT(
            A, B: IN std_logic_vector(7 DOWNTO 0);
            r1_s, r3_s:IN std_logic_vector(1 DOWNTO 0);
            r2_s : IN std_logic_vector(2 downto 0);
            res: OUT std_logic_vector(8 downto 0);
           -- ready: OUT std_logic;
            clk: IN std_logic
        );
    END COMPONENT;
    
    
    COMPONENT sqra_ctrl
        PORT(
            start: IN std_logic;
            clk: IN std_logic;
            RSTn: IN std_logic;
            ready: OUT std_logic;
            r1_s, r3_s: OUT std_logic_vector(1 downto 0);
            r2_s: out std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    signal r1, r3: std_logic_vector (1 downto 0);
    signal r2: std_logic_vector(2 downto 0);
BEGIN

    datapath: sqra_dp PORT MAP(A => A, B => B, r1_s => r1, r2_s => r2, r3_s => r3, res => res, clk => clk);
    controller: sqra_ctrl PORT MAP(start => start, clk => clk, ready => ready, RSTn => RSTn, r1_s => r1, r2_s => r2, r3_s => r3);
END FSM_d;