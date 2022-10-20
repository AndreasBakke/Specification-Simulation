LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;


ENTITY full_adder_1 IS
    PORT(x,y, c_i: IN std_logic;
     c_o, s: OUT std_logic);
BEGIN
END full_adder_1;


ARCHITECTURE behav of full_adder_1 IS
BEGIN
    c_o <= (x AND y) or (x AND c_i) or (y AND c_i);
    s <= x XOR y XOR c_i;
END behav;