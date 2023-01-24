Library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;



entity RAM_diffcount IS
    PORT(
    Addr: IN std_logic_vector(9 downto 0);
    GO: IN std_logic;
    clk, RSTn: IN std_logic;
    diffCount: OUT std_logic_vector(5 downto 0); --capable of +-16 in difference for 16 bit ram cells
    ram_data: IN std_logic_vector(15 downto 0);
    ram_wr, ram_en: OUT std_logic --ram control signals
    );

BEgin
END RAM_diffcount;


ARCHITECTURE HLSM of RAM_diffcount IS
    TYPE StateType IS (IDLE, SET, READ, COMPUTE);
    SIGNAL state: StateType;
    SIGNAL v: std_logic_vector(15 downto 0);
BEGIN
    PROCESS(clk, RSTn) IS
        Variable i, diff: natural;
    BEGIN
        IF (RSTn = '0') THEN
            state <= IDLE;
        ELSIF rising_edge(clk) THEN
            CASE state IS
                WHEN IDLE =>
                    diffCount <= std_logic_vector(to_signed(diff, 6));
                    IF GO = '1' THEN
                        state <= READ;
                    ELSE
                        state <= IDLE;
                    END IF;
                WHEN SET =>
                    i:= 0;
                    diff:=0;
                    ram_wr <= '0';
                    ram_en <= '1';
                WHEN READ =>
                    v <= ram_data;
                    ram_wr <= 'Z';
                    ram_en <= 'Z';
                WHEN COMPUTE =>
                    IF (v(i) = '1') THEN
                        diff:= diff+1;
                    ELSE
                        diff := diff-1;
                    END IF;
                    i:= i+1;
                    IF (i <= 16) THEN
                        state <= COMPUTE;
                    ELSE
                        state <= IDLE;
                    END IF;
            
            END CASE;
        END IF; 
    END PROCESS;
END HLSM;