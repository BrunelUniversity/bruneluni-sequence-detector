library ieee;
use ieee.std_logic_1164.all;
package sequence_detection_pkg is
    function sequence_detector(state: std_logic_vector(0 to 2) := "000";
        buttons: std_logic_vector(0 to 3) := "0000") return std_logic_vector;
end;
package body sequence_detection_pkg is
    function sequence_detector(state: std_logic_vector(0 to 2) := "000";
        buttons: std_logic_vector(0 to 3) := "0000") return std_logic_vector is
        variable next_state: std_logic_vector(0 to 2);
        variable button_pressed: std_logic := '0';
        variable finished: std_logic := '0';
    begin
        case buttons is
            when "0001" =>
                report "button 1 pressed";
                button_pressed := '1';
                if state = "000" then
                    report "state 000 to state 001";
                    next_state := "001";
                else
                    next_state := "000";
                end if;
            when "0010" =>
                report "button 2 pressed";
                button_pressed := '1';
                if state = "010" then
                    report "state 010 to state 011";
                    next_state := "011";
                else
                    next_state := "000";
                end if;
            when "0100" =>
                report "button 3 pressed";
                button_pressed := '1';
                if state = "011" then
                    report "state 011 to state 100";
                    next_state := "100";
                elsif state = "100" then
                    report "state 100 to state done";
                    report "DONE!!";
                    finished := '1';
                else
                    next_state := "000";
                end if;
            when "1000" =>
                report "button 4 pressed";
                button_pressed := '1';
                if state = "001" then
                    report "state 001 to state 010";
                    next_state := "010";
                else
                    next_state := "000";
                end if;
            when others =>
                report "no button button pressed";
        end case;
        return next_state&button_pressed&finished;
    end function;
end package body;
