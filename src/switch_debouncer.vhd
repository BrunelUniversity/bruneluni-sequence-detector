library ieee;
use ieee.std_logic_1164.all;

entity switch_debouncer is Port (
    clk: in std_logic;
    btn: in integer range 0 to 5;
    buttons_stable: out bit
);
end;

architecture behavioral_switch_debouncer of switch_debouncer is

begin
    process(clk, btn)
        variable last_buttons: integer range 0 to 4:=0 ;
        variable clk_count: integer range 0 to 1:=0;
        variable last_stable_buttons: integer range 0 to 4:=0;
        variable btn_var: integer range 0 to 4:=0;
        variable btn_stable: bit:='0';
    begin
    btn_var:=btn;
    if rising_edge(clk) then
        if clk_count=1 then
            if (btn_var = last_buttons and last_stable_buttons/=btn) then
            btn_stable:='1';
            last_stable_buttons:=btn_var;
            clk_count:=0;
            last_buttons:=btn_var;
            clk_count:=clk_count+1;
            end if;
        end if;
    end if;
    buttons_stable<=btn_stable;
    end process;
end;
