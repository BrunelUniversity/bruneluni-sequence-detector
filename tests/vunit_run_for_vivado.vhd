library ieee;
use ieee.std_logic_1164.all;

package run_pkg is
    procedure test_runner_setup
        (runner : in string;
        runner_cfg : in string);
    procedure test_runner_cleanup
        (runner : in string);
    constant runner : string := "";
end;

package body run_pkg is
    procedure test_runner_setup
        (runner : in string;
        runner_cfg : in string) is  
    begin
    end;
        procedure test_runner_cleanup
        (runner : in string) is  
    begin
    end;
end;
