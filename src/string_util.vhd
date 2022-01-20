library ieee;
use ieee.std_logic_1164.all;
package string_util_pkg is
    function std_logic_vector_to_string(vector: std_logic_vector) return string;
end;
package body string_util_pkg is
    function std_logic_vector_to_string(vector: std_logic_vector) return string is
        variable vector_string : string (vector'length-1 downto 1) := (others => NUL);
    begin
        for i in vector'length-1 downto 1 loop
            vector_string(i) := std_logic'image(vector((i-1)))(2);
        end loop;
    return vector_string;
end function;
end package body;
