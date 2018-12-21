-- This file needs editing by students
-- Note, you must also create a test tench for this module.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity digit_multiplexor is
  PORT ( 
          m_seconds   : in  STD_LOGIC_VECTOR(3 downto 0);
          m_tens_seconds   : in  STD_LOGIC_VECTOR(3 downto 0);
          m_minutes   : in  STD_LOGIC_VECTOR(3 downto 0);
          m_tens_minutes   : in  STD_LOGIC_VECTOR(3 downto 0);
          selector   : in  STD_LOGIC_VECTOR(3 downto 0);
          time_digit : out STD_LOGIC_VECTOR(3 downto 0)
        );
end digit_multiplexor;

architecture Behavioral of digit_multiplexor is

BEGIN
   -- Mux to choose a digit to display, strobe one digit on at a time
   -- as controlled by the selector input (this is the multiplexer control
   -- signal). The multiplexer then choses which of the four 4-bit buses 
   -- (sec_dig1, sec_dig2, min_dig1, min_dig2) to output as time_digit.

-- Students fill in the VHDL code between these two lines
-- The missing code is a process that defines the required behavior of this module.
--==============================================
with selector select
    time_digit <= m_tens_minutes when "1000",
                  m_minutes when "0100",
                  m_tens_seconds when "0010",
                  m_seconds when "0001",
                  "0000" when others;
--============================================== 

END Behavioral;
