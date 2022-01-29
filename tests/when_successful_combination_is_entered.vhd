library vunit_lib;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use vunit_lib.run_pkg.all;
use work.sequence_state_util_pkg.all;

entity when_successful_combination_is_entered_tb is
	generic (runner_cfg : string := "");
end;

architecture behavioural_when_successful_combination_is_entered_tb of when_successful_combination_is_entered_tb is

    component sequence_detector port (
        buttons: in std_logic_vector(0 to 3);
        buttons_stable: in std_logic;
        output_state: out out_state_enum;
        internal_state: buffer std_logic_vector(0 to 2)
    );
    end component;

    signal buttons: std_logic_vector(0 to 3) := "0000";
    signal buttons_stable: std_logic := '0';
    signal started: std_logic := '0';
    signal output_state: out_state_enum := neutral;

begin

    sut: sequence_detector port map (
        buttons => buttons,
        buttons_stable => buttons_stable,
        output_state => output_state
    );
    
    buttons_stable <= not buttons_stable after 20 ns when started = '1';
    
    test_runner : process
    begin
		test_runner_setup(runner, runner_cfg);
		started <= '1';
        assert output_state = neutral;
        wait for 40.1 ns;
        buttons <= "0001";
        wait for 40.1 ns;
        buttons <= "1000";
        wait for 40.1 ns;
        buttons <= "0010";
        wait for 40.1 ns;
        buttons <= "0100";
        wait for 40.1 ns;
        buttons <= "0100";
        wait for 80.1 ns;
        assert output_state = finished;
        started <= '0';
		test_runner_cleanup(runner);
		wait;
    end process;
end;