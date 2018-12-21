LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_Digital_Clock_top_level IS
END tb_Digital_Clock_top_level;
 
ARCHITECTURE behavior OF tb_Digital_Clock_top_level IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Digital_Clock_top_level
    PORT(
               clk      : in  STD_LOGIC;
               reset    : in  STD_LOGIC;
               CD_START : in  STD_LOGIC;
               SW_START : in  STD_LOGIC;
               LOAD     : in  STD_LOGIC;
               LAP_TIME : in  STD_LOGIC;
               MODE     : in  STD_LOGIC;
               CA       : out STD_LOGIC;
               CB       : out STD_LOGIC;
               CC       : out STD_LOGIC;
               CD       : out STD_LOGIC;
               CE       : out STD_LOGIC;
               CF       : out STD_LOGIC;
               CG       : out STD_LOGIC;
               DP       : out STD_LOGIC;
               AN1      : out STD_LOGIC;
               AN2      : out STD_LOGIC;
               AN3      : out STD_LOGIC;
               AN4      : out STD_LOGIC;
               led      : out STD_LOGIC_VECTOR(15 downto 0);
               time_digit : in STD_LOGIC_VECTOR(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i   : STD_LOGIC := '0';
   signal reset_i : STD_LOGIC := '0';
   signal CD_START_i : STD_LOGIC := '0';
   signal SW_START_i : STD_LOGIC := '0';
   signal LOAD_i : STD_LOGIC := '0';
   signal LAP_TIME_i : STD_LOGIC := '0';
   signal MODE_i : STD_LOGIC := '0';
   signal time_digit_i : STD_LOGIC_VECTOR(3 downto 0) := "0000";

    --Outputs
   signal CA_i  : STD_LOGIC;
   signal CB_i  : STD_LOGIC;
   signal CC_i  : STD_LOGIC;
   signal CD_i  : STD_LOGIC;
   signal CE_i  : STD_LOGIC;
   signal CF_i  : STD_LOGIC;
   signal CG_i  : STD_LOGIC;
   signal DP_i  : STD_LOGIC;
   signal AN1_i : STD_LOGIC;
   signal AN2_i : STD_LOGIC;
   signal AN3_i : STD_LOGIC;
   signal AN4_i : STD_LOGIC;
   signal led_i : STD_LOGIC_VECTOR(15 downto 0);
   
   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
   -- Instantiate the Unit Under Test (UUT)
   uut: Digital_Clock_top_level
   PORT MAP (
              clk      => clk_i,
              reset    => reset_i,
              CD_START => CD_START_i,
              SW_START => SW_START_i,
              LOAD     => LOAD_i,
              LAP_TIME => LAP_TIME_i,
              MODE     => MODE_i,
              CA       => CA_i,
              CB       => CB_i,
              CC       => CC_i,
              CD       => CD_i,
              CE       => CE_i,
              CF       => CF_i,
              CG       => CG_i,
              DP       => DP_i,
              AN1      => AN1_i,
              AN2      => AN2_i,
              AN3      => AN3_i,
              AN4      => AN4_i,
              led      => led_i,
              time_digit => time_digit_i
            );

   -- Clock process definitions
   clk_process :process
   begin
      clk_i <= '0';
      wait for clk_period/2;
      clk_i <= '1';
      wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin      
      -- hold reset state for 100 ns.
      reset_i <= '1';
      wait for 100 ns;   
      reset_i <= '0';
      wait for clk_period*10;

      -- insert stimulus here
      MODE_i <= '0';
      LOAD_i <= '0'; 
      CD_START_i <= '0';
      SW_START_i <= '1';
      wait for clk_period*10;
      LAP_TIME_i <= '1';
      wait for clk_period*10;
      
      SW_START_i <= '0';
      LAP_TIME_i <= '0';
      MODE_i <= '1';
      LOAD_i <= '1';
      time_digit_i <= "0011";
      CD_START_i <= '1';


      wait;
   end process;

END;
