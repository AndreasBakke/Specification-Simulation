----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/05/2022 08:46:06 PM
-- Design Name: 
-- Module Name: decoder_3_8_tb - beh
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

entity decoder_3_8_tb is
--  Port ( );
end decoder_3_8_tb;


architecture beh of decoder_3_8_tb is
COMPONENT decoder_3_8 is
    PORT(enable: IN std_logic;
        i: IN std_logic_vector(2 DOWNTO 0);
        o: OUT std_logic_vector(7 DOWNTO 0));
end component;

SIGNAL i_s: std_logic_vector (2 DOWNTO 0);
signal o_s: std_logic_vector (7 DOWNTO 0);
SIGNAL enable_s: std_logic;

begin
    comp_to_test: entity work.decoder_3_8(Behav_2) PORT MAP(enable_s, i_s, o_s);
    process
    begin
    i_s <= "000"; enable_s<= 'Z';
    WAIT FOR 10 ns;
    i_s <= "001"; 
    wait for 10 ns;
    i_s <= "010"; enable_s <= '0';
    wait for 10 ns;
    i_s <= "011";
    wait for 10 ns;
    i_s <= "100";
    wait for 10 ns;
    i_s <= "101"; enable_s <= '1';
    wait for 10 ns;
    i_s <= "110";
    wait for 10 ns;
    i_s <= "111";
    wait;
    end process;
end beh;
