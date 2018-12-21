library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_lap_register_FF is
end tb_lap_register_FF;

architecture Behavioral of tb_lap_register_FF is
    component lap_register_FF is
        Port ( clk : in STD_LOGIC;
             LAP_TIME : in STD_LOGIC;
             load : out STD_LOGIC
              );
    end component;
    
    --Inputs
    signal clk: STD_LOGIC := '0';
    signal LAP_TIME: STD_LOGIC := '0';
    
    --outputs
    signal load: STD_LOGIC;
    
    --clock period definition
    constant clk_period: time := 10ns;
begin
    uut: lap_register_FF
    PORT MAP(
                clk => clk,
                LAP_TIME => LAP_TIME,
                load => load
            );
            
   clk_process :process
            begin
               clk <= '0';
               wait for clk_period/2;
               clk <= '1';
               wait for clk_period/2;
            end process;
            
    stim_process: process
            begin
                LAP_TIME <= '0';
                wait for clk_period*3;
                LAP_TIME <= '1';
                wait;
            end process;
    
end Behavioral;
