LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY combinational_multiplier IS
    PORT(
        a, b: IN std_logic_vector(3 DOWNTO 0);
        p: OUT std_logic_vector(7 DOWNTO 0)
    );
BEGIN
END combinational_multiplier;



ARCHITECTURE Datafl OF combinational_multiplier IS
signal r1, r2, r3, r4: std_logic_vector(3 DOWNTO 0);
signal i1, i2, i3, i4: std_logic_vector(7 DOWNTO 0);
BEGIN
    r1 <= a AND (b(0), b(0), b(0), b(0));
    r2 <= a AND (b(1), b(1), b(1), b(1));
    r3 <= a AND (b(2), b(2), b(2), b(2));
    r4 <= a AND (b(3), b(3), b(3), b(3));

    i1 <= "0000" & r1;
    i2 <= "000" & r2 & "0";
    i3 <= "00" & r3 & "00";
    i4 <= "0" & r4 & "000";
    p <= std_logic_vector(unsigned(i1)+ unsigned(i2) + unsigned(i3) + unsigned (i4));
END Datafl;



ARCHITECTURE OptimizedDatafl OF combinational_multiplier IS
signal pp0, pp1, pp2,pp3: std_logic_vector(4 DOWNTO 0);
BEGIN
    pp0 <= "0" & (a AND (b(0), b(0), b(0), b(0)));

    pp1 <= std_logic_vector('0' & unsigned(pp0(4 DOWNTO 1)) + unsigned((a AND (b(1), b(1), b(1), b(1)))) );
    pp2 <= std_logic_vector('0' & unsigned(pp1(4 DOWNTO 1)) + unsigned((a AND (b(2), b(2), b(2), b(2)))) );
    pp3 <= std_logic_vector('0' & unsigned(pp2(4 DOWNTO 1)) + unsigned((a AND (b(3), b(3), b(3), b(3)))) );
    
    p <= (pp3(4), pp3(3), pp3(2), pp3(1),pp3(0), pp2(0), pp1(0), pp0(0));
END OptimizedDatafl;