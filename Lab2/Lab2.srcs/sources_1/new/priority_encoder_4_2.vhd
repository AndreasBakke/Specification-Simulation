library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY priority_encoder_4_2 IS
    PORT(req: IN std_logic_vector(3 DOWNTO 0);
        o: OUT std_logic_vector(1 DOWNTO 0);
        active: OUT std_logic);
BEGIN
END priority_encoder_4_2;



ARCHITECTURE Datafl_1 OF priority_encoder_4_2 IS
BEGIN

    o <= "11" WHEN (req(3)='1') ELSE 
        "10" WHEN (req(2) = '1') ELSE
        "01" WHEN (req(1) = '1') ELSE
        "00" WHEN (req(0) = '1') ELSE
        "00";
        
    active <= '1' WHEN (req="0001") ELSE
        '0';
END Datafl_1;

ARCHITECTURE Datafl_2 OF priority_encoder_4_2 IS
BEGIN
    WITH req SELECT o<=
        "00" WHEN "0001",
        "01" WHEN "001-",
        "10" WHEN "01--",
        "11" WHEN "1---",
        "00" WHEN OTHERS;
    WITH req SELECT
        active <='1' WHEN "0001",
            '0' WHEN OTHERS; 
END Datafl_2;


ARCHITECTURE Behav_1 OF priority_encoder_4_2 IS
BEGIN
    PROCESS(req)
    BEGIN
        IF (req(3)='1')     THEN o<="11"; active <='0';
        ELSIF (req(2)='1')  THEN o<="10"; active <='0';
        ELSIF (req(1)='1')  THEN o<="01"; active <='0';
        ELSIF (req(0)='1')  THEN o<="00"; active <='1';
        ELSE                     o<="00"; active <='0';
        END IF;
    END PROCESS;
END Behav_1;


ARCHITECTURE Behav_2 OF priority_encoder_4_2 IS
BEGIN
    PROCESS(req)
    BEGIN
    CASE req IS
        WHEN "1---" => o <= "11"; active <='0';
        WHEN "01--" => o <= "10"; active <='0';
        WHEN "001-" => o <= "01"; active <='0';
        WHEN "0001" => o <= "00"; active <='1';
        WHEN OTHERS => o <= "00"; active <='0';
    END CASE;
    END PROCESS;
END Behav_2;