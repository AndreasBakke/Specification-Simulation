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

ENTITY priority_encoder_4_2_tb IS
--  Port ( );
END priority_encoder_4_2_tb;


ARCHITECTURE beh OF priority_encoder_4_2_tb IS
COMPONENT encoder_4_2_tb IS
    PORT(req: IN std_logic_vector(3 DOWNTO 0);
        o: OUT std_logic_vector(1 DOWNTO 0);
        active: OUT std_logic);
end component;

SIGNAL req_s: std_logic_vector (3 DOWNTO 0);
SIGNAL o_s: std_logic_vector (1 DOWNTO 0);
SIGNAL active_s: std_logic;

begin
    comp_to_test: entity work.priority_encoder_4_2(Datafl_2) PORT MAP(req_s, o_s, active_S);
    process
    begin
    req_s <= "0000";
    WAIT FOR 10 ns;
    req_s <= "0001"; 
    wait for 10 ns;
    req_s <= "0010";
    wait for 10 ns;
    req_s <= "0100";
     wait for 10 ns;
    req_s <= "1100";
    wait for 10 ns;
    req_s <= "1000";
    wait;
    end process;
end beh;
