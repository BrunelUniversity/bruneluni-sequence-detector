library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sequence_detector_sim is port(
    assertion: out std_logic
);
end;

architecture behavioural_sequence_detector_sim of sequence_detector_sim is

    component bootstrapper port (
        buttons: in std_logic_vector(0 to 3);
        clk: in std_logic;
        output_state: out std_logic_vector(0 to 1)
    );
    end component;

    signal buttons: std_logic_vector(0 to 3);
    signal clk: std_logic;
    signal started: boolean := false;
    signal output_state: std_logic_vector(0 to 1);

begin

    sut: bootstrapper port map (
        buttons => buttons,
        clk => clk,
        output_state => output_state
    );

    clk <= not clk after 20 ns when started else '0';

    stimulus: process
    begin
		assertion <= false;
        buttons <= "0001";
        started <= true;
        wait for 41 ns;
        if not output_state = "10" then
			assertion <= true;
		end if;
        buttons <= "1000";
        wait for 41 ns;
		if not output_state = "10" then
			assertion <= true;
		end if;
        buttons <= "0010";
        wait for 41 ns;
		if not output_state = "10" then
			assertion <= true;
		end if;
        buttons <= "0100";
        wait for 41 ns;
		if not output_state = "10" then
			assertion <= true;
		end if;
        buttons <= "0100";
        wait for 41 ns;
		if not output_state = "00" then
			assertion <= true;
		end if;
        wait for 41 ns;
        started <= false;
        wait;
    end process;
end;