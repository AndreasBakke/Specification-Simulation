LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;



ENTITY FIFO_tb IS

BEGIN
END FIFO_TB;


ARCHITECTURE TBArch of FIFO_tb IS
    COMPONENT FIFO IS
        GENERIC(
        N: positive := 4; --Data width
        M: positive := 8  --2^m locations
        );
        
        PORT(
        clk: IN std_logic;
        RSTn: IN std_logic;
        rd: IN std_logic;  --Starts dequeue
        wr: IN std_logic; -- Starts Enqueue
        full, empty: OUT std_logic; --Signals full or empty queue
        w_data: IN std_logic_vector(N-1 downto 0);
        r_data: OUT std_logic_vector(N-1 DOWNTO 0)
        );
    END COMPONENT;
    CONSTANT N: positive := 4;
    CONSTANT M: positive := 2; --4 memory adresses
    CONSTANT clk_period: time:= 10ns;
    SIGNAL clk_s, RSTn_s, rd_s, wr_s, full_S, empty_s: std_logic;
    signal w_data_S, r_data_s: std_logic_vector(N-1 downto 0);
BEGIN
    dut: FIFO GENERIC MAP( N=> N, M=> M) PORT MAP(clk => clk_s, RSTn => RSTn_s, rd => rd_s, wr => wr_s, full => full_S, empty => empty_s, w_Data => w_data_S, r_data => r_data_S);
    
    
    ClockGen: PROCESS
    BEGIN
        clk_s <= '0';
        wait for clk_period/2;
        clk_s <= '1';
        wait for clk_period/2;
    END PROCESS;
    
    
    testVector: PROCESS
    BEGIN
    RSTn_s <= '0'; w_data_S <= (OTHERS =>'0'); rd_S <= '0'; wr_s <= '0';
    wait for clk_period/4;
    RSTn_s <= '1'; w_data_s <= "0101";
    wait for clk_period;
    wr_s <= '1';
    wait for clk_period;
    wr_s <= '0'; w_data_s <= "0001";
    wait for clk_period;
    wr_s <= '1';
    wait for clk_period*2;
    w_data_S <= "1111";
    wait for clk_period;
    wait for clk_period*2;
    wr_s <= '0';rd_s <= '1';
    wait for clk_period*4;
    rd_s <= '0';
    
    
    WAIT;
    END PROCESS;


END TBArch;