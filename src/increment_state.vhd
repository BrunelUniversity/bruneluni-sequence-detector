library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.string_util_pkg.all;

package increment_state_pkg is
    function increment_state(state: std_logic_vector(0 to 2);
        state_to_check: std_logic_vector(0 to 2)) return std_logic_vector;
end;
package body increment_state_pkg is
    function increment_state(state: std_logic_vector(0 to 2);
        state_to_check: std_logic_vector(0 to 2)) return std_logic_vector is
    begin
        if state = state_to_check then
            return std_logic_vector( unsigned( state ) + 1 );
        else
            return "000";
        end if;
    end function;
end package body;
