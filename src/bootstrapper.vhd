library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sequence_detection_pkg.all;

entity bootstrapper is port (
    buttons: in std_logic_vector(0 to 3) := "0000";
    clk: in std_logic := '0';
    output_state: out std_logic_vector(0 to 1) := "00"
);
end;

architecture behavioural_bootstrapper of bootstrapper is
    signal state : std_logic_vector(0 to 2) := "000";
    signal finished : std_logic := '0';
    signal button_pressed : std_logic := '0';
    signal count : integer := 0;
begin
    process(clk)
        variable sequence_detector_out : std_logic_vector(0 to 4) := "00000";
    begin
        if finished = '1' then
            output_state <= "10";
        end if;
        if rising_edge(clk) then
            sequence_detector_out := sequence_detector(state, buttons);
            state <= sequence_detector_out(0 to 2);
            button_pressed <= sequence_detector_out(3);
            finished <= sequence_detector_out(4);
        end if;
    end process;
end;