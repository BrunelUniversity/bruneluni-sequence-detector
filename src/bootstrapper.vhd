library ieee;
use ieee.std_logic_1164.all;

entity bootstrapper is Port (
    clk: in std_logic := '0';
    buttons: in std_logic_vector(0 to 3) := "0000";
    led: out std_logic := '0'
);
end;

architecture behavioral_bootstrapper of bootstrapper is
    -- TODO: implement
begin
end;
