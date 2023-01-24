LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


ENTITY lcm_tb IS
BEGIN
END lcm_tb;


ARCHITECTURE TBarch OF lcm_tb IS
    COMPONENT lcm IS
        PORT(
            a, b : IN std_logic_vector(7 downto 0);
            lcm: OUT std_logic_vector(15 downto 0);
            start, clk, RSTn: IN std_logic; --async active low reset
            ready: OUT std_logic
        );
    END COMPONENT;
    SIGNAL a_s, b_s : std_logic_vector(7 downto 0);
    SIGNAL lcm_s : std_logic_vector(15 downto 0);
    SIGNAL start_s, clk_s, RSTn_s, ready_s: std_logic;
    
    CONSTANT clk_period: time := 10ns;
BEGIN
    dut: entity work.lcm(struct) PORT MAP(a => a_s, b => b_s, lcm => lcm_s, start => start_s, clk => clk_s, RSTn => RSTn_s, ready => ready_s);

    clockDriver: PROCESS BEGIN
        clk_s <= '0';
        wait for clk_period/2;
        clk_s <= '1';
        wait for clk_period/2;
    END PROCESS; -- clockDriver


    testVector: PROCESS BEGIN
        a_s <= (OTHERS => '0'); b_s <= (OTHERS => '0');
        start_S <= '0'; RSTn_s <= '0';
        wait for clk_period/4;
        RSTn_S <= '1';
        a_s <= "00001100"; --12
        b_s <= "00010010"; --18
        start_s <= '1';
        wait for clk_period*2;
        start_s <= '0';
        a_s <= (OTHERS => 'Z');
        b_s <= (OTHERS => 'Z');
        wait for clk_period*6;
        a_s <= "11111111"; --255
        b_s <= "11111110"; --254
        start_s <= '1';
        wait for clk_period;
        start_s <= '0';
        wait;
    
    
    
    END PROCESS;
END TBArch;
