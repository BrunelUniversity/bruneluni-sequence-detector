library vunit_lib;
context vunit_lib.vunit_context;

entity tb_example is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_example is
	component sequence_detector_sim
    end component;
begin
  sut : sequence_detector_sim;
  main : process
  begin
    test_runner_setup(runner, runner_cfg);
    report "Hello world!";
	assert false;
    test_runner_cleanup(runner);
  end process;
end architecture;