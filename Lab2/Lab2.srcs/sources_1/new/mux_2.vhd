----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/04/2022 04:56:47 PM
-- Design Name: 
-- Module Name: mux_2 - Struct
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


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_2 is
    Port ( i1, i0 : in STD_LOGIC;
           s :  in STD_LOGIC;
           o : out STD_LOGIC);
end mux_2;

architecture Struct of mux_2 is
COMPONENT And2 IS
    PORT(x,y: IN std_logic;
        F: OUT std_logic);
END COMPONENT;

COMPONENT Or2 IS
    PORT(x,y: IN std_logic;
    F: OUT std_logic);
END COMPONENT;

COMPONENT Inv IS
    PORT (x: IN std_logic;
    F: OUT std_logic);
END COMPONENT;

SIGNAL n0, n1, n2: std_logic;

BEGIN
    o<= (i1 and s) or (i0 and NOT s);
END Struct;
