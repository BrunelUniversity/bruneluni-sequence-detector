library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sequence_state_util_pkg.all;

entity bootstrapper is Port (
    clk: in std_logic := '0';
    buttons: in std_logic_vector(0 to 3) := "0000";
    led: out std_logic := '0'
);
end;

architecture behavioral_bootstrapper of bootstrapper is
    signal divided_clk : std_logic := '0';
    signal buttons_stable : std_logic := '0';
    signal output_state : out_state_enum := neutral;
    
    component switch_debouncer port (
        clk: in std_logic;
        btn: in integer range 0 to 5;
        buttons_stable: out std_logic
    );
    end component;
    
    component sequence_detector port (
        buttons: in std_logic_vector(0 to 3);
        buttons_stable: in std_logic;
        output_state: out out_state_enum
    );
    end component;
    
begin
    debouncer: switch_debouncer port map (
        btn => to_integer(signed(buttons)),
        clk => clk,
        buttons_stable => buttons_stable
    );

    detector: sequence_detector port map (
        buttons => buttons,
        buttons_stable => buttons_stable,
        output_state => output_state
    );

    process(divided_clk)
    begin
        if rising_edge(divided_clk) then
            -- do stuff
        end if;
    end process;

end;
