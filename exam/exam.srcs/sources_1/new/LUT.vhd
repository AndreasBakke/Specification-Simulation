LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


ENTITY LUT IS
    PORT(
    LUTin: IN std_logic_vector(7 DOWNTO 0);
    LUTout: OUT std_logic_vector(7 DOWNTO 0)
    );
BEGIN
END LUT;


ARCHITECTURE Behav OF LUT IS
    SIGNAL NIBBLE1, NIBBLE2 : std_logic_vector(3 DOWNTO 0);
BEGIN
    NIBBLE1 <= LUTin(7 DOWNTO 4); NIBBLE2 <= LUTin(3 DOWNTO 0);
    PROCESS(NIBBLE1, NIBBLE2) BEGIN
        CASE(NIBBLE1) IS
            WHEN "0000" => LUTout(7 DOWNTO 4) <= "0001";
            WHEN "0001" => LUTout(7 DOWNTO 4) <= "1011";
            WHEN "0010" => LUTout(7 DOWNTO 4) <= "1001";
            WHEN "0011" => LUTout(7 DOWNTO 4) <= "1100";
            WHEN "0100" => LUTout(7 DOWNTO 4) <= "1101";
            WHEN "0101" => LUTout(7 DOWNTO 4) <= "0110";
            WHEN "0110" => LUTout(7 DOWNTO 4) <= "1111";
            WHEN "0111" => LUTout(7 DOWNTO 4) <= "0011";
            WHEN "1000" => LUTout(7 DOWNTO 4) <= "1110";
            WHEN "1001" => LUTout(7 DOWNTO 4) <= "1000";
            WHEN "1010" => LUTout(7 DOWNTO 4) <= "0111";
            WHEN "1011" => LUTout(7 DOWNTO 4) <= "0100";
            WHEN "1100" => LUTout(7 DOWNTO 4) <= "1010";
            WHEN "1101" => LUTout(7 DOWNTO 4) <= "0010";
            WHEN "1110" => LUTout(7 DOWNTO 4) <= "0101";
            WHEN "1111" => LUTout(7 DOWNTO 4) <= "0000";
            WHEN OTHERS => LUTout(7 DOWNTO 4) <= "ZZZZ";    
        END CASE;
        
        CASE(NIBBLE2) IS
            WHEN "0000" => LUTout(3 DOWNTO 0) <= "1111";
            WHEN "0001" => LUTout(3 DOWNTO 0) <= "0000";
            WHEN "0010" => LUTout(3 DOWNTO 0) <= "1101";
            WHEN "0011" => LUTout(3 DOWNTO 0) <= "0111";
            WHEN "0100" => LUTout(3 DOWNTO 0) <= "1011";
            WHEN "0101" => LUTout(3 DOWNTO 0) <= "1110";
            WHEN "0110" => LUTout(3 DOWNTO 0) <= "0101";
            WHEN "0111" => LUTout(3 DOWNTO 0) <= "1010";
            WHEN "1000" => LUTout(3 DOWNTO 0) <= "1001";
            WHEN "1001" => LUTout(3 DOWNTO 0) <= "0010";
            WHEN "1010" => LUTout(3 DOWNTO 0) <= "1100";
            WHEN "1011" => LUTout(3 DOWNTO 0) <= "0001";
            WHEN "1100" => LUTout(3 DOWNTO 0) <= "0011";
            WHEN "1101" => LUTout(3 DOWNTO 0) <= "0100";
            WHEN "1110" => LUTout(3 DOWNTO 0) <= "1000";
            WHEN "1111" => LUTout(3 DOWNTO 0) <= "0110";
            WHEN OTHERS => LUTout(3 DOWNTO 0) <= "ZZZZ";    
        END CASE;
    END PROCESS; --process
END BEHAV;