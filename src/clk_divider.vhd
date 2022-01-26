library ieee;
use ieee.std_logic_1164.all;
use work.log_util_pkg.all;

entity clk_divider is
    Port ( clk : in  std_logic := '0';
           divided_ammount : in integer := 0;
           clk_divided : out std_logic := '0' );
end;

architecture behavioral_clk_divider of clk_divider is
    signal count : integer := 0;
    signal clk_divided_state : std_logic := '0';
begin
    clk_divided <= clk_divided_state;
    process (clk)
    begin
        if rising_edge(clk) then
            log("count: "&integer'image(count));
            log_line(" === clk_divided_state: "&std_logic'image(clk_divided_state));
            if count = divided_ammount then
                clk_divided_state <= not clk_divided_state;
                count <= 0;
            else
                count <= count + 1;
            end if;
        end if;
    end process;
end;