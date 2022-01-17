library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sequence_detector is port (
    value: in std_logic_vector(0 to 3);
    clk: in std_logic
);
end;

architecture behavioural_sequence_detector of sequence_detector is
begin
    process(clk)
        variable counter : integer range 0 to 3;
        variable state : std_logic_vector(0 to 2) := "000";
        variable finished : boolean;
    begin
        case value is
            when "0001" =>
                report "button 1 pressed";
                if state = "000" then
                    report "state 000 to state 001";
                    state := "001";
                end if;
            when "0010" =>
                report "button 2 pressed";
                if state = "010" then
                    report "state 010 to state 011";
                    state := "011";
                end if;
            when "0100" =>
                report "button 3 pressed";
                if state = "011" then
                    report "state 011 to state 100";
                    state := "100";
                elsif state = "100" then
                    report "state 100 to state done";
                    report "DONE!!";
                    finished := True;
                end if;
            when "1000" =>
                report "button 4 pressed";
                if state = "001" then
                    report "state 001 to state 010";
                    state := "010";
                end if;
            when others =>
                report "invalid button press :P";
        end case;
    end process;
end;