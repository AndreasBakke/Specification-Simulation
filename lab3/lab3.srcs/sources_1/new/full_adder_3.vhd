LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;


ENTITY full_adder_3 IS
    PORT(
    x,y: IN std_logic_vector(2 DOWNTO 0);
    c_i: IN std_logic;
    c_o: OUT std_logic;
    s: OUT std_logic_vector (2 DOWNTO 0)
    );
BEGIN
END full_adder_3;


ARCHITECTURE Struct of full_adder_3 IS
    COMPONENT full_adder_1 IS
        PORT(x,y,c_i: IN std_logic;
        c_o,s: OUT std_logic);
    END COMPONENT;
    SIGNAL s_0, s_1, s_2, c_0, c_1: std_logic;
BEGIN
    full_adder_1_1: full_adder_1 PORT MAP(x(0), y(0), c_i, c_0, s_0);
    full_adder_1_2: full_adder_1 PORT MAP(x(1), y(1), c_0, c_1, s_1);
    full_adder_1_3: full_adder_1 PORT MAP(x(2), y(2), c_1, c_o, s_2);

    s <=  (s_2, s_1, s_0);
    
END Struct;