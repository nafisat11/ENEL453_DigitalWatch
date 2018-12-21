library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity output_multiplexor is
  PORT ( 
          sw_seconds:           in   STD_LOGIC_VECTOR(3 downto 0);
          sw_tens_seconds:      in   STD_LOGIC_VECTOR(3 downto 0);
          sw_minutes:           in   STD_LOGIC_VECTOR(3 downto 0);
          sw_tens_minutes:      in   STD_LOGIC_VECTOR(3 downto 0);
          cd_seconds :          in   STD_LOGIC_VECTOR(3 downto 0);
          cd_tens_seconds:      in   STD_LOGIC_VECTOR(3 downto 0);
          cd_minutes:           in   STD_LOGIC_VECTOR(3 downto 0);
          cd_tens_minutes:      in   STD_LOGIC_VECTOR(3 downto 0);
          selector:             in   STD_LOGIC;
          o_seconds:            out  STD_LOGIC_VECTOR(3 downto 0);
          o_tens_seconds:       out  STD_LOGIC_VECTOR(3 downto 0);
          o_minutes:            out  STD_LOGIC_VECTOR(3 downto 0);
          o_tens_minutes:       out  STD_LOGIC_VECTOR(3 downto 0)
        );
end output_multiplexor;


architecture Behavioral of output_multiplexor is

BEGIN
 
process(selector, cd_tens_minutes, cd_minutes, cd_tens_seconds, cd_seconds, sw_tens_minutes, sw_minutes, sw_tens_seconds, sw_seconds)
    begin
        case selector is
        when '1' => o_tens_minutes <= cd_tens_minutes;
                    o_minutes      <= cd_minutes;
                    o_tens_seconds <= cd_tens_seconds;
                    o_seconds      <= cd_seconds;
        when others => o_tens_minutes <= sw_tens_minutes;
                       o_minutes      <= sw_minutes;
                       o_tens_seconds <= sw_tens_seconds;
                       o_seconds      <= sw_seconds;
        end case;
    end process;

END Behavioral;
