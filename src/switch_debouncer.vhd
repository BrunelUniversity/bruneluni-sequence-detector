library ieee;
use ieee.std_logic_1164.all;
use work.log_util_pkg.all;
use work.string_util_pkg.all;

entity switch_debouncer is Port (
    clk: in std_logic := '0';
    buttons: in std_logic_vector(0 to 3) := "0000";
    buttons_stable: buffer std_logic := '0'
);
end;

architecture behavioral_switch_debouncer of switch_debouncer is
begin
    process(clk)
        variable last_buttons: std_logic_vector(0 to 3) := "0000";
        variable last_last_buttons: std_logic_vector(0 to 3) := "0000";
        variable clk_count: integer:=0;
    begin
        if rising_edge(clk) then
            if(buttons = last_buttons) and (not(last_last_buttons = buttons)) then
                buttons_stable <= '1';
                last_last_buttons := buttons;
            else
                buttons_stable <= '0';
            end if;
            last_buttons:=buttons;
        end if;
    end process;
end;
