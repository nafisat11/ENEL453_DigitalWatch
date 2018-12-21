-- This file needs editing by students
-- Note, you must also create a test tench for this module.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sw_lap_multiplexor is
  PORT ( 
          l_seconds:            in   STD_LOGIC_VECTOR(3 downto 0);
          l_tens_seconds:       in   STD_LOGIC_VECTOR(3 downto 0);
          l_minutes:            in   STD_LOGIC_VECTOR(3 downto 0);
          l_tens_minutes:       in   STD_LOGIC_VECTOR(3 downto 0);
          seconds :             in   STD_LOGIC_VECTOR(3 downto 0);
          tens_seconds:         in   STD_LOGIC_VECTOR(3 downto 0);
          minutes:              in   STD_LOGIC_VECTOR(3 downto 0);
          tens_minutes:         in   STD_LOGIC_VECTOR(3 downto 0);
          selector:             in   STD_LOGIC;
          m_seconds:            out  STD_LOGIC_VECTOR(3 downto 0);
          m_tens_seconds:       out  STD_LOGIC_VECTOR(3 downto 0);
          m_minutes:            out  STD_LOGIC_VECTOR(3 downto 0);
          m_tens_minutes:       out  STD_LOGIC_VECTOR(3 downto 0)
        );
end sw_lap_multiplexor;


architecture Behavioral of sw_lap_multiplexor is

BEGIN
 
process(selector, l_tens_minutes, l_minutes, l_tens_seconds, l_seconds, tens_minutes, minutes, tens_seconds, seconds)
    begin
        case selector is
        when '1' => m_tens_minutes <= l_tens_minutes;
                    m_minutes      <= l_minutes;
                    m_tens_seconds <= l_tens_seconds;
                    m_seconds      <= l_seconds;
        when others => m_tens_minutes <= tens_minutes;
                       m_minutes      <= minutes;
                       m_tens_seconds <= tens_seconds;
                       m_seconds      <= seconds;
        end case;
    end process;

END Behavioral;
