LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;



ENTITY BIST_DP IS
    PORT(
    cnt_inc, cnt_rst, set_x, set_a: IN std_logic; -- control singnals in
    cnt_lt_256, z_eq_0, z_eq_1: OUT std_logic; --status signals
    A, X: out std_logic_vector(15 downto 0); --data signals out
    Z: IN std_logic_vector (15 downto 0); --data signals in
    clk: IN std_logic -- async active high reset
    );
BEGIN

END BIST_DP;



ARCHITECTURE Behav OF BIST_DP IS
    signal cnt: std_logic_vector(15 downto 0);
    signal allones: std_logic_vector(15 downto 0) := (OTHERS => '1');
BEGIN
    cnt_reg: PROCESS(clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF cnt_inc = '1' THEN
                cnt <= std_logic_vector(unsigned(cnt) +1);
            END IF;
            IF cnt_rst = '1'THEN
                cnt <= (OTHERS => '0');
            END IF;
        END IF;
    END PROCESS; --cnt_Reg
    
   
   
   
   z_eq_0 <= '1' WHEN (unsigned(Z) = 0) ELSE '0';
   Z_eq_1 <= '1' WHEN(Z = allones) ELSE '0';
   cnt_lt_256 <= '0' WHEN (unsigned(cnt) < 256) ELSE '1';
    --Tristate buffer for A
    A <= cnt WHEN (set_a = '1') ELSE (OTHERS => 'Z');
    --Tristate buffer for X
    X <= (OTHERS => '1') WHEN (set_x = '1') ELSE (OTHERS => 'Z');
END Behav;