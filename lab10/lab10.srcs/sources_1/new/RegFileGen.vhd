LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY RegFileGen IS
    PORT(
    clk, RSTn: IN std_logic;
    w_data: IN std_logic_vector(3 downto 0);
    w_en: IN std_logic;
    w_addr: IN std_logic_vector(1 downto 0);
    r_addr0: IN std_logic_vector(1 downto 0);
    r_data0: OUT std_logic_vector(3 downto 0)
    );
END RegFileGen;


ARCHITECTURE Behav of RegFileGen IS
    TYPE regFile IS ARRAY(0 TO 3) OF std_logic_vector(3 downto 0);
    signal currRegister, nextRegister: regFile := (Others =>(OTHERS => '0'));
BEGIN
    registerPRocess: PROCESS(clk, RSTn)
    BEGIN
        IF RSTn = '1' THEN
            currRegister <= (Others =>(Others => '1'));
        ELSIF rising_Edge(clk) THEN
            currRegister <= nextRegister;
        END IF;
    END PROCESS;
    
    CombLogic: PROCESS(currRegister, w_data, w_en, w_addr, r_addr0)
    BEGIN
        IF w_en = '1' THEN
            nextRegister(to_integer(unsigned(w_addr))) <= w_data;
        ELSE
            nextRegister <= currRegister;
        END IF;
    END PROCESS;


    r_data0 <= currRegister(to_integer(unsigned(r_addr0)));
END Behav;