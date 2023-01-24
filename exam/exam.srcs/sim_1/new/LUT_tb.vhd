LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY LUT_tb  IS
BEGIN
END LUT_tb;




ARCHITECTURE TBarch OF LUT_tb IS
    COMPONENT LUT IS
        PORT(
            LUTin: IN std_logic_vector(7 DOWNTO 0);
            LUTout: OUT std_logic_vector(7 DOWNTO 0)
        );
    END COMPONENT;
    
    SIGNAL LUTin_s, LUTout_s: std_logic_vector(7 downto 0);
BEGIN
    dut: LUT PORT MAP(LUTin => LUTin_S, LUTout => LUTout_S);--device under test

    testVector: PROCESS BEGIN
        LUTin_s <= (OTHERS => '0');
        wait for 1ns;
        assert(LUTout_s = "00011111") report("Failed at test 1");
        LUTin_s <= "00101000";
        wait for 1ns;
        assert(LUTout_s = "10011001") report ("Failed at test 2");
        LUTin_s <= "11110111";
        wait for 1ns;
        assert(LUTout_s = "00001010") report("Failed at test 3");
        LUTin_s <= "ZXXX0001";
        wait for 1ns;
        assert(LUTout_s ="ZZZZ0000") report("Failed at test 4");
    
    
        WAIT;
    END PROCESS; --testVector    
    

END TBARCH;