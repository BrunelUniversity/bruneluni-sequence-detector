library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sequence_state_util_pkg.all;
use work.hardware_constants_pkg.all;

entity bootstrapper is Port (
    clk: in std_logic := '0';
    buttons: in std_logic_vector(0 to 3) := "0000";
    reset: in std_logic := '0';
    uart_send: out std_logic := '1';
    led: buffer std_logic_vector(0 to 7) := "00000000"
);
end;

architecture behavioral_bootstrapper of bootstrapper is
    signal divided_clk : std_logic := '0';
    signal slow_divided_clk : std_logic := '0';
    signal uart_divided_clk : std_logic := '0';
    signal buttons_stable : std_logic := '0';
    signal output_state : out_state_enum := neutral;
    signal led_flash : std_logic := '0';
    signal internal_state: std_logic_vector(0 to 2) := "000";
    
    component serial_logger port (
        uart_divided_clk: in std_logic;
        uart_send: out std_logic;
        out_state: in out_state_enum;
        internal_state: in std_logic_vector(0 to 2);
        buttons: in std_logic_vector(0 to 3);
        buttons_pressed: in std_logic
    );
    end component;
    
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
        output_state: out out_state_enum;
        internal_state: buffer std_logic_vector(0 to 2)
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
        output_state => output_state,
        internal_state => internal_state
    );
    
    main_clk_divider: clk_divider port map (
        divided_ammount => MAIN_CLK_PERIOD,
        clk => clk,
        clk_divided => divided_clk
    );
    
    slow_clk_divider: clk_divider port map (
        divided_ammount => LIGHT_CLK_PERIOD,
        clk => clk,
        clk_divided => slow_divided_clk
    );
    
    uart_clk_divider: clk_divider port map (
        divided_ammount => UART_CLK_PERIOD,
        clk => clk,
        clk_divided => uart_divided_clk
    );
    
    flasher: light_flasher port map (
        clk => slow_divided_clk,
        reset => reset,
        out_state => output_state,
        led => led_flash
    );
    
    logger: serial_logger port map (
        uart_divided_clk => uart_divided_clk,
        uart_send => uart_send,
        out_state => output_state,
        internal_state => internal_state,
        buttons => buttons,
        buttons_pressed => buttons_stable
    );
    
    led <= "11111111" when led_flash = '1' else "00000000";
end;
