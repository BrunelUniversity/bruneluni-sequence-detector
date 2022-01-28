library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sequence_state_util_pkg.all;
use work.hardware_constants_pkg.all;

entity bootstrapper is Port (
    clk: in std_logic := '0';
    buttons: in std_logic_vector(0 to 3) := "0000";
    reset: in std_logic := '0';
    led: buffer std_logic_vector(0 to 7) := "00000000"
);
end;

architecture behavioral_bootstrapper of bootstrapper is
    signal divided_clk : std_logic := '0';
    signal light_divided_clk : std_logic := '0';
    signal buttons_stable : std_logic := '0';
    signal output_state : out_state_enum := neutral;
    signal led_flash : std_logic := '0';
    signal internal_state: std_logic_vector(0 to 2) := "000";
    
    component switch_debouncer port (
        clk: in std_logic := '0';
        buttons: in std_logic_vector(0 to 3) := "0000";
        buttons_stable: buffer std_logic := '0'
    );
    end component;
    
    component light_flasher port (
        clk: in std_logic := '0';
        reset: in std_logic := '0';
        out_state: in out_state_enum := locked;
        led: buffer std_logic := '0'
    );
    end component;
    
    component sequence_detector port (
        buttons: in std_logic_vector(0 to 3);
        buttons_stable: in std_logic;
        reset: in std_logic;
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
        buttons => buttons,
        clk => divided_clk,
        buttons_stable => buttons_stable
    );

    detector: sequence_detector port map (
        buttons => buttons,
        buttons_stable => buttons_stable,
        reset => reset,
        output_state => output_state
    );
    
    main_clk_divider: clk_divider port map (
        divided_ammount => MAIN_CLK_PERIOD,
        clk => clk,
        clk_divided => divided_clk
    );
    
    light_clk_divider: clk_divider port map (
        divided_ammount => LIGHT_CLK_PERIOD,
        clk => clk,
        clk_divided => light_divided_clk
    );
    
    flasher: light_flasher port map (
        clk => light_divided_clk,
        reset => reset,
        out_state => output_state,
        led => led_flash
    );
    
    led <= "11111111" when led_flash = '1' else "00000000";

    process(light_divided_clk)
    begin
        -- TODO: add UART logging
    end process;
end;
