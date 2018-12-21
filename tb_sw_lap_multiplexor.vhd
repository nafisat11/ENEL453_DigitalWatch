library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_sw_lap_multiplexor is
end tb_sw_lap_multiplexor;

architecture Behavioral of tb_sw_lap_multiplexor is

    component sw_lap_multiplexor
    PORT (
            l_seconds:            in   STD_LOGIC_VECTOR(3 downto 0);
            l_tens_seconds:       in   STD_LOGIC_VECTOR(3 downto 0);
            l_minutes:            in   STD_LOGIC_VECTOR(3 downto 0);
            l_tens_minutes:       in   STD_LOGIC_VECTOR(3 downto 0);
            seconds :             in   STD_LOGIC_VECTOR(3 downto 0);
            tens_seconds:         in   STD_LOGIC_VECTOR(3 downto 0);
            minutes:              in   STD_LOGIC_VECTOR(3 downto 0);
            tens_minutes:         in   STD_LOGIC_VECTOR(3 downto 0);
            selector:             in   STD_LOGIC;
            m_seconds:            out  STD_LOGIC_VECTOR(3 downto 0);
            m_tens_seconds:       out  STD_LOGIC_VECTOR(3 downto 0);
            m_minutes:            out  STD_LOGIC_VECTOR(3 downto 0);
            m_tens_minutes:       out  STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;
    
    --Inputs
    signal l_seconds:        STD_LOGIC_VECTOR(3 downto 0);
    signal l_tens_seconds:   STD_LOGIC_VECTOR(3 downto 0);
    signal l_minutes:        STD_LOGIC_VECTOR(3 downto 0);
    signal l_tens_minutes:   STD_LOGIC_VECTOR(3 downto 0);
    signal seconds :         STD_LOGIC_VECTOR(3 downto 0);
    signal tens_seconds:     STD_LOGIC_VECTOR(3 downto 0);
    signal minutes:          STD_LOGIC_VECTOR(3 downto 0);
    signal tens_minutes:     STD_LOGIC_VECTOR(3 downto 0);
    signal selector:         STD_LOGIC;
    
    --Outputs
    signal m_seconds:        STD_LOGIC_VECTOR(3 downto 0);
    signal m_tens_seconds:   STD_LOGIC_VECTOR(3 downto 0);
    signal m_minutes:        STD_LOGIC_VECTOR(3 downto 0);
    signal m_tens_minutes:   STD_LOGIC_VECTOR(3 downto 0);

begin

    uut: sw_lap_multiplexor
    PORT MAP (
                l_seconds => l_seconds,
                l_tens_seconds => l_tens_seconds,
                l_minutes => l_minutes,
                l_tens_minutes => l_tens_minutes,
                seconds => seconds,
                tens_seconds => tens_seconds,
                minutes => minutes,
                tens_minutes => tens_minutes,
                selector => selector,
                m_seconds => m_seconds,
                m_tens_seconds => m_tens_seconds,
                m_minutes => m_minutes,
                m_tens_minutes => m_tens_minutes
             );
     
     stim_proc: process
     BEGIN
        selector <= '1';
        wait for 50ns;
        
        selector <= '0';
        wait for 100ns;
        
        selector <= '1';
        wait for 50ns;
        
        selector <= '0';
        wait;
     end process;
     
     seconds_process : process
     BEGIN
        l_seconds <= "0111";
        seconds <= "0001";
        wait for 100ns;
        seconds <= "0010";
        wait for 100ns;
     end process;
     
     tens_seconds_process : process
     BEGIN
        l_tens_seconds <= "1101";
        tens_seconds <= "1000";
        wait for 100ns;
        tens_seconds <= "0110";
        wait for 100ns;
     end process;
     
     minutes_process : process
     BEGIN
        l_minutes <= "0010";
        minutes <= "1000";
        wait for 100ns;
        minutes <= "0110";
        wait for 100ns;
     end process;
     
     tens_minutes_process : process
     BEGIN
        l_tens_minutes <= "0101";
        tens_minutes <= "1110";
        wait for 100ns;
        tens_minutes <= "0111";
        wait for 100ns;
     end process;
end Behavioral;
