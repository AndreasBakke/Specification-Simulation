LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY majority_vote_alu IS
    PORT(A,B,C,D,E,F: IN std_logic_vector(7 DOWNTO 0);
    ctrl: IN std_logic_vector(2 DOWNTO 0);
    decision: OUT std_logic_vector(7 DOWNTO 0);
    data_valid: OUT std_logic
    );
BEGIN
END majority_vote_alu;

ARCHITECTURE Datafl OF majority_vote_alu IS
    COMPONENT alu IS
        GENERIC(N: integer:= 4);
        PORT(
        src0, src1: IN std_logic_vector(N-1 DOWNTO 0);
        ctrl: IN std_logic_vector(2 DOWNTO 0);
        result: OUT std_logic_vector(N-1 DOWNTO 0));
    END COMPONENT;
    
    COMPONENT comparator IS
        GENERIC(N: integer:=4);
        PORT(x, y: IN std_logic_vector(N-1 DOWNTO 0);
            eq: OUT std_logic;
            AgtB: OUT std_logic;
            AltB: OUT std_logic);
    END COMPONENT;
    
    SIGNAL o1, o2, o3: std_logic_vector(7 DOWNTO 0);
    SIGNAL eq: std_logic_vector(2 DOWNTO 0);
BEGIN
    alu_1: entity work.alu
        GENERIC MAP(N=> 8)
        PORT MAP(src0 => A, src1 => B, ctrl => ctrl, result => o1);
    alu_2: entity work.alu
        GENERIC MAP(N=> 8)
        PORT MAP(src0 => C, src1 => D, ctrl => ctrl, result => o2);
    alu_3: entity work.alu
        GENERIC MAP(N=> 8)
        PORT MAP(src0 => E, src1 => F, ctrl => ctrl, result => o3);
    comparator_1: entity work.comparator
        GENERIC MAP(N=>8)
        PORT MAP(x=> o1, y=> o2, eq=> eq(0));
    comparator_2: entity work.comparator
        GENERIC MAP(N=>8)
        PORT MAP(x=> o1, y=> o3, eq=> eq(1));
    comparator_3: entity work.comparator
        GENERIC MAP(N=>8)
        PORT MAP(x=> o2, y=> o3, eq=> eq(2));
    WITH eq SELECT  decision <= 
        o3 WHEN "1--",
        o2 WHEN "01-", 
        o1 WHEN "001",
        "ZZZZZZZZ" WHEN OTHERS;
        
    data_valid <= (eq(0) OR eq(1) OR eq(2));
END Datafl;