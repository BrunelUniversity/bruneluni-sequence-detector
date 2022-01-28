library ieee;
use ieee.std_logic_1164.all;
use work.sequence_state_util_pkg.all;
use work.state_to_byte_util_pkg.all;
use work.hardware_constants_pkg.all;

entity serial_logger is port (
    uart_divided_clk: in std_logic := '0';
    uart_send: out std_logic := '1';
    out_state: in out_state_enum := neutral;
    internal_state: in std_logic_vector(0 to 2) := "000";
    buttons: in std_logic_vector(0 to 3) := "0000";
    buttons_pressed: in std_logic := '0'
);
end;

architecture behavioral_serial_logger of serial_logger is
begin
    process(uart_divided_clk)
        variable data_index: integer := 0;
        variable log_count: integer := 0;
        variable wait_interval: integer := UART_CHAR_SPACE;
        variable resend: boolean := true;
        variable data: std_logic_vector(0 to 8) := "000000000";
    begin
        if rising_edge(uart_divided_clk) then
            case log_count is
                when 0 => data := output_state_to_byte(out_state);
                when 1 => data := internal_state_to_byte(internal_state);
                when 2 => data := buttons_to_byte(buttons);
                when 3 => data := buttons_pressed_to_byte(buttons_pressed);
                when others => data := "000111110";
            end case;
            resend := true;
            if data_index < 9 then
                uart_send <= data(data_index);
            elsif data_index = 9 then
                uart_send <= '1';
            end if;
            if data_index > wait_interval then
                if wait_interval = UART_CHAR_SPACE then
                    log_count := log_count + 1;
                else
                    wait_interval := UART_CHAR_SPACE;
                    log_count := 0;
                end if;
                if log_count = 4 then
                    wait_interval := UART_WORD_SPACE;
                end if;
                data_index := 0;
                resend := false;
            end if;
            if resend = true then
                data_index := data_index + 1;
            end if;
        end if;
    end process;
end;
