----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/05/2022 08:40:46 PM
-- Design Name: 
-- Module Name: decoder_3_8 - Datafl
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder_3_8 is
    PORT(
        enable: IN std_logic;
        i: IN std_logic_vector(2 DOWNTO 0);
        o: OUT std_logic_vector (7 DOWNTO 0));
end decoder_3_8;

architecture Datafl_1 of decoder_3_8 is
begin
    o <= "00000000" WHEN (enable = '0') ELSE
        "10000000" WHEN (i = "111") ELSE
        "01000000" WHEN (i = "110") ELSE
        "00100000" WHEN (i = "101") ELSE
        "00010000" WHEN (i = "100") ELSE
        "00001000" WHEN (i = "011") ELSE
        "00000100" WHEN (i = "010") ELSE
        "00000010" WHEN (i = "001") ELSE
        "00000001" WHEN (i = "000") ELSE
        "00000000";
end Datafl_1;

architecture Datafl_2 of decoder_3_8 is
SIGNAL buff: std_logic_vector(7 DOWNTO 0);
begin
    with i select buff <= 
        "10000000" WHEN "111",
        "01000000" WHEN "110",
        "00100000" WHEN "101",
        "00010000" WHEN "100",
        "00001000" WHEN "011",
        "00000100" WHEN "010",
        "00000010" WHEN "001",
        "00000001" WHEN "000",
        "00000000" WHEN OTHERS;
    with enable select o<=
        buff WHEN '1',
        "00000000" when OTHERS;
end datafl_2;

ARCHITECTURE Behav_1 of decoder_3_8 IS
BEGIN
    process(i, enable)
    begin
        IF (enable='1') THEN
            IF (i = "111") THEN o <= "10000000";
            ELSIF (i = "110") THEN o <= "01000000";
            ELSIF (i = "101") THEN o <= "00100000";
            ELSIF (i = "100") THEN o <= "00010000";
            ELSIF (i = "011") THEN o <= "00001000";
            ELSIF (i = "010") THEN o <= "00000100";
            ELSIF (i = "001") THEN o <= "00000010";
            ELSIF (i = "000") THEN o <= "00000001";
            END IF;
        ELSE o <= "00000000";
        END IF;
    end process;
END Behav_1;


ARCHITECTURE Behav_2 OF decoder_3_8 IS
BEGIN
    process(i, enable)
    begin
    CASE i IS
        WHEN ("111") => o <= "10000000";
        WHEN ("110") => o <= "01000000";
        WHEN ("101") => o <= "00100000";
        WHEN ("100") => o <= "00010000";
        WHEN ("011") => o <= "00001000";
        WHEN ("010") => o <= "00000100";
        WHEN ("001") => o <= "00000010";
        WHEN ("000") => o <= "00000001";
        WHEN OTHERS => o <= "00000000";
    END CASE;
    IF NOT(enable='1') THEN o<="00000000"; END IF;
    
    end process;
END Behav_2;