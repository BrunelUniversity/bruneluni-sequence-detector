library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SequenceDetector is port (
    value: in std_logic_vector(0 to 3);
    clk: in std_logic
);
end SequenceDetector;

architecture BehaviouralSequenceDetector of SequenceDetector is
begin
    process(clk)
        variable counter : integer range 0 to 3;
        variable state : std_logic_vector(0 to 2);
        variable finished : boolean;
    begin
        case value is
            when "0001" =>
                report "button 1 pressed";
                if state = "000" then
                    state := "001";
                end if;
            when "0010" =>
                report "button 2 pressed";
                if state = "010" then
                    state := "011";
                end if;
            when "0100" =>
                report "button 3 pressed";
                if state = "011" then
                    state := "100";
                elsif state = "100" then
                    report "DONE!!";
                    finished := True;
                end if;
            when "1000" =>
                report "button 4 pressed";
                if state = "001" then
                    state := "010";
                end if;
            when others =>
                report "invalid button press :P";
        end case;
    end process;
end BehaviouralSequenceDetector;