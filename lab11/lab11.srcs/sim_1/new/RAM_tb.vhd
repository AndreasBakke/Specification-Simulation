LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY RAM_tb IS
BEGIN
END RAM_tb;
ARCHITECTURE TBArch OF RAM_tb IS
    COMPONENT RAM IS
        GENERIC (n: natural := 16; p: natural := 256;
        k: natural := 8; Td: time := 40 ns);
  
        PORT (X: IN std_logic_vector(n-1 DOWNTO 0); -- data in
        A: IN std_logic_vector(k-1 DOWNTO 0); -- adress
        Z: OUT std_logic_vector(n-1 DOWNTO 0); --data out
        Clr, RW, Clk: IN std_logic); --control-signals
    END COMPONENT;
    
    
    constant clk_period: time := 50ns;
    SIGNAL X_s, Z_s: std_logic_vector(15 downto 0);
    SIGNAL a_s: std_logic_vector(7 downto 0);
    SIGNAL clr_s, rw_s, clk_s: std_logic;
    SIGNAL ones: std_logic_vector (15 downto 0) := (Others => '1');
BEGIN
    dut: RAM GENERIC MAP(n => 16, p => 256, k => 8, Td => 40ns) PORT MAP(X => X_s, A=> A_s, Z => Z_s, Clr => Clr_s, RW => RW_s, Clk=> clk_s);

    clk_process: PROCESS
    BEGIN
    clk_s <= '0';
    wait for clk_period/2;
    clk_s <= '1';
    wait for clk_period/2;
    END PROCESS; --clk_process
    
    test_vector: PROCESS
    VARIABLE count: integer := 0;
    BEGIN
    X_s <= (Others => '0'); A_s <= (OThers => '0'); Clr_s <= '1'; RW_s <= '0';
    wait for clk_period;
    wait for clk_period/4;
    X_s <= (Others => '1'); Clr_s <= '0';
    ASSERT 0 =1 REPORT "Started write and read" SEVERITY NOTE;
    
    MATS: FOR i IN 0 To 255 LOOP
        RW_S <= '0'; A_s <= std_logic_vector(to_unsigned(count, 8));
        wait for clk_period;
        ASSERT unsigned(Z_s) = 0 REPORT integer'image(count) SEVERITY FAILURE;
        RW_S <= '1';
        wait for clk_period;
        count := count+1;
    END LOOP;
    
    ASSERT 0=1 REPORT "Finished write loop, starting check" SEVERITY NOTE;
    
    count := 0;
    RW_S <= '0';
    FOR i In 0 TO 255 LOOP
        A_s <= std_logic_vector(to_unsigned(count,8));
        wait for clk_period;
        ASSERT Z_s = ones REPORT integer'image(count) SEVERITY FAILURE;
        count  := count +1;
    END LOOP;
    
    ASSERT 0=16#FF# REPORT "Finished testing" SEVERITY NOTE;
    
    
    WAIT;
    END PROCESS; --test_vector
    
    
    
END TBArch;