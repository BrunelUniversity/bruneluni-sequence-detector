library ieee;
use ieee.std_logic_1164.all;
use work.sequence_state_util_pkg.all;

entity light_flasher is port (
    clk: in std_logic := '0';
    reset: in std_logic := '0';
    out_state: in out_state_enum := neutral;
    led: buffer std_logic := '0'
);
end light_flasher;

architecture behavioral_light_flasher of light_flasher is
begin
    process(clk, reset)
        variable count: integer := 0;
    begin
        if rising_edge(clk) then
            if(not(out_state = neutral)) then
                if (out_state = locked) then
                    count := count + 1;
                end if;
                if (count <= 12) then
                    led <= not led;
                else
                    led <= '0';
                end if;
            end if;
        end if;
        if reset = '1' then
            led <= '0';
            count := 0;
        end if;
    end process;

end behavioral_light_flasher;
