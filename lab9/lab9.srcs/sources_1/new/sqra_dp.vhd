---------DISCLAIMER ----------
-- exercise over-complicated
-- to challenge myself using more
-- structural components
------------------------------


LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.arrayInput;


ENTITY sqra_dp IS
    PORT(
        A, B: IN std_logic_vector(7 DOWNTO 0);
        r1_s, r3_s:IN std_logic_vector(1 DOWNTO 0);
        r2_s : IN std_logic_vector(2 downto 0);
        res: OUT std_logic_vector(8 downto 0);
        --ready: OUT std_logic;
        clk: IN std_logic
    );
BEGIN

END sqra_dp;

ARCHITECTURE Struct of sqra_dp IS
    COMPONENT Mux_8_9
    PORT(
        i0,i1, i2,i3,i4,i5,i6,i7:std_logic_vector(8 downto 0);
        sel: IN std_logic_vector(2 downto 0);
        o: OUT std_logic_vector(8 DOWNTO 0)
    );
    END COMPONENT;
    
    
    COMPONENT Mux_4_9
    PORT(
        i0, i1, i2, i3: std_logic_vector(8 downto 0);
        sel: IN std_logic_vector(1 downto 0);
        o: OUT std_logic_vector(8 DOWNTO 0)
    );
    END COMPONENT;
    
    --mux signals
    SIGNAL m1_0, m1_1, m1_2, m1_3, m1_o: std_logic_vector(8 downto 0);
    signal m1_i: arrayInput.signalArray(0 TO 3);
    SIGNAL m2_0, m2_1, m2_2, m2_3, m2_4, m2_5, m2_o: std_logic_vector(8 downto 0);
    signal m2_i: arrayInput.signalArray(0 TO 5);
    SIGNAL m3_0, m3_1, m3_2, m3_3, m3_o: std_logic_vector(8 downto 0);
    signal m3_i: arrayInput.signalArray(0 TO 3);
    
    --Comb logic signals
    SIGNAL max21, min21 : std_logic_vector(8 downto 0);
    --registers
    SIGNAL R1, R2, R3: std_logic_vector(8 downto 0); -- 3 registers
    
    
BEGIN

    --MUX 1
    m1_0 <= R1; --first port is output of mux
    m1_1(8) <= A(7); m1_1(7 downto 0) <= A(7 downto 0); -- second is extended A
    m1_2 <=  std_logic_vector(abs(signed(R1)));  --third is absolute value of output
    m1_3 <= max21; --driven by comblogic process
    
    
    --MUX 2
    m2_0 <= R2; --first port is output of mux
    m2_1(8) <= B(7); m2_1(7 DOWNTO 0) <= B(7 downto 0); --second is extended B
    m2_2 <=  std_logic_vector(abs(signed(R2)));  --third is absolute value of output
    m2_3 <= min21; --driven by comblogic process
    m2_4 <= std_logic_vector(signed(R2)/2);
    m2_5 <= std_logic_vector(signed(R2) + signed(R3));
    
    
    --MUX 3
    m3_0 <= R3; 
    m3_1 <= std_logic_vector(signed(max21)/8); --drivven by comlogic process
    m3_2 <= std_logic_vector(signed(R1) - signed(R3));
    m3_3 <= max21;

    ----- CREATE ARRAYS FOR MUX INPUT) -----
    m1_i <= (m1_0, m1_1, m1_2, m1_3);
    m2_i <= (m2_0, m2_1, m2_2, m2_3, m2_4, m2_5);
    m3_i <= (m3_0, m3_1, m3_2, m3_3);
    ---- CONNECT MUXES ----
    mux1: Mux_4_9 
        PORT MAP(
        i0 => m1_0, i1 => m1_1, i2 => m1_2, i3 =>m1_3,
        sel => r1_s, o => m1_o
        );
    mux2: Mux_8_9 
        PORT MAP(
        i0 => m2_0, i1 => m2_1, i2 => m2_2, i3 => m2_3, i4 => m2_4, i5 => m2_5, i6 => (OTHERS => '0'),i7 => (OTHERS => '0'),
        sel => r2_s, o => m2_o);
    mux3: Mux_4_9 
        PORT MAP(
        i0 => m3_0, i1 => m3_1, i2 => m3_2, i3 => m3_3,
        sel => r3_s, o => m3_o);
        
        
    --- OUTPUT ---
    res <= R3;
    --ready <= NOT r1_s(0) AND NOT r1_s(1) AND NOT r2_s(0) AND NOT r2_s(1) aND NOT r2_s(2) AND NOT r3_s(0) AND NOT r3_s(1);


    combLogic: PROCESS(R1, R2, R3, A, B, r1_s, r2_s, r3_s)
    BEGIN
    IF signed(R1) >= signed(R2) THEN
        max21 <= R1;
        min21 <= R2;
    ELSE
        max21 <= R2;
        min21 <= R1;
    END IF;

    
    END PROCESS;
    
    registerUpdate: PROCESS(clk)
    BEGIN
        IF rising_edge(clk) THEN
            R1 <= m1_O;   
            R2 <= m2_O;
            R3 <= m3_O;
        END IF;
    END PROCESS; --registerUpdate
END Struct;