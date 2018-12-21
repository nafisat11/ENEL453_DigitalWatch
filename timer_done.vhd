library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity timer_done is
   PORT ( clk    : in  STD_LOGIC;
          en     : in  STD_LOGIC;
          sec0   : in  STD_LOGIC_VECTOR(3 downto 0);
          sec1   : in STD_LOGIC_VECTOR(3 downto 0);
          min0  :  in STD_LOGIC_VECTOR(3 downto 0);
          min1  :  in STD_LOGIC_VECTOR(3 downto 0);
          en_out  : out STD_LOGIC;
          flash   :  out STD_LOGIC
      );
end timer_done;

architecture Behavioral of timer_done is

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if (en = '1') then
                if sec0 = "0000" and sec1 = "0000" and min0 = "0000" and min1 = "0000" then
                    en_out <= '1';                    
                    flash <= '1';
                else
                    en_out <= '0';
                    flash <= '0';
            end if;
        end if;
      end if;
end process;

end Behavioral;
