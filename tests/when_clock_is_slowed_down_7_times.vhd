library vunit_lib;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use vunit_lib.run_pkg.all;

entity when_clock_is_slowed_down_7_times_tb is
	generic (runner_cfg : string := "");
end;

architecture behavioural_when_clock_is_slowed_down_7_times_tb of when_clock_is_slowed_down_7_times_tb is

    component clk_divider port (
        clk : in  std_logic;
        divided_ammount : in integer;
        clk_divided : out std_logic := '0' );
    end component;

    signal clk : std_logic := '0';
    signal divided_ammount : integer := 6;
    signal clk_divided : std_logic := '0';
    signal started : std_logic := '0';

begin

    sut: clk_divider port map (
        divided_ammount => divided_ammount,
        clk => clk,
        clk_divided => clk_divided
    );
    
    clk <= not clk after 20 ns when started = '1';
    
    test_runner : process
    begin
		test_runner_setup(runner, runner_cfg);
		started <= '1';
        assert clk_divided = '0';wait for 20 ns;
        assert clk_divided = '0';wait for 40 ns;
        assert clk_divided = '0';wait for 40 ns;
        assert clk_divided = '0';wait for 40 ns;
        assert clk_divided = '0';wait for 40 ns;
        assert clk_divided = '0';wait for 40 ns;
        assert clk_divided = '0';wait for 40.1 ns;
        assert clk_divided = '1';wait for 40 ns;
        assert clk_divided = '1';wait for 40 ns;
        assert clk_divided = '1';wait for 40 ns;
        assert clk_divided = '1';wait for 40 ns;
        assert clk_divided = '1';wait for 40 ns;
        assert clk_divided = '1';wait for 40 ns;
        assert clk_divided = '1';wait for 40 ns;
        assert clk_divided = '0';wait for 40 ns;
        assert clk_divided = '0';wait for 40 ns;
		test_runner_cleanup(runner);
		wait;
    end process;
end;