entity tb_example is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_example is
begin
  main : process
  begin
    report "Hello world!";
    wait;
  end process;
end architecture;