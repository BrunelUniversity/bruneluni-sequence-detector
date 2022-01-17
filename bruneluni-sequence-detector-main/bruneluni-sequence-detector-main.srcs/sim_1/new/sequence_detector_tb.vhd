library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity SequenceDetectorTb is
end;

architecture BehaviouralSequenceDetectorTb of SequenceDetectorTb is

  component SequenceDetector port (
      value: in std_logic_vector(0 to 3);
      clk: in std_logic
  );
  end component;

  signal value: std_logic_vector(0 to 3);
  signal clk: std_logic ;

begin

  uut: SequenceDetector port map ( value => value,
                                   clk   => clk );

  stimulus: process
  begin
    
    clk <= '0', '1' after 10 ns, '0' after 10 ns, '1' after 10 ns, '0' after 10 ns, '1' after 10 ns, '0' after 10 ns, '1' after 10 ns, '0' after 10 ns, '1' after 10 ns;
    value <= "0000", "0001" after 15 ns, "1000" after 15 ns, "0010" after 15 ns, "0100" after 15 ns, "0100" after 15 ns;

    wait;
  end process;


end;