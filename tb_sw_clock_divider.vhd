LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_sw_clock_divider IS
END tb_sw_clock_divider;
 
ARCHITECTURE behavior OF tb_sw_clock_divider IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sw_clock_divider
    PORT(
         clk      : IN  STD_LOGIC;
         reset    : IN  STD_LOGIC;
         enable   : in  STD_LOGIC;
         seconds : OUT STD_LOGIC_VECTOR(3 downto 0);
         tens_seconds : OUT STD_LOGIC_VECTOR(3 downto 0);
         minutes : OUT STD_LOGIC_VECTOR(3 downto 0);
         tens_minutes : OUT STD_LOGIC_VECTOR(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk    : STD_LOGIC := '0';
   signal reset  : STD_LOGIC := '0';
   signal enable : STD_LOGIC := '0';

    --Outputs
   signal seconds : STD_LOGIC_VECTOR(3 downto 0);
   signal tens_seconds : STD_LOGIC_VECTOR(3 downto 0);
   signal minutes : STD_LOGIC_VECTOR(3 downto 0);
   signal tens_minutes : STD_LOGIC_VECTOR(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
   -- Instantiate the Unit Under Test (UUT)
   uut: sw_clock_divider 
   PORT MAP (
              clk      => clk,
              reset    => reset,
              enable   => enable,
              seconds => seconds,
              tens_seconds => tens_seconds,
              minutes => minutes,
              tens_minutes => tens_minutes
            );

   -- Clock process definitions
   clk_process :process
   begin
      clk <= '0';
      wait for clk_period/2;
      clk <= '1';
      wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin      
      -- hold reset state for 100 ns.
      reset <= '1';
      wait for 100 ns;   
      reset <= '0';
      wait for clk_period*10;

      -- insert stimulus here 
      enable <= '0';
      wait for clk_period*10;
      enable <= '1';
      wait for clk_period*10;
      enable <= '0';
      wait for clk_period*10;
      enable <= '1';
      wait;
   end process;

END;
