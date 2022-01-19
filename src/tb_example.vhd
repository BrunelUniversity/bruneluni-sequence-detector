library vunit_lib;
context vunit_lib.vunit_context;

entity tb_example is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_example is
	component sequence_detector_sim is port(
		assertion: out boolean
	);
    end component;
	signal assertion: boolean := false;
begin
  sut : sequence_detector_sim port map(assertion => assertion);
  main : process
  begin
    test_runner_setup(runner, runner_cfg);
    report "Hello world!";
	wait until 250 ns;
	assert not assertion;
    test_runner_cleanup(runner);
  end process;
end architecture;