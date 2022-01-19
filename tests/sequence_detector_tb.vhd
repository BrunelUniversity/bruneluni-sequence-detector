library vunit_lib;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use vunit_lib.run_pkg.all;

entity sequence_detector_tb is
	generic (runner_cfg : string := "");
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

    test_runner : process
    begin
        started <= true;
		test_runner_setup(runner, runner_cfg);
        assert output_state = "00";
        wait for 210 ns;
        assert output_state = "10";
		test_runner_cleanup(runner);
		started <= false;
		wait;
    end process;
    
    clk <= not clk after 20 ns when started else '0';

    buttons_change : process
    begin
        if(started) then
            buttons <= "0001";
            wait for 41 ns;
            buttons <= "1000";
            wait for 41 ns;
            buttons <= "0010";
            wait for 41 ns;
            buttons <= "0100";
            wait for 41 ns;
            buttons <= "0100";
            wait for 41 ns;
        end if;
    end process;
end;