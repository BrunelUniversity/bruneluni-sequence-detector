library ieee;
use ieee.std_logic_1164.all;
use work.math_util_pkg.all;
use work.log_util_pkg.all;
use work.increment_state_pkg.all;

package sequence_state_util_pkg is
    type out_state is (locked, neutral, finished);
    type sequence_state_dto is record
        next_state : std_logic_vector(0 to 2);
        button_pressed : std_logic;
        finished : std_logic;
    end record;
    function get_next_state(state: std_logic_vector(0 to 2) := "000";
        buttons: std_logic_vector(0 to 3) := "0000") return sequence_state_dto;
end;
package body sequence_state_util_pkg is
    function get_next_state(state: std_logic_vector(0 to 2) := "000";
        buttons: std_logic_vector(0 to 3) := "0000") return sequence_state_dto is
        variable next_state: std_logic_vector(0 to 2) := state;
        variable button_pressed: std_logic := '0';
        variable finished: std_logic := '0';
    begin
        if is_power_of_2(buttons) then
            button_pressed := '1';
            case buttons is
                when "0001" | "1000" => next_state := increment_state(state, buttons(2)&buttons(1)&buttons(0));
                when "0010" => next_state := increment_state(state, "010");
                when "0100" =>
                    if state = "011" then
                        next_state := "100";
                    elsif state = "100" then
                        finished := '1';
                    else
                        next_state := "000";
                    end if;
                when others =>
            end case;
        end if;
        return (
            next_state => next_state,
            button_pressed => button_pressed,
            finished => finished
        );
    end function;
end package body;