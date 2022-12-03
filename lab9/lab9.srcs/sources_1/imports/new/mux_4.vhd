----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/04/2022 04:52:31 PM
-- Design Name: 
-- Module Name: mux_4 - Behav
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

entity mux_4 is
    Port ( i : in STD_LOGIC_VECTOR (3 downto 0);
           s : in STD_LOGIC_VECTOR (1 downto 0);
           o : out STD_LOGIC);
end mux_4;


architecture Behav of mux_4 is
BEGIN
    PROCESS (s,i)
    BEGIN
        CASE s IS
            WHEN "11" => o <= i(3);
            WHEN "10" => o <= i(2);
            WHEN "01" => o <= i(1);
            WHEN OTHERS => o <= i(0);
        END CASE;
    END PROCESS;
END Behav;
