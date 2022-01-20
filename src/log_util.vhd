library ieee;
use ieee.std_logic_1164.all;

package log_util_pkg is
    procedure log_info
        (msg : in string);
end;

package body log_util_pkg is
    procedure log_info
        (msg : in string) is  
    begin
        report "=====================================";
        report msg;
        report "=====================================";
    end;
end;
