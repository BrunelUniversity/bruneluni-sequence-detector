library ieee;
use ieee.std_logic_1164.all;

entity sequence_detector is
    Port (
            buttons: in std_logic_vector(0 to 3);
            finished: out std_logic;
            button_pressed: out std_logic;
            clk: in std_logic
        );
end sequence_detector;

architecture behavioral_sequence_detector of sequence_detector is
    signal state : std_logic_vector(0 to 2);
begin
    process(clk)
    begin
        case buttons is
            when "0001" =>
                report "button 1 pressed";
                button_pressed <= '1';
                if state = "000" then
                    report "state 000 to state 001";
                    state <= "001";
                else
                    state <= "000";
                end if;
            when "0010" =>
                report "button 2 pressed";
                button_pressed <= '1';
                if state = "010" then
                    report "state 010 to state 011";
                    state <= "011";
                else
                    state <= "000";
                end if;
            when "0100" =>
                report "button 3 pressed";
                button_pressed <= '1';
                if state = "011" then
                    report "state 011 to state 100";
                    state <= "100";
                elsif state = "100" then
                    report "state 100 to state done";
                    report "DONE!!";
                    finished <= '1';
                else
                    state <= "000";
                end if;
            when "1000" =>
                report "button 4 pressed";
                button_pressed <= '1';
                if state = "001" then
                    report "state 001 to state 010";
                    state <= "010";
                else
                    state <= "000";
                end if;
            when others =>
                button_pressed <= '0';
                report "no button button pressed";
        end case;
    end process;
end;
