library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.string_util_pkg.all;

package math_util_pkg is
    function is_power_of_2(vector: std_logic_vector(0 to 3)) return boolean;
end;
package body math_util_pkg is
    function is_power_of_2(vector: std_logic_vector(0 to 3)) return boolean is
        variable vector_minus_1 : std_logic_vector(0 to 3) := "0000";
        variable vectors_anded : std_logic_vector(0 to 3) := "0000";
        variable vectors_anded_equals_0 : boolean := false;
        variable vector_is_not_0 : boolean := false;
    begin
        vector_is_not_0 := not ( vector = "0000" );
        vector_minus_1 := std_logic_vector( unsigned( vector ) - 1 );
        vectors_anded := vector_minus_1 and vector;
        vectors_anded_equals_0 := vectors_anded = "0000";
        return vectors_anded_equals_0 and vector_is_not_0;
    end function;
end package body;
