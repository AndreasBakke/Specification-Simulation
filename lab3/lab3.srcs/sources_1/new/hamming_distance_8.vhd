library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


ENTITY hamming_distance_8 IS
    PORT(
    a, b: IN std_logic_vector(7 DOWNTO 0);
    result: OUT std_logic_vector(3 DOWNTO 0));
BEGIN
    
END hamming_distance_8;


ARCHITECTURE Behav OF hamming_distance_8 IS
BEGIN
    PROCESS (a,b)
        VARIABLE match_vect: std_logic_vector(7 DOWNTO 0);
        VARIABLE COUNT: unsigned(3 DOWNTO 0);
    BEGIN
        count := "0000";
        match_vect := a XOR b;
        FOR i IN 0 TO 7 LOOP
            IF match_vect(i) = '1' THEN
               count := count +1;
            END IF;
        END LOOP;
        result <= std_logic_vector(count);
    END PROCESS;
END;


--ARCHITECTURE Behav_2 OF hamming_distance_8 IS
--    SIGNAL match_vect: std_logic_vector(7 DOWNTO 0);
--    SIGNAL a0, a1, a2, a3: std_logic_vector(1 DOWNTO 0);
--BEGIN
--    PROCESS (a,b)
--    BEGIN
--    match_vect <= a XOR b;
--    a0 <= 
--    a1 <= match_vect(3 DOWNTO 2);
--    a2 <= match_vect(5 DOWNTO 4);
--    a3 <= match_vect(7 DOWNTO 4)

--    END PROCESS;
--END;


ARCHITECTURE Struct OF hamming_distance_8 IS
    COMPONENT xor_8 IS
        PORT(x,y: IN std_logic_vector(7 DOWNTO 0);
            F: OUT std_logic_vector (7 DOWNTO 0));
    END COMPONENT;
    
    COMPONENT full_adder_1 IS
        PORT(x, y, c_i: IN std_logic;
            c_o, s: OUT std_logic);
    END COMPONENT;
    
    COMPONENT full_adder_2 IS
        PORT(x,y: IN std_logic_vector(1 DOWNTO 0);
        c_i: IN std_logic;
        c_o: OUT std_logic;
        s: OUT std_logic_vector(1 DOWNTO 0));
    END COMPONENT;
    
    
    COMPONENT full_adder_3 IS
        PORT(x,y: IN std_logic_vector(2 DOWNTO 0);
        c_i: IN std_logic;
        c_o: OUT std_logic;
        s: OUT std_logic_vector(2 DOWNTO 0)
        );
    END COMPONENT;
    
    SIGNAL match_vect: std_logic_vector(7 DOWNTO 0);
    SIGNAL a1, a2, a3, a4: std_logic_vector(1 DOWNTO 0);
    signal b1, b2: std_logic_vector(2 DOWNTO 0);
    SIGNAL c: std_logic_vector(3 DOWNTO 0);
BEGIN
    xor_8_1: xor_8 PORT MAP(a,b,match_vect);
    full_adder_1_1: full_adder_1 PORT MAP(match_vect(1), match_vect(0), '0', a1(1), a1(0));
    full_adder_1_2: full_adder_1 PORT MAP(match_vect(3), match_vect(2), '0', a2(1), a2(0));
    full_adder_1_3: full_adder_1 PORT MAP(match_vect(5), match_vect(4), '0', a3(1), a3(0));
    full_adder_1_4: full_adder_1 PORT MAP(match_vect(7), match_vect(6), '0', a4(1), a4(0));
    full_adder_2_1: full_adder_2 PORT MAP(a1, a2, '0', b1(2), b1(1 DOWNTO 0));
    full_adder_2_2: full_adder_2 PORT MAP(a3, a4, '0', b2(2), b2(1 DOWNTO 0));
    full_adder_3_1: full_adder_3 PORT MAP(b1, b2, '0', c(3), c(2 DOWNTO 0));
    result <= c;

END;