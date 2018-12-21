library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_flashing_led is
end tb_flashing_led;

architecture Behavioral of tb_flashing_led is

component flashing_led 
    PORT ( clk   : in STD_LOGIC;
       input : in STD_LOGIC := '0';
       blink : out STD_LOGIC_VECTOR(15 downto 0)
     );
end component;

--Inputs
signal clk   : STD_LOGIC;
signal input : STD_LOGIC;

--Outputs
signal blink : STD_LOGIC_VECTOR(15 downto 0);

constant clk_period : time := 10 ns;

begin
    uut: flashing_led
    PORT MAP (
                clk => clk,
                input => input,
                blink => blink
              );
              
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
    stim_proc: process
    BEGIN
        input <= '1';
        wait for 200 ns;
        
        input <= '0';
        wait for 50 ns;
        
        input <= '1';
        wait for 200 ns;
        
        input <= '0';
        wait;
    end process;
      
end Behavioral;
