library ieee;
use ieee.std_logic_1164.all;
use work.log_util_pkg.all;

entity switch_debouncer is Port (
    clk: in std_logic;
    btn: in integer range 0 to 5;
    buttons_stable: inout bit
);
end;

architecture behavioral_switch_debouncer of switch_debouncer is
begin
    process(clk)
        variable last_buttons: integer range 0 to 4:=0 ;
        variable clk_count: integer:=0;
        variable last_stable_buttons: integer range 0 to 4:=0;
    begin
        if rising_edge(clk) then
            log("last_buttons: "&integer'image(last_buttons));
            log(" === current_buttons: "&integer'image(btn));
            log(" === clk_count: "&integer'image(clk_count));
            log(" === last_stable_buttons: "&integer'image(last_stable_buttons));
            log(" === not_stable_buttons_equal_buttons: "&boolean'image(((last_stable_buttons=btn))));
            log_line(" === btn_stable: "&bit'image(buttons_stable));
            buttons_stable<='0';
            if clk_count=1 then
                if ((btn = last_buttons) and (not(last_stable_buttons=btn))) then
                    clk_count:=0;
                    buttons_stable<='1';
                    last_stable_buttons:=btn;
                end if;
            end if;
            last_buttons:=btn;
            if last_stable_buttons=btn and clk_count=1 then
                clk_count:=0;
            else
                clk_count:=clk_count+1;
            end if;
        end if;
    end process;
end;
