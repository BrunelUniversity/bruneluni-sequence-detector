library vunit_lib;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use vunit_lib.run_pkg.all;

entity when_buttons_are_not_stable_tb is
	generic (runner_cfg : string := "");
end;

architecture behavioural_when_buttons_are_not_stable_tb of when_buttons_are_not_stable_tb is

    component switch_debouncer port (
        clk: in std_logic;
        btn: in integer range 0 to 5;
        buttons_stable: out std_logic
    );
    end component;

    signal btn: integer range 0 to 5;
    signal clk: std_logic := '0';
    signal started: std_logic := '0';
    signal buttons_stable: std_logic := '0';

begin

    sut: switch_debouncer port map (
        btn => btn,
        clk => clk,
        buttons_stable => buttons_stable
    );
    
    clk <= not clk after 20 ns when started = '1';
    
    test_runner : process
    begin
		test_runner_setup(runner, runner_cfg);
		started <= '1';
        assert buttons_stable = '0';
        btn <= 1;
        wait for 20.1 ns;
        assert buttons_stable = '0';
        wait for 20.1 ns;
        assert buttons_stable = '0';
		test_runner_cleanup(runner);
		wait;
    end process;
end;