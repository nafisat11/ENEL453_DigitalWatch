library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_output_multiplexor is
end tb_output_multiplexor;

architecture Behavioral of tb_output_multiplexor is

    component output_multiplexor
    PORT (
    sw_seconds:           in   STD_LOGIC_VECTOR(3 downto 0);
    sw_tens_seconds:      in   STD_LOGIC_VECTOR(3 downto 0);
    sw_minutes:           in   STD_LOGIC_VECTOR(3 downto 0);
    sw_tens_minutes:      in   STD_LOGIC_VECTOR(3 downto 0);
    cd_seconds :          in   STD_LOGIC_VECTOR(3 downto 0);
    cd_tens_seconds:      in   STD_LOGIC_VECTOR(3 downto 0);
    cd_minutes:           in   STD_LOGIC_VECTOR(3 downto 0);
    cd_tens_minutes:      in   STD_LOGIC_VECTOR(3 downto 0);
    selector:             in   STD_LOGIC;
    o_seconds:            out  STD_LOGIC_VECTOR(3 downto 0);
    o_tens_seconds:       out  STD_LOGIC_VECTOR(3 downto 0);
    o_minutes:            out  STD_LOGIC_VECTOR(3 downto 0);
    o_tens_minutes:       out  STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;
    
    --Inputs
    signal sw_seconds : STD_LOGIC_VECTOR(3 downto 0);
    signal sw_tens_seconds : STD_LOGIC_VECTOR(3 downto 0);
    signal sw_minutes : STD_LOGIC_VECTOR(3 downto 0);
    signal sw_tens_minutes : STD_LOGIC_VECTOR(3 downto 0);
    signal cd_seconds : STD_LOGIC_VECTOR(3 downto 0);
    signal cd_tens_seconds : STD_LOGIC_VECTOR(3 downto 0);
    signal cd_minutes : STD_LOGIC_VECTOR(3 downto 0);
    signal cd_tens_minutes : STD_LOGIC_VECTOR(3 downto 0);
    signal selector : STD_LOGIC := '0';
    
    --Outputs
    signal o_seconds : STD_LOGIC_VECTOR(3 downto 0);
    signal o_tens_seconds : STD_LOGIC_VECTOR(3 downto 0);
    signal o_minutes : STD_LOGIC_VECTOR(3 downto 0);
    signal o_tens_minutes : STD_LOGIC_VECTOR(3 downto 0);

begin

    uut: output_multiplexor
    PORT MAP (
                sw_seconds => sw_seconds,
                sw_tens_seconds => sw_tens_seconds,
                sw_minutes => sw_minutes,
                sw_tens_minutes => sw_tens_minutes,
                cd_seconds => cd_seconds,
                cd_tens_seconds => cd_tens_seconds,
                cd_minutes => cd_minutes,
                cd_tens_minutes => cd_tens_minutes,
                o_seconds => o_seconds,
                o_tens_seconds => o_tens_seconds,
                o_minutes => o_minutes,
                o_tens_minutes => o_tens_minutes,
                selector => selector
             );
     
     stim_proc: process
     BEGIN
        selector <= '0';
        wait for 50ns;
        
        selector <= '1';
        wait for 50ns;
        
        selector <= '0';
        wait for 50ns;
        
        selector <= '1';
        wait;
     end process;
     
     seconds_dig1 : process
     BEGIN
        sw_seconds <= "0111";
        cd_seconds <= "0001";
        wait for 100ns;
        
        sw_seconds <= "0010";
        cd_seconds <= "0101";
        wait for 100ns;
     end process;
     
     seconds_dig2 : process
     BEGIN
        sw_tens_seconds <= "0011";
        cd_tens_seconds <= "0111";
        wait for 100ns;
             
        sw_tens_seconds <= "0001";
        cd_tens_seconds <= "1001";
        wait for 100ns;
     end process;

     minutes_dig1 : process
     BEGIN
        sw_minutes <= "0011";
        cd_minutes <= "0001";
        wait for 100ns;
             
        sw_minutes <= "0100";
        cd_minutes <= "0111";
        wait for 100ns;
     end process;     

     minutes_dig2 : process
     BEGIN
        sw_tens_minutes <= "1001";
        cd_tens_minutes <= "1011";
        wait for 100ns;
             
        sw_tens_minutes <= "0010";
        cd_tens_minutes <= "1101";
        wait for 100ns;
     end process;

end Behavioral;
