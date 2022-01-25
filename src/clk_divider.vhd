library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity clk_divider is
    Port ( clk : in  std_logic;
           divided_ammount : in integer;
           clk_divided : out std_logic := '0' );
end;

architecture behavioral_clk_divider of clk_divider is
    signal count : integer;
    signal clk_divided_state : std_logic := '0';
begin
    clk_divided <= clk_divided_state;
    process (clk)
    begin
        if (clk'event and count = divided_ammount) then
            count <= count + 1;
            clk_divided_state <= not clk_divided_state;
        end if;
    end process;
end;