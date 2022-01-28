library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sequence_state_util_pkg.all;
use work.string_util_pkg.all;
use work.log_util_pkg.all;

entity sequence_detector is port (
    buttons: in std_logic_vector(0 to 3) := "0000";
    buttons_stable: in std_logic := '0';
    reset: in std_logic := '0';
    output_state: buffer out_state_enum := neutral;
    internal_state: buffer std_logic_vector(0 to 2) := "000"
);
end;

architecture behavioural_sequence_detector of sequence_detector is
    signal finished_state : std_logic := '0';
    signal button_pressed : std_logic := '0';
begin
    process(buttons_stable, reset)
        variable finished_state : std_logic := '0';
        variable button_pressed : std_logic := '0';
        variable sequence_detector_out : sequence_state_dto := (
            next_state => "000",
            button_pressed => '0',
            finished => '0'
        );
        variable count : integer := 0;
    begin
        if rising_edge(buttons_stable) then
            if output_state = neutral then
                sequence_detector_out := get_next_state(internal_state, buttons);
                internal_state <= sequence_detector_out.next_state;
                button_pressed := sequence_detector_out.button_pressed;
                finished_state := sequence_detector_out.finished;
                if button_pressed = '1' then
                    count := count + 1;
                end if;
            else
            end if;
            log("state: "&std_logic_vector_to_string(internal_state));
            if finished_state = '1' then
                output_state <= finished;
            end if;
            if count > 12 then
                output_state <= locked;
            end if;
            log(" === buttons-state: "&std_logic_vector_to_string(buttons(2)&buttons(1)&buttons(0)));
            log(" === output-state: "&out_state_enum'image(output_state));
            log(" === buttons-count: "&integer'image(count));
            log(" === button-pressed: "&std_Logic'image(button_pressed));
            log_line(" === buttons: "&std_logic_vector_to_string(buttons));
        end if;
        if reset = '1' then
            internal_state <= "000";
            output_state <= neutral;
            count := 0;
            finished_state := '0';
        end if;
    end process;
end;