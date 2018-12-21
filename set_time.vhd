library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity set_time is
    PORT ( clk      : in  STD_LOGIC;
           reset    : in  STD_LOGIC;
           enable   : in  STD_LOGIC;
           digit    : in  STD_LOGIC_VECTOR(3 downto 0);
           incr_sec_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
           incr_sec_dig2 : out STD_LOGIC_VECTOR(3 downto 0);
           incr_min_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
           incr_min_dig2 : out STD_LOGIC_VECTOR(3 downto 0)
           );
end set_time;

architecture Behavioral of set_time is
-- Signals:
signal hundredhertz : STD_LOGIC;
signal onehertz, tensseconds, onesminutes, singlesec : STD_LOGIC;
signal singleSeconds, singleMinutes : STD_LOGIC_VECTOR(3 downto 0);
signal tenSeconds, tensMinutes : STD_LOGIC_VECTOR(3 downto 0);


component upcounter is
   Generic (  period : integer:= 4;
              WIDTH  : integer:= 3
           );
      PORT ( clk    : in  STD_LOGIC;
             reset  : in  STD_LOGIC;
             enable : in  STD_LOGIC;
             zero   : out STD_LOGIC;
             value  : out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
           );
end component;

component increment is
   Generic (  period : integer:= 4;
              WIDTH  : integer:= 3
           );
      PORT ( clk    : in  STD_LOGIC;
             reset  : in  STD_LOGIC;
             enable : in  STD_LOGIC;
             set    : in  STD_LOGIC;
             zero   : out STD_LOGIC;
             value  : out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
           );
end component;

BEGIN
  
   oneHzClock: upcounter
   generic map(
               period => 100000000,   -- divide by 100_000_000 to divide 100 MHz down to 1 Hz 
               WIDTH  => 28             -- 28 bits are required to hold the binary value of 101111101011110000100000000
              )
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => enable,
               zero   => onehertz, -- this is a 1 Hz clock signal
               value  => open  -- Leave open since we won't display this value
            );
            
   singleSecondsClock: increment
   generic map(
               period => (10),   -- Counts numbers between 0 and 9 -> that's 10 values!
               WIDTH  => 4
              )
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => onehertz,
               set    => digit(0),
               zero   => open,
               value  => singleSeconds -- binary value of seconds we decode to drive the 7-segment display        
            );
   
-- Students fill in the VHDL code between these two lines
-- The missing code is instantiations of upcounter (like above) as needed.
-- Take a hint from the clock_divider entity description's port map.
--==============================================

tensSecondsClock: increment
generic map(
               period => (6),   -- Counts numbers between 0 and 5 -> that's 6 values!
               WIDTH  => 4
            )
PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => onehertz,
               set    => digit(1),
               zero   => open,
               value  => tenSeconds -- binary value of tens seconds we decode to drive the 7-segment display        
          );
            
singleMinutesClock: increment
generic map(
               period => (10),   -- Counts numbers between 0 and 9 -> that's 10 values!
               WIDTH  => 4
            )
PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => onehertz,
               set    => digit(2),
               zero   => open,
               value  => singleMinutes -- binary value of seconds we decode to drive the 7-segment display        
          );
tensMinutesClock: increment
generic map(
               period => (6),   -- Counts numbers between 0 and 5 -> that's 6 values!
               WIDTH  => 4
            )
PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => onehertz,
               set    => digit(3),
               zero   => open,
               value  => tensMinutes -- binary value of seconds we decode to drive the 7-segment display        
          );
 

--============================================== 
   
   -- Connect internal signals to outputs
   incr_sec_dig1 <= singleSeconds;
   incr_sec_dig2 <= tenSeconds;
   incr_min_dig1 <= singleMinutes;
   incr_min_dig2 <= tensMinutes;

END Behavioral;