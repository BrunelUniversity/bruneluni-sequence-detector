library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity sequence_detector_tb is
end;

architecture behavioural_sequence_detector_tb of sequence_detector_tb is

  component sequence_detector port (
      value: in std_logic_vector(0 to 3);
      clk: in std_logic
  );
  end component;

  signal value: std_logic_vector(0 to 3);
  signal clk: std_logic;
  signal started: boolean := false;

begin

  uut: sequence_detector port map ( value => value,
                                   clk   => clk );

  clk <= not clk after 20ns when started else '0';

  stimulus: process
  begin
    
    value <= "0001";
    started <= true;
    wait for 22 ns;
    value <= "1000";
    wait for 22 ns;
    value <= "0010";
    wait for 22 ns;
    value <= "0100";
    wait for 22 ns;
    value <= "0100";
    wait for 22 ns;
    started <= false;
    
    wait;
  end process;

end;