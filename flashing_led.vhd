library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity flashing_led is
    PORT ( clk   : in STD_LOGIC;
           input : in STD_LOGIC;
           blink : out STD_LOGIC_VECTOR(15 downto 0)
         );
end flashing_led;

architecture Behavioral of flashing_led is
signal count: integer range 0 to 98000000;
signal ledstatus: std_logic;

begin
process(clk)
    begin
    if rising_edge(clk) then
        if (input = '1') then
            if count < (98000000 - 1) then
                count <= count + 1;
            else
                count <= 0;
                ledstatus <= not ledstatus;
            end if;
           blink <= (others => ledstatus); 
        elsif (input = '0') then
            blink <= (others => '0');
      end if;
    end if;
end process;

end Behavioral;
