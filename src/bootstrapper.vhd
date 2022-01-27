library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sequence_state_util_pkg.all;

entity bootstrapper is Port (
    clk: in std_logic := '0';
    btnc: in std_logic := '0';
    btnd: in std_logic := '0';
    btnl: in std_logic := '0';
    btnr: in std_logic := '0';
    btnu: in std_logic := '0'
);
end;

architecture behavioral_bootstrapper of bootstrapper is
    signal divided_clk : std_logic := '0';
    signal buttons_stable : std_logic := '0';
    signal output_state : out_state_enum := neutral;
    signal buttons: std_logic_vector(0 to 3) := btnl&btnu&btnr&btnd;
    
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
    
    component clk_divider port (
        clk : in  std_logic;
        divided_ammount : in integer;
        clk_divided : out std_logic := '0' );
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
    
    main_clk_divider: clk_divider port map (
        divided_ammount => 15000000,
        clk => clk,
        clk_divided => divided_clk
    );

    process(divided_clk)
    begin
        if rising_edge(divided_clk) then
            -- do stuff
        end if;
    end process;

end;
