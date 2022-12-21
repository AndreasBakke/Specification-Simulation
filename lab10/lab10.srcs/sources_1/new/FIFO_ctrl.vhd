LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY FIFO_ctrl IS
    GENERIC(
        N: positive:=4; --data width
        M: positive:=8  --2^M adresses 
    );

    PORT(
        rd, wr: IN std_logic;
        full, empty: OUT std_logic;
        w_addr, r_addr: OUT std_logic_vector(M-1 downto 0);
        clk, RSTn: IN std_logic
    );

BEGIN
END FIFO_ctrl;


ARCHITECTURE Behav of FIFO_ctrl IS
    SIGNAL front, rear, nextFront, nextRear: unsigned(M-1 downto 0) := (OTHERS => '0');
    TYPE stateType IS (Q_ACTIVE, Q_FULL, Q_EMPTY);
    SIGNAL currState, nextState: stateType := Q_EMPTY;
BEGIN
    stateReg: PROCESS(clk, RSTn)
    BEGIN
        IF RSTn = '0' THEN
            currState <= Q_EMPTY;
            rear <= (OTHERS => '0');
            front <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            currState <= nextState;
            rear <= nextRear;
            front <= nextFront;
        END IF;
    END PROCESS; --stateReg
    
    combLogic: PROCESS(rd, wr, front, rear, nextfront, nextrear, currState)
        Variable count: integer := 0;
    BEGIN
        CASE currState IS
        WHEN Q_EMPTY => --Will naturally start in this state
            empty <= '1'; full <= '0';
            IF wr = '1' THEN
                count := to_integer(rear+1) mod (2**M);
                nextrear <= to_unsigned(count, M); --Error? mod 2**4 gir maks 3 siden 4 mod 4 = 0
                nextState <= Q_ACTIVE; -- only possible state if we write on empty queue.
            ELSE
                nextrear <= rear;
                nextState <= Q_EMPTY;
            END IF;
        WHEN Q_ACTIVE => --We are dequeueing or enqueueing
            full <= '0'; empty <= '0';
            IF WR = '1' THEN
                count := to_integer(rear+1) mod (2**M);
                nextrear <= to_unsigned(count, M); 
                IF nextrear = nextfront THEN
                    nextState <= Q_FULL;
                ELSE
                    nextState <= Q_ACTIVE;
                END IF;
            ELSE 
                nextrear <= rear;
                nextState <= Q_ACTIVE;
            END IF;
            IF rd = '1' THEN
                count:= to_integer(front+1) mod(2**M);
                nextFront <= to_unsigned(count, M);
                IF nextrear = nextfront tHEN
                    nextState <= Q_EMPTY;
                ELSE
                    nextState <= Q_ACTIVE;
                END IF;
            ELSE
                nextFront <= front;
                --nextState <= Q_ACTIVE; --dont update state in case write has noticed we are full. Will no matter what have a valid state.
            END IF;
            
        WHEN Q_FULL =>
            full <= '1'; empty <= '0';
            IF rd = '1' THEN
                count:= to_integer(front+1) mod(2**M);
                nextFront <= to_unsigned(count, M);
                nextstate <= Q_ACTIVE;
            ELSE
                nextfront <= front;
                nextstate <= Q_FULL;
            END IF;
            
        WHEN OTHERS =>
            nextState <= Q_active;
            nextFront <= front;
            nextRear  <= rear;    
        END CASE;
    END PROCESS;



    w_addr <= std_logic_vector(rear);
    r_addr <= std_logic_vector(front);
 --fsm med full og empty state!
END Behav;