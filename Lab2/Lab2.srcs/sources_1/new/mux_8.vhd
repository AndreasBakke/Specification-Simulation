----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/04/2022 04:08:39 PM
-- Design Name: 
-- Module Name: mux_8 - Datafl
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

ENTITY mux_8 IS
    PORT(i: IN std_logic_vector(7 DOWNTO 0);
        s: IN std_logic_vector(2 DOWNTO 0);
        o: OUT std_logic);
END mux_8;

ARCHITECTURE Datafl_1 OF mux_8 IS
BEGIN
   o    <=  i(7) WHEN (s = "111") ELSE
            i(6) WHEN (s = "110") ELSE
            i(5) WHEN (s = "101") ELSE
            i(4) WHEN (s = "100") ELSE
            i(3) WHEN (s = "011") ELSE
            i(2) WHEN (s = "010") ELSE
            i(1) WHEN (s = "001") ELSE
            i(0);
END Datafl_1;

ARCHITECTURE Datafl_2 of mux_8 IS
BEGIN
    WITH s SELECT
        o <= i(7) WHEN "111",
             i(6) WHEN "110",
             i(5) WHEN "101",
             i(4) WHEN "100",
             i(3) WHEN "011",
             i(2) WHEN "010",
             i(1) WHEN "001",
             i(0) WHEN OTHERS;
END Datafl_2;

ARCHITECTURE Behav_1 OF mux_8 IS
BEGIN
    PROCESS (s, i)
    BEGIN
        IF (s="111") THEN 
            o <= i(7);
        ELSIF (s="110") THEN 
            o <= i(6);
        ELSIF (s="101") THEN 
            o <= i(5);
        ELSIF (s="100") THEN 
            o <= i(4);
        ELSIF (s="011") THEN 
            o <= i(3);
        ELSIF (s="010") THEN 
            o <= i(2);
        ELSIF (s="001") THEN 
            o <= i(1);
        ELSE o <= i(0);
        END IF;
    END PROCESS;
END Behav_1;

ARCHITECTURE Behav_2 OF mux_8 IS
BEGIN
    PROCESS (s,i)
    BEGIN
        CASE s IS
            WHEN "111" => o <= i(7);
            WHEN "110" => o <= i(6);
            WHEN "101" => o <= i(5);
            WHEN "100" => o <= i(4);
            WHEN "011" => o <= i(3);
            WHEN "010" => o <= i(2);
            WHEN "001" => o <= i(1);
            WHEN OTHERS => o <= i(0);
        END CASE;
    END PROCESS;
END Behav_2;


ARCHITECTURE Struct OF mux_8 IS
COMPONENT mux_4 IS
    PORT(i: IN std_logic_vector(3 DOWNTO 0);
        s: IN std_logic_vector(1 DOWNTO 0);
        o: OUT std_logic);
END COMPONENT;

COMPONENT mux_2 IS
    PORT(i1, i0: IN std_logic;
         s: IN std_logic;
         o: OUT std_logic);
END COMPONENT;

SIGNAL n: std_logic_vector(3 DOWNTO 0);

BEGIN
    mux_2_3: mux_2 PORT MAP(i(7), i(6), s(0), n(3));
    mux_2_2: mux_2 PORT MAP(i(5), i(4), s(0), n(2));
    mux_2_1: mux_2 PORT MAP(i(3), i(2), s(0), n(1));
    mux_2_0: mux_2 PORT MAP(i(1), i(0), s(0), n(0));
    mux_4_1: mux_4 PORT MAP(n, s(2 DOWNTO 1), o);
END Struct;