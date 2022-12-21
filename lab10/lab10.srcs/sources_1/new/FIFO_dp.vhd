LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY FIFO_dp IS
    GENERIC(
        N: positive := 4; --data width
        M: positive := 8 --2^M locations
    );
    
    PORT(
        w_data: IN std_logic_vector(N-1 DOWNTO 0);
        r_data: OUT std_logic_vector(N-1 downto 0);
        w_en: IN std_logic;
        w_addr, r_addr: IN std_logic_vector(M-1 downto 0);
        clk: IN std_logic
    );
BEGIN
END FIFO_dp;



ARCHITECTURE Behav of FIFO_dp IS
    Type RegisterType IS ARRAY(2**M -1 DOWNTO 0) OF std_logic_vector(N-1 downto 0);
    SIGNAL RegisterFile, nextRegister: RegisterType := (OTHERS => (OTHERS =>'0'));
BEGIN
    regUpdate: PROCESS(clk)
    BEGIN
        IF rising_edge(clk) THEN
            RegisterFile <= nextRegister;
        END IF;
    END PROCESS;
    
    combLogic: PROCESS(RegisterFile, w_data, w_en, w_addr, r_addr)
    BEGIN
        IF w_en = '1' THEN --should only write if w_en is 1
            nextRegister(to_integer(unsigned(w_addr))) <= w_data;
        ELSE
            nextRegister <= RegisterFile;
        END IF;
        --r_data <= RegisterFile(to_integer(unsigned(r_addr)));
        --nextRegister(to_integer(unsigned(r_addr))) <= (Others =>'Z');
    END PROCESS;
    
     r_data <= RegisterFile(to_integer(unsigned(r_addr))); --We can make this fully combinatorial as adress will be handleded by controller not user.
    --Assumption: We dont delete from register file, but simply overwrite. The items are removed from queue, not from registerfile.

END Behav;

