library ieee;
use ieee.std_logic_1164.all;

package hardware_constants_pkg is
    constant MAIN_CLK_PERIOD: integer;
    constant LIGHT_CLK_PERIOD: integer;
end;

package body hardware_constants_pkg is
    constant MAIN_CLK_PERIOD: integer := 500000;
    constant LIGHT_CLK_PERIOD: integer := 250000000;
end;
