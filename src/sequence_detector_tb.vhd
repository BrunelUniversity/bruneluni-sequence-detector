library vunit_lib;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
context vunit_lib.vunit_context;

entity sequence_detector_tb is
	generic (runner_cfg : string);
end;

architecture behavoural_sequence_detector_tb of sequence_detector_tb is

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
		test_runner_setup(runner, runner_cfg);
        buttons <= "0001";
        started <= true;
        wait for 41 ns;
		assert output_state = "10";
        buttons <= "1000";
        wait for 41 ns;
		assert output_state = "10";
        buttons <= "0010";
        wait for 41 ns;
		assert output_state = "10";
        buttons <= "0100";
        wait for 41 ns;
		assert output_state = "10";
        buttons <= "0100";
        wait for 41 ns;
		assert output_state = "10";
		wait for 41 ns;
        started <= false;
		test_runner_cleanup(runner);
    end process;
end;