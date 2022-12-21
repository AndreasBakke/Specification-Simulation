LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;



ENTITY BIST IS
    PORT(
        go: IN std_logic;  -- start signal for test.
        Rst: IN std_logic; --active high reset signal
        fin: OUT std_logic; --signals that testing has finished;
        A, X: OUT std_logic_vector(15 downto 0); --data signals out
        Z: IN std_logic_vector(15 downto 0); --data signal in
        clr, rw: out std_logic; --memory controll signals
        clk: IN std_logic
    );
BEGIN
END BIST;



ARCHITECTURE FSMD of BIST IS
    COMPONENT BIST_DP IS
        PORT(
        cnt_inc, cnt_rst, set_x, set_a: IN std_logic; -- control singnals in
        cnt_lt_256, z_eq_0, z_eq_1: OUT std_logic; --status signals
        A, X: out std_logic_vector(15 downto 0); --data signals out
        Z: IN std_logic_vector (15 downto 0); --data signals in
        clk: IN std_logic -- async active high reset
        );
    END COMPONENT;
    
    COMPONENT BIST_FSM IS
        PORT(
        go: IN std_logic;
        z_eq_0, z_eq_1, cnt_lt_256: IN std_logic; --status signals
        cnt_inc, cnt_rst, clr, set_x, set_A, rw: OUT std_logic; -- control signals clr connectecd to RAM
        x: OUT std_logic_vector(15 downto 0);
        fin: out std_logic;
        clk, Rst: IN std_logic --Clock and async active high reset
        );
    END COMPONENT;
    signal cnt_lt_256, z_eq_0, z_eq_1 : std_logic; --status signals
    SIGNAL cnt_inc, cnt_rst, set_x, set_a: std_logic; --control signals
BEGIN
    datapath: BIST_DP 
    PORT MAP(
    cnt_inc => cnt_inc, cnt_rst => cnt_rst,
    set_x => set_x, set_a => set_a,
    cnt_lt_256 => cnt_lt_256,
    z_eq_0 => z_eq_0, z_eq_1 => z_eq_1,
    A => A,
    X => X,
    Z => Z,
    clk => clk
    );
    controller: BIST_FSM PORT MAP(
    go => go,
    z_eq_0 => z_eq_0, z_eq_1 => z_eq_1,
    cnt_lt_256 => cnt_lt_256,
    cnt_inc => cnt_inc, cnt_rst => cnt_rst,
    set_x => set_x, set_A => set_a, 
    clr => clr, rw => rw,
    fin => fin,
    rst => rst,
    clk => clk);


END FSMD;