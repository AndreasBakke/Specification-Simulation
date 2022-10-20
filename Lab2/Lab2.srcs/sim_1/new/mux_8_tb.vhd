----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/05/2022 01:24:06 PM
-- Design Name: 
-- Module Name: mux_8_tb - 
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

entity testbench is
--  Port ( );
end testbench;

architecture beh of testbench is
COMPONENT mux_8 IS
    PORT(i: IN std_logic_vector(7 DOWNTO 0);
        s: IN std_logic_vector(2 DOWNTO 0);
        o: OUT std_logic);
END COMPONENT;

SIGNAL i_s: std_logic_vector(7 DOWNTO 0);
SIGNAL s_s: std_logic_vector(2 DOWNTO 0);
SIGNAL o_s: std_logic;

begin
    comp_to_test: entity work.mux_8(Datafl_1) PORT MAP ( i_s, s_s, o_s);
    PROCESS
    BEGIN
        i_s <= "00000001"; s_s <= "000";
        WAIT FOR 10 ns;
        i_s <= "00000010"; s_s <= "001";
        WAIT FOR 10 ns;
        i_s <= "00000100"; s_s <= "010";
        WAIT FOR 10 ns;
        i_s <= "00001000"; s_s <= "011";
        WAIT FOR 10 ns;
        i_s <= "00010000"; s_s <= "100";
        WAIT FOR 10 ns;
        i_s <= "00100000"; s_s <= "101";
        WAIT FOR 10 ns;
        i_s <= "01000000"; s_s <= "110";
        WAIT FOR 10 ns;
        i_s <= "10000000"; s_s <= "111";
        
        WAIT;
    END PROCESS;
end beh;
