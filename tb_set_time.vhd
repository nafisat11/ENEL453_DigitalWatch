library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_set_time is
end tb_set_time;

architecture Behavioral of tb_set_time is

component set_time
    PORT ( clk      : in  STD_LOGIC;
           reset    : in  STD_LOGIC;
           enable   : in  STD_LOGIC;
           digit    : in  STD_LOGIC_VECTOR(3 downto 0);
           incr_sec_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
           incr_sec_dig2 : out STD_LOGIC_VECTOR(3 downto 0);
           incr_min_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
           incr_min_dig2 : out STD_LOGIC_VECTOR(3 downto 0)
         );  
end component;

--Inputs
signal clk  : STD_LOGIC;
signal reset : STD_LOGIC;
signal enable : STD_LOGIC;
signal digit  : STD_LOGIC_VECTOR(3 downto 0);

--Outputs
signal incr_sec_dig1 : STD_LOGIC_VECTOR(3 downto 0);
signal incr_sec_dig2 : STD_LOGIC_VECTOR(3 downto 0);
signal incr_min_dig1 : STD_LOGIC_VECTOR(3 downto 0);
signal incr_min_dig2 : STD_LOGIC_VECTOR(3 downto 0);

constant clk_period : time := 10 ns;

begin

uut : set_time
PORT MAP (
            clk => clk,
            reset => reset,
            enable => enable,
            digit => digit,
            incr_sec_dig1 => incr_sec_dig1,
            incr_sec_dig2 => incr_sec_dig2,
            incr_min_dig1 => incr_min_dig1,
            incr_min_dig2 => incr_min_dig2
         );
         
   clk_process :process
         begin
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
         end process;
         
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
         
     ones_seconds : process
      begin
        digit(0) <= '1';
        wait for 100 ns;
        digit(0) <= '0';
        wait for 100ns;
     end process;
     
     tens_seconds : process
     begin
       digit(1) <= '0';
       wait for 100 ns;
       digit(1) <= '1';
       wait for 100ns;
     end process;      

     ones_minutes : process
     begin
        digit(2) <= '1';
        wait for 100 ns;
        digit(2) <= '0';
        wait for 100 ns;
     end process;
     
     tens_minutes : process
     begin
        digit(3) <= '0';
        wait for 100 ns;
        digit(3) <= '1';
        wait for 100 ns;
     end process;
     
end Behavioral;
