library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_lap_register is
end tb_lap_register;

architecture Behavioral of tb_lap_register is

component lap_register is
    PORT(  clk :               in STD_LOGIC;
           reset:              in STD_LOGIC;
           load:               in STD_LOGIC;
           seconds:            in STD_LOGIC_VECTOR(3 downto 0);
           tens_seconds:       in STD_LOGIC_VECTOR(3 downto 0);
           minutes:            in STD_LOGIC_VECTOR(3 downto 0);
           tens_minutes:       in STD_LOGIC_VECTOR(3 downto 0);
           l_seconds:          out STD_LOGIC_VECTOR(3 downto 0);
           l_tens_seconds:     out STD_LOGIC_VECTOR(3 downto 0);
           l_minutes:          out STD_LOGIC_VECTOR(3 downto 0);
           l_tens_minutes:     out STD_LOGIC_VECTOR(3 downto 0)
        );
end component;

--Inputs
    signal  clk:                STD_LOGIC := '0';
    signal  reset:              STD_LOGIC := '0';
    signal  load:               STD_LOGIC := '0';
    signal  seconds:            STD_LOGIC_VECTOR(3 downto 0);
    signal  tens_seconds:       STD_LOGIC_VECTOR(3 downto 0);
    signal  minutes:            STD_LOGIC_VECTOR(3 downto 0);
    signal  tens_minutes:       STD_LOGIC_VECTOR(3 downto 0);
    
--Outputs
    signal  l_seconds:          STD_LOGIC_VECTOR(3 downto 0);
    signal  l_tens_seconds:     STD_LOGIC_VECTOR(3 downto 0);
    signal  l_minutes:          STD_LOGIC_VECTOR(3 downto 0);
    signal  l_tens_minutes:     STD_LOGIC_VECTOR(3 downto 0);
    
--clock period definition
    constant clk_period: time := 10ns;
    
begin
     uut: lap_register
         PORT MAP (
                clk             => clk,
                reset           => reset,
                load            => load,
                seconds         => seconds,
                tens_seconds    => tens_seconds,
                minutes         => minutes,
                tens_minutes    => tens_minutes,
                l_seconds       => l_seconds,
                l_tens_seconds  => l_tens_seconds,
                l_minutes       => l_minutes,
                l_tens_minutes  => l_tens_minutes
           );

  -- Clock process definitions
  clk_process :process
  begin
     clk <= '0';
     wait for clk_period/2;
     clk <= '1';
     wait for clk_period/2;
  end process;

  stim_proc: process
   begin      
      reset <= '1';
      load <= '1';
      wait for 100 ns;   
      reset <= '0';





      wait for clk_period*10;
      
      load <= '0';
      wait for clk_period*10;
      load <= '1';
      wait for clk_period*10;
   end process;
   
   digits: process
   begin      
   
      seconds <= "0010";
      tens_seconds <= "0000";
      minutes <= "1000";
      tens_minutes <= "0100";
      wait for clk_period*10;
      
      seconds <= "0011";
      tens_seconds <= "0001";
      minutes <= "0100";
      tens_minutes <= "1001";
      wait for clk_period*10;
      
      seconds <= "0100";
      tens_seconds <= "0100";
      minutes <= "0110";
      tens_minutes <= "0011";
      wait;
   end process;
end Behavioral;
