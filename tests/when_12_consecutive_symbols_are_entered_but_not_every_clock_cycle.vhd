library vunit_lib;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use vunit_lib.run_pkg.all;

entity when_12_consecutive_symbols_are_entered_but_not_every_clock_cycle_tb is
	generic (runner_cfg : string := "");
end;

architecture behavioural_when_12_consecutive_symbols_are_entered_but_not_every_clock_cycle_tb of when_12_consecutive_symbols_are_entered_but_not_every_clock_cycle_tb is

    component sequence_detector port (
        buttons: in std_logic_vector(0 to 3);
        clk: in std_logic;
        output_state: out std_logic_vector(0 to 1)
    );
    end component;

    signal buttons: std_logic_vector(0 to 3) := "0000";
    signal clk: std_logic := '0';
    signal started: std_logic := '0';
    signal output_state: std_logic_vector(0 to 1) := "00";

begin

    sut: sequence_detector port map (
        buttons => buttons,
        clk => clk,
        output_state => output_state
    );
    
    clk <= not clk after 20 ns when started = '1';
    
    test_runner : process
    begin
		test_runner_setup(runner, runner_cfg);
		started <= '1';
        assert output_state = "00";
        wait for 40.1 ns;
        buttons <= "0001";
        wait for 40.1 ns;
        buttons <= "1000";
        wait for 40.1 ns;
        buttons <= "0010";
        wait for 40.1 ns;
        buttons <= "0100";
        wait for 40.1 ns;
        buttons <= "0000";
        wait for 40.1 ns;
        buttons <= "0000";
        wait for 40.1 ns;
        buttons <= "0110";
        wait for 40.1 ns;
        buttons <= "1110";
        wait for 40.1 ns;
        buttons <= "1111";
        wait for 40.1 ns;
        buttons <= "0000";
        wait for 40.1 ns;
        buttons <= "0000";
        wait for 40.1 ns;
        buttons <= "0000";
        wait for 40.1 ns;
        buttons <= "0000";
        wait for 40.1 ns;
        buttons <= "0000";
        wait for 40.1 ns;
        buttons <= "0100";
        wait for 80.1 ns;
        assert output_state = "10";
        started <= '0';
		test_runner_cleanup(runner);
		wait;
    end process;
end;