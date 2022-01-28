library vunit_lib;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use vunit_lib.run_pkg.all;

entity when_button_is_held_down_tb is
	generic (runner_cfg : string := "");
end;

architecture behavioural_when_button_is_held_down_tb of when_button_is_held_down_tb is

        component switch_debouncer port (
        clk: in std_logic;
        buttons: in std_logic_vector(0 to 3);
        buttons_stable: buffer std_logic
    );
    end component;

    signal buttons: std_logic_vector(0 to 3) := "0000";
    signal clk: std_logic := '0';
    signal started: std_logic := '0';
    signal buttons_stable: std_logic := '0';

begin

    sut: switch_debouncer port map (
        buttons => buttons,
        clk => clk,
        buttons_stable => buttons_stable
    );
    
    clk <= not clk after 20 ns when started = '1';
    
    test_runner : process
    begin
		test_runner_setup(runner, runner_cfg);
		started <= '1';
        assert buttons_stable = '0';
        buttons <= "0001";
        wait for 20.1 ns;
        assert buttons_stable = '0';
        wait for 20.1 ns;
        assert buttons_stable = '0';
        wait for 20.1 ns;
        assert buttons_stable = '1';
        wait for 20.1 ns;
        assert buttons_stable = '1';
        wait for 20.1 ns;
        assert buttons_stable = '0';
        wait for 20.1 ns;
        assert buttons_stable = '0';
        wait for 200.1 ns;
        assert buttons_stable = '0';
		test_runner_cleanup(runner);
		wait;
    end process;
end;