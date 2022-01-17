library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bootstrapper is port (
    buttons: in std_logic_vector(0 to 3);
    clk: in std_logic;
    output_state: out std_logic_vector(0 to 1)
);
end;

architecture behavioural_bootstrapper of bootstrapper is
    signal state : std_logic_vector(0 to 2) := "000";
    signal finished : std_logic := '0';
    signal button_pressed : std_logic := '0';
    signal count : integer := 0;
    
    component sequence_detector port (
        buttons: in std_logic_vector(0 to 3);
        finished: out std_logic;
        button_pressed: out std_logic;
        clk: in std_logic
    );
    end component;
    
begin
    detector: sequence_detector port map (
        buttons => buttons,
        finished => finished,
        button_pressed => button_pressed,
        clk => clk
    );
    process(clk)
    begin
        if count = 12 then
            output_state <= "01";
        end if;
        if finished = '1' then
            output_state <= "10";
        end if;
        if button_pressed = '1' then
            count <= count + 1;
        end if;
        report "tick";
    end process;
end;