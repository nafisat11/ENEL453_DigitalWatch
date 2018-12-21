----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/21/2018 01:59:03 AM
-- Design Name: 
-- Module Name: lap_register - Behavioral
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

entity lap_register is
  Port (    clk :               in STD_LOGIC;
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
end lap_register;

architecture Behavioral of lap_register is



BEGIN

load_dig: process(clk)
    begin       
        if(rising_edge(clk)) then
            if(reset = '1') then
                    l_seconds <= "0000";
                    l_tens_seconds <= "0000";
                    l_minutes <= "0000";
                    l_tens_minutes <= "0000"; 
            elsif(load = '1') then
                 l_seconds <= seconds;
                 l_tens_seconds <= tens_seconds;
                 l_minutes <= minutes;
                 l_tens_minutes <= tens_minutes;
            end if;
        end if;
    end process;
end Behavioral;
