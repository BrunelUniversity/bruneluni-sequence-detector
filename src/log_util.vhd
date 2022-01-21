library ieee;
use ieee.std_logic_1164.all;
use STD.textio.all;

package log_util_pkg is
    procedure log_line
        (msg : in string);
    procedure log
        (msg : in string);
end;

package body log_util_pkg is
    procedure log_line
        (msg : in string) is
    begin
        write(OUTPUT, msg&" === time: "&time'image(now)&LF);
    end;
        procedure log
        (msg : in string) is
    begin
        write(OUTPUT, msg);
    end;
end;
