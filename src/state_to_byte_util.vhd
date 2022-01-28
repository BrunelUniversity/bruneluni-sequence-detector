library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.string_util_pkg.all;
use work.sequence_state_util_pkg.all;

package state_to_byte_util_pkg is
    function output_state_to_byte(out_state: out_state_enum) return std_logic_vector;
    function internal_state_to_byte(internal_state: std_logic_vector(0 to 2)) return std_logic_vector;
    function buttons_to_byte(buttons: std_logic_vector(0 to 3)) return std_logic_vector;
    function buttons_pressed_to_byte(buttons_pressed: std_logic) return std_logic_vector;
    function reverse_any_vector (a: in std_logic_vector) return std_logic_vector;
end;
package body state_to_byte_util_pkg is
    function output_state_to_byte(out_state: out_state_enum) return std_logic_vector is
    begin
        case out_state is
            when locked => return "000000000";
            when neutral => return "001000000";
            when finished => return "010000000";
            when others => return "000010000";
        end case;
    end function;
    function internal_state_to_byte(internal_state: std_logic_vector(0 to 2)) return std_logic_vector is
    begin
        return '0'&reverse_any_vector(internal_state)&"00000";
    end function;
    function buttons_to_byte(buttons: std_logic_vector(0 to 3)) return std_logic_vector is
    begin
        return '0'&reverse_any_vector(buttons)&"0000";
    end function;
    function buttons_pressed_to_byte(buttons_pressed: std_logic) return std_logic_vector is
    begin
        case buttons_pressed is
            when '0' => return "000000000";
            when '1' => return "010000000";
            when others => return "000010000";
        end case;
    end function;
    function reverse_any_vector(a: in std_logic_vector) return std_logic_vector is
        variable result: std_logic_vector(a'RANGE);
        alias aa: std_logic_vector(a'REVERSE_RANGE) is a;
    begin
        for i in aa'RANGE loop
            result(i) := aa(i);
        end loop;
        return result;
    end;
end package body;
