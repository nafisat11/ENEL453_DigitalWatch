----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/21/2018 04:02:08 AM
-- Design Name: 
-- Module Name: lap_register_FF - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lap_register_FF is
  Port ( clk : in STD_LOGIC;
         LAP_TIME : in STD_LOGIC;
         load : out STD_LOGIC
          );
end lap_register_FF;

architecture Behavioral of lap_register_FF is

signal input: STD_LOGIC;


begin

lap_detector: process(clk, LAP_TIME)
    begin
        if(rising_edge(clk)) then
            if(LAP_TIME = '1') then
                input <= LAP_TIME;
            else
                input <= '0';
            end if;
        end if;
     end process;
     
     load <= LAP_TIME AND (NOT input);
     
end Behavioral;
