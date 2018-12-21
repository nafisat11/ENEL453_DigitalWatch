library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity tb_timer_done is
end tb_timer_done;

architecture Behavioral of tb_timer_done is

component timer_done 
   PORT ( clk    : in  STD_LOGIC;
          en     : in  STD_LOGIC;
          sec0   : in  STD_LOGIC_VECTOR(3 downto 0);
          sec1   : in STD_LOGIC_VECTOR(3 downto 0);
          min0  :  in STD_LOGIC_VECTOR(3 downto 0);
          min1  :  in STD_LOGIC_VECTOR(3 downto 0);
          en_out  : out STD_LOGIC;
          flash   :  out STD_LOGIC
         );
end component;

--Input
signal clk : STD_LOGIC;
signal en  : STD_LOGIC;
signal sec0 : STD_LOGIC_VECTOR(3 downto 0);
signal sec1 : STD_LOGIC_VECTOR(3 downto 0);
signal min0 : STD_LOGIC_VECTOR(3 downto 0);
signal min1 : STD_LOGIC_VECTOR(3 downto 0);

--Output
signal en_out : STD_LOGIC;
signal flash  : STD_LOGIC;

constant clk_period : time := 10 ns;

begin
uut : timer_done
PORT MAP ( 
            clk => clk,
            en => en,
            sec0 => sec0,
            sec1 => sec1,
            min0 => min0,
            min1 => min1,
            en_out => en_out,
            flash => flash
          );
          
clk_process: process
   begin
   clk <= '0';
   wait for clk_period/2;
   clk <= '1';
   wait for clk_period/2;
end process;

stim_process: process
begin 
en <= '0';
sec0 <= "0010";
sec1 <= "1010";
min0 <= "0111";
min1 <= "0101";
wait for clk_period*10;
en <= '1';
sec0 <= "0010";
sec1 <= "1010";
min0 <= "0111";
min1 <= "0101";
wait for clk_period*10;
en <= '0';
sec0 <= "0000";
sec1 <= "0000";
min0 <= "0000";
min1 <= "0000";
wait for clk_period*10;
en <= '1';
sec0 <= "0000";
sec1 <= "0000";
min0 <= "0000";
min1 <= "0000";
wait;

end process;

end Behavioral;
