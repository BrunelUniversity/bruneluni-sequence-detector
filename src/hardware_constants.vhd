library ieee;
use ieee.std_logic_1164.all;

package hardware_constants_pkg is
    constant MAIN_CLK_PERIOD: integer;
    constant LIGHT_CLK_PERIOD: integer;
    constant UART_CLK_PERIOD: integer;
end;

package body hardware_constants_pkg is
    constant MAIN_CLK_PERIOD: integer := 1000000;
    constant LIGHT_CLK_PERIOD: integer := 25000000;
    constant UART_CLK_PERIOD: integer := 50000;
end;
