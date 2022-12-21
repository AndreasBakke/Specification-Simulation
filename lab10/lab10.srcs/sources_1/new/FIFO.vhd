LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY FIFO IS
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
BEGIN

END FIFO;




ARCHITECTURE CtrlDP OF FIFO IS
    COMPONENT FIFO_dp IS
        GENERIC(
            N: positive := 4; --data width
            M: positive := 8 --2^M locations
        );
        
        PORT(
            w_data: IN std_logic_vector(N-1 DOWNTO 0);
            r_data: OUT std_logic_vector(N-1 downto 0);
            w_en: IN std_logic;
            w_addr, r_addr: IN std_logic_vector(M-1 downto 0);
            clk: IN std_logic
        );
    END COMPONENT;
    
    COMPONENT FIFO_Ctrl IS
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
    END COMPONENT;
    
    SIGNAL w_enable, f_s: std_logic;
    SIGNAL w_addr, r_addr: std_logic_vector(M-1 downto 0);
    
BEGIN
    controller: entity work.FIFO_Ctrl(Behav) GENERIC MAP(N => N, M => M) PORT MAP(clk => clk, RSTn => RSTn, full => f_s, empty => empty, rd => rd, wr => wr, w_addr => w_addr, r_addr => r_addr);
    dataPath: entity work.FIFO_DP(Behav) GENERIC MAP(N=> N, M => M) PORT MAP(clk => clk,  w_en => w_enable, w_data => w_data, r_data => r_data, w_addr => w_addr, r_addr => r_addr);
    w_enable <= wr AND NOT f_s;
    full <= f_s;

END CtrlDP;