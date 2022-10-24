LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY synchronous_counter IS
	GENERIC(N: integer := 16);
	PORT(
	clk, RSTn, clear, en, UDn: IN std_logic;
	value: OUT std_logic_vector(N-1 DOWNTO 0)
	);
BEGIN
END synchronous_counter;



architecture behav of synchronous_counter is
	signal Q: unsigned(N-1 DOWNTO 0);
begin

	sequential_logic : process( clk, RSTn)
	begin
		if RSTn = '0' then
			value <= (OTHERS => '0');
		elsif rising_edge(clk) then
			if clear='1' then
				value <= (OTHERS => '0');
			elsif UDn = '1' AND en = '1' then
				Q <= Q-1;
			elsif UDn = '0' AND en = '1' then
			 	Q <= Q+1;
			end if; --clear logic
		end if ; -- rst logic
		value <= std_logic_vector(Q);
	end process ; -- sequential_logic

end behav ; -- behav