library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sequence_state_util_pkg.all;
use work.string_util_pkg.all;
use work.log_util_pkg.all;

entity sequence_detector is port (
    buttons: in std_logic_vector(0 to 3) := "0000";
    clk: in std_logic := '0';
    output_state: out std_logic_vector(0 to 1) := "00"
);
end;

architecture behavioural_sequence_detector of sequence_detector is
    signal state : std_logic_vector(0 to 2) := "000";
    signal finished : std_logic := '0';
    signal button_pressed : std_logic := '0';
    signal count : integer := 0;
begin
    process(clk)
        variable sequence_detector_out : sequence_state_dto := (
            next_state => "000",
            button_pressed => '0',
            finished => '0'
        );
    begin
        if rising_edge(clk) then
            if finished = '1' then
                output_state <= "10";
            end if;
            if button_pressed = '1' then
                count <= count + 1;
            end if;
            if count = 12 then
                output_state <= "01";
            end if;
            log_info("state: "&std_logic_vector_to_string(state)&" === buttons: "&std_logic_vector_to_string(buttons));
            sequence_detector_out := get_next_state(state, buttons);
            state <= sequence_detector_out.next_state;
            button_pressed <= sequence_detector_out.button_pressed;
            finished <= sequence_detector_out.finished;
        end if;
    end process;
end;