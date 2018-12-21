LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_CD_clock_divider IS
END tb_CD_clock_divider;
 
ARCHITECTURE behavior OF tb_CD_clock_divider IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CD_clock_divider
    PORT(
         clk      : in  STD_LOGIC;
         reset    : in  STD_LOGIC;
         enable   : in  STD_LOGIC;
         load     : in  STD_LOGIC;
         stop_en  : in  STD_LOGIC;
         set_sec_dig1 : in STD_LOGIC_VECTOR(3 downto 0);
         set_sec_dig2 : in STD_LOGIC_VECTOR(3 downto 0);
         set_min_dig1 : in STD_LOGIC_VECTOR(3 downto 0);
         set_min_dig2 : in STD_LOGIC_VECTOR(3 downto 0);
         sec_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
         sec_dig2 : out STD_LOGIC_VECTOR(3 downto 0);
         min_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
         min_dig2 : out STD_LOGIC_VECTOR(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk    : STD_LOGIC := '0';
   signal reset  : STD_LOGIC := '0';
   signal enable : STD_LOGIC := '0';
   signal load   : STD_LOGIC := '0';
   signal stop_en : STD_LOGIC := '0';
   signal set_sec_dig1 : STD_LOGIC_VECTOR(3 downto 0) := "0000";
   signal set_sec_dig2 : STD_LOGIC_VECTOR(3 downto 0) := "0000";
   signal set_min_dig1 : STD_LOGIC_VECTOR(3 downto 0) := "0000";
   signal set_min_dig2 : STD_LOGIC_VECTOR(3 downto 0) := "0000";

    --Outputs
   signal sec_dig1 : STD_LOGIC_VECTOR(3 downto 0);
   signal sec_dig2 : STD_LOGIC_VECTOR(3 downto 0);
   signal min_dig1 : STD_LOGIC_VECTOR(3 downto 0);
   signal min_dig2 : STD_LOGIC_VECTOR(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
   -- Instantiate the Unit Under Test (UUT)
   uut: CD_clock_divider 
   PORT MAP (
              clk      => clk,
              reset    => reset,
              enable   => enable,
              load     => load,
              stop_en  => stop_en,
              set_sec_dig1 => set_sec_dig1,
              set_sec_dig2 => set_sec_dig2,
              set_min_dig1 => set_min_dig1,
              set_min_dig2 => set_min_dig2,
              sec_dig1 => sec_dig1,
              sec_dig2 => sec_dig2,
              min_dig1 => min_dig1,
              min_dig2 => min_dig2
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
