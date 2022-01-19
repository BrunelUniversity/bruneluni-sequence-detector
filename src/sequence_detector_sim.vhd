library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sequence_detector_sim is
end;

architecture behavioural_sequence_detector_sim of sequence_detector_sim is

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

    clk <= not clk after 20 ns when started else '0';

    stimulus: process
    begin
        buttons <= "0001";
        started <= true;
        wait for 41 ns;
        assert output_state = "10";
        buttons <= "1000";
        wait for 41 ns;
        assert output_state = "10";
        buttons <= "0010";
        wait for 41 ns;
        assert output_state = "10";
        buttons <= "0100";
        wait for 41 ns;
        assert output_state = "00";
        buttons <= "0100";
        wait for 41 ns;
        assert output_state = "00";
        wait for 41 ns;
        started <= false;
        wait;
    end process;
end;