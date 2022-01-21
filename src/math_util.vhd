library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
package math_util_pkg is
    function is_power_of_2(vector: std_logic_vector(0 to 3)) return boolean;
end;
package body math_util_pkg is
    function is_power_of_2(vector: std_logic_vector(0 to 3)) return boolean is
    begin
        return ( not vector = "0000" ) and ( ( vector and ( vector - "1" ) ) = "0000" );
    end function;
end package body;
