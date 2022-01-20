library ieee;
use ieee.std_logic_1164.all;
package sequence_detection_pkg is
    function sequence_detector(state: std_logic_vector(0 to 2) := "000";
        buttons: std_logic_vector(0 to 3) := "0000") return std_logic_vector;
end;
package body sequence_detection_pkg is
    function sequence_detector(state: std_logic_vector(0 to 2) := "000";
        buttons: std_logic_vector(0 to 3) := "0000") return std_logic_vector is
        variable next_state: std_logic_vector(0 to 2) := "000";
        variable button_pressed: std_logic := '0';
        variable finished: std_logic := '0';
    begin
        case buttons is
            when "0001" =>
                button_pressed := '1';
                if state = "000" then
                    next_state := "001";
                else
                    next_state := "000";
                end if;
            when "0010" =>
                button_pressed := '1';
                if state = "010" then
                    next_state := "011";
                else
                    next_state := "000";
                end if;
            when "0100" =>
                button_pressed := '1';
                if state = "011" then
                    next_state := "100";
                elsif state = "100" then
                    finished := '1';
                else
                    next_state := "000";
                end if;
            when "1000" =>
                button_pressed := '1';
                if state = "001" then
                    next_state := "010";
                else
                    next_state := "000";
                end if;
            when others =>
        end case;
        return next_state&button_pressed&finished;
    end function;
end package body;