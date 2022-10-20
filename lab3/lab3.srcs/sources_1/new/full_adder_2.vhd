LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;


ENTITY full_adder_2 IS
    PORT(
    x,y: IN std_logic_vector(1 DOWNTO 0);
    c_i: IN std_logic;
    c_o: OUT std_logic;
    s: OUT std_logic_vector (1 DOWNTO 0)
    );
BEGIN
END full_adder_2;


ARCHITECTURE Struct of full_adder_2 IS
    COMPONENT full_adder_1 IS
        PORT(x,y,c_i: IN std_logic;
        c_o,s: OUT std_logic);
    END COMPONENT;
    SIGNAL s_0, s_1, c_0: std_logic;
BEGIN
    full_adder_1_1: full_adder_1 PORT MAP(x(0), y(0), c_i, c_0, s_0);
    full_adder_1_2: full_adder_1 PORT MAP(x(1), y(1), c_0, c_o, s_1);
    s <=  (s_1, s_0);
    
END Struct;