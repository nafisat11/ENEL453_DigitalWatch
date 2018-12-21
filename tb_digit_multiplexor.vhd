library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_digit_multiplexor is
end tb_digit_multiplexor;

architecture Behavioral of tb_digit_multiplexor is

    component digit_multiplexor
    PORT (
            m_seconds : in STD_LOGIC_VECTOR(3 downto 0);
            m_tens_seconds : in STD_LOGIC_VECTOR(3 downto 0);
            m_minutes : in STD_LOGIC_VECTOR(3 downto 0);
            m_tens_minutes : in STD_LOGIC_VECTOR(3 downto 0);
            selector : in STD_LOGIC_VECTOR(3 downto 0);
            time_digit : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;
    
    --Inputs
    signal m_seconds : STD_LOGIC_VECTOR(3 downto 0);
    signal m_tens_seconds : STD_LOGIC_VECTOR(3 downto 0);
    signal m_minutes : STD_LOGIC_VECTOR(3 downto 0);
    signal m_tens_minutes : STD_LOGIC_VECTOR(3 downto 0);
    signal selector : STD_LOGIC_VECTOR(3 downto 0);
    
    --Outputs
    signal time_digit : STD_LOGIC_VECTOR(3 downto 0);

begin

    uut: digit_multiplexor
    PORT MAP (
                m_seconds => m_seconds,
                m_tens_seconds => m_tens_seconds,
                m_minutes => m_minutes,
                m_tens_minutes => m_tens_minutes,
                selector => selector,
                time_digit => time_digit
             );
     
     stim_proc: process
     BEGIN
        selector <= "0001";
        wait for 50ns;
        
        selector <= "0010";
        wait for 50ns;
        
        selector <= "0100";
        wait for 50ns;
        
        selector <= "1000";
        wait;
     end process;
     
     seconds_dig1 : process
     BEGIN
        m_seconds <= "0111";
        wait for 100ns;
        
        m_seconds <= "0010";
        wait for 100ns;
     end process;
     
     seconds_dig2 : process
     BEGIN
        m_tens_seconds <= "0011";
        wait for 100ns;
             
        m_tens_seconds <= "0001";
        wait for 100ns;
     end process;

     minutes_dig1 : process
     BEGIN
        m_minutes <= "0011";
        wait for 100ns;
             
        m_minutes <= "0100";
        wait for 100ns;
     end process;     

     minutes_dig2 : process
     BEGIN
        m_tens_minutes <= "0001";
        wait for 100ns;
             
        m_tens_minutes <= "0010";
        wait for 100ns;
     end process;

end Behavioral;
