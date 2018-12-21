-- This file needs editing by students

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Digital_Clock_top_level is
    PORT ( clk      : in  STD_LOGIC;
           reset    : in  STD_LOGIC;
           CD_START : in  STD_LOGIC;
           SW_START : in  STD_LOGIC;
           LOAD     : in  STD_LOGIC;
           LAP_TIME : in  STD_LOGIC;
           MODE     : in  STD_LOGIC;
           CA       : out STD_LOGIC;
           CB       : out STD_LOGIC;
           CC       : out STD_LOGIC;
           CD       : out STD_LOGIC;
           CE       : out STD_LOGIC;
           CF       : out STD_LOGIC;
           CG       : out STD_LOGIC;
           DP       : out STD_LOGIC;
           AN1      : out STD_LOGIC;
           AN2      : out STD_LOGIC;
           AN3      : out STD_LOGIC;
           AN4      : out STD_LOGIC;
           led      : out STD_LOGIC_VECTOR(15 downto 0);
           time_digit : in STD_LOGIC_VECTOR(3 downto 0)
		 );
end Digital_Clock_top_level;

architecture Behavioral of Digital_Clock_top_level is
-- Internal signal names have to go here
signal in_DP, out_DP : STD_LOGIC;
signal an_i : STD_LOGIC_VECTOR(3 downto 0);
signal digit_to_display : STD_LOGIC_VECTOR(3 downto 0);
signal sec_dig1_i, sec_dig2_i, min_dig1_i, min_dig2_i, digit_select_i : STD_LOGIC_VECTOR(3 downto 0);
signal CA_i, CB_i, CC_i, CD_i, CE_i, CF_i, CG_i : STD_LOGIC;
signal stop_timer : STD_LOGIC;
signal blink_i : STD_LOGIC;
signal incr_sec_dig1_i, incr_sec_dig2_i, incr_min_dig1_i, incr_min_dig2_i : STD_LOGIC_VECTOR(3 downto 0);
signal f_sec_dig1_i, f_sec_dig2_i, f_min_dig1_i, f_min_dig2_i : STD_LOGIC_VECTOR(3 downto 0);
signal sw_sec_dig1_i, sw_sec_dig2_i, sw_min_dig1_i, sw_min_dig2_i : STD_LOGIC_VECTOR(3 downto 0);
signal cd_sec_dig1_i, cd_sec_dig2_i, cd_min_dig1_i, cd_min_dig2_i : STD_LOGIC_VECTOR(3 downto 0);
signal o_sec_dig1_i, o_sec_dig2_i, o_min_dig1_i, o_min_dig2_i : STD_LOGIC_VECTOR(3 downto 0);
signal load_i: STD_LOGIC;

-- Declare components here:
component seven_segment_digit_selector is
    PORT ( clk          : in  STD_LOGIC;
           digit_select : out  STD_LOGIC_VECTOR (3 downto 0);
           an_outputs : out  STD_LOGIC_VECTOR (3 downto 0);
           reset        : in  STD_LOGIC
          );
end component;

component CD_clock_divider is
    PORT ( clk      : in  STD_LOGIC;
           reset    : in  STD_LOGIC;
           enable   : in  STD_LOGIC;
           stop_en  : in  STD_LOGIC;
           load     : in  STD_LOGIC;
           set_sec_dig1 : in STD_LOGIC_VECTOR(3 downto 0);
           set_sec_dig2 : in STD_LOGIC_VECTOR(3 downto 0);
           set_min_dig1 : in STD_LOGIC_VECTOR(3 downto 0);
           set_min_dig2 : in STD_LOGIC_VECTOR(3 downto 0);
           sec_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
           sec_dig2 : out STD_LOGIC_VECTOR(3 downto 0);
           min_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
           min_dig2 : out STD_LOGIC_VECTOR(3 downto 0)
         );
end component;

component SW_clock_divider is
    PORT ( clk      : in  STD_LOGIC;
           reset    : in  STD_LOGIC;
           enable   : in  STD_LOGIC;
           seconds : out STD_LOGIC_VECTOR(3 downto 0);
           tens_seconds : out STD_LOGIC_VECTOR(3 downto 0);
           minutes : out STD_LOGIC_VECTOR(3 downto 0);
           tens_minutes : out STD_LOGIC_VECTOR(3 downto 0)     
         );
end component;
--==============================================
component digit_multiplexor is
    PORT (
            m_seconds      : in STD_LOGIC_VECTOR(3 downto 0);
            m_tens_seconds : in STD_LOGIC_VECTOR(3 downto 0);
            m_minutes      : in STD_LOGIC_VECTOR(3 downto 0);
            m_tens_minutes : in STD_LOGIC_VECTOR(3 downto 0);
            selector       : in STD_LOGIC_VECTOR(3 downto 0);
            time_digit     : out STD_LOGIC_VECTOR(3 downto 0)
         );
end component;

component seven_segment_decoder is
    PORT (
            data : in STD_LOGIC_VECTOR(3 downto 0);
            dp_in : in STD_LOGIC;
            CA : out STD_LOGIC;
            CB : out STD_LOGIC;
            CC : out STD_LOGIC;
            CD : out STD_LOGIC;
            CE : out STD_LOGIC;
            CF : out STD_LOGIC;
            CG : out STD_LOGIC;
            DP : out STD_LOGIC
         );
end component;

--CD timer components
component timer_done is 
    PORT ( clk    : in  STD_LOGIC;
        en : in  STD_LOGIC;
        sec0   : in  STD_LOGIC_VECTOR(3 downto 0);
        sec1   : in STD_LOGIC_VECTOR(3 downto 0);
        min0  :  in STD_LOGIC_VECTOR(3 downto 0);
        min1  :  in STD_LOGIC_VECTOR(3 downto 0);
        en_out  : out STD_LOGIC;
        flash   :  out STD_LOGIC
       );
end component;

component flashing_led is
    PORT( clk : in STD_LOGIC;
          input : in STD_LOGIC;
          blink : out STD_LOGIC_VECTOR(15 downto 0)
        );
end component;

component set_time is
    PORT( clk : in STD_LOGIC;
          reset : in STD_LOGIC;
          enable : in STD_LOGIC;
          digit  : in STD_LOGIC_VECTOR(3 downto 0);
          incr_sec_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
          incr_sec_dig2 : out STD_LOGIC_VECTOR(3 downto 0);
          incr_min_dig1 : out STD_LOGIC_VECTOR(3 downto 0);
          incr_min_dig2 : out STD_LOGIC_VECTOR(3 downto 0)
        );
end component;

--Lap timer components
component lap_register_FF is
    PORT(
            clk:        in STD_LOGIC;
            LAP_TIME:   in STD_LOGIC;
            load:       out STD_LOGIC 
        );
end component;

component lap_register is
    PORT(
            clk :               in STD_LOGIC;
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
end component;

component sw_lap_multiplexor is
    PORT(
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

component output_multiplexor is
    PORT(
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
--============================================== 

BEGIN
   OUTPUT_MUX : output_multiplexor
   PORT MAP(
             selector           => MODE,
             sw_seconds         => sw_sec_dig1_i,
             sw_tens_seconds    => sw_sec_dig2_i,
             sw_minutes         => sw_min_dig1_i,
             sw_tens_minutes    => sw_min_dig2_i,
             cd_seconds         => cd_sec_dig1_i,
             cd_tens_seconds    => cd_sec_dig2_i,
             cd_minutes         => cd_min_dig1_i,
             cd_tens_minutes    => cd_min_dig2_i,
             o_seconds          => o_sec_dig1_i,
             o_tens_seconds     => o_sec_dig2_i,
             o_minutes          => o_min_dig1_i,
             o_tens_minutes     => o_min_dig2_i
            );
            
   SET_DIGITS : set_time
   PORT MAP(
             clk => clk,
             reset => reset,
             enable => CD_START,
             digit  => time_digit,
             incr_sec_dig1 => incr_sec_dig1_i,
             incr_sec_dig2 => incr_sec_dig2_i,
             incr_min_dig1 => incr_min_dig1_i,
             incr_min_dig2 => incr_min_dig2_i
           );
              
   BLINK : flashing_led
   PORT MAP(
             clk => clk,
             input => blink_i,
             blink => led
           );

   DONE : timer_done 
   PORT MAP(
             clk => clk,
             en => CD_START,
             sec0  => cd_sec_dig1_i,
             sec1  => cd_sec_dig2_i,
             min0  => cd_min_dig1_i,
             min1  => cd_min_dig2_i,
             en_out => stop_timer,
             flash   => blink_i
           );
           
    LAP_MUX : sw_lap_multiplexor
    PORT MAP(
             l_seconds       => f_sec_dig1_i,
             l_tens_seconds  => f_sec_dig2_i,
             l_minutes       => f_min_dig1_i,
             l_tens_minutes  => f_min_dig2_i,
             seconds         => sec_dig1_i,
             tens_seconds    => sec_dig2_i,
             minutes         => min_dig1_i,
             tens_minutes    => min_dig2_i,
             m_seconds       => sw_sec_dig1_i,
             m_tens_seconds  => sw_sec_dig2_i,
             m_minutes       => sw_min_dig1_i,
             m_tens_minutes  => sw_min_dig2_i,
             selector        => LAP_TIME
          );
          
      LAP_CLOCK : lap_register_FF
      PORT MAP(
               clk         => clk,
               LAP_TIME    => LAP_TIME,
               load        => load_i
               );
               
       SAVE_LAP : lap_register
       PORT MAP( 
               clk             => clk,
               reset           => reset,
               load            => load_i,
               seconds         => sec_dig1_i,
               tens_seconds    => sec_dig2_i, 
               minutes         => min_dig1_i,  
               tens_minutes    => min_dig2_i,
               l_seconds       => f_sec_dig1_i,  
               l_tens_seconds  => f_sec_dig2_i, 
               l_minutes       => f_min_dig1_i,  
               l_tens_minutes  => f_min_dig2_i
                );
                
   DIGIT_MUX : digit_multiplexor
   PORT MAP( 
             m_seconds         => o_sec_dig1_i,  
             m_tens_seconds    => o_sec_dig2_i, 
             m_minutes         => o_min_dig1_i,  
             m_tens_minutes    => o_min_dig2_i,  
             selector          => digit_select_i,  
             time_digit        => digit_to_display

           );
           
   SELECTOR : seven_segment_digit_selector
   PORT MAP( clk          => clk,
             digit_select => digit_select_i, 
             an_outputs   => an_i,
             reset        => reset
           );
             
    CD_DIVIDER: CD_clock_divider
    PORT MAP( clk => clk,
              reset => reset,
              enable => CD_START,
              load   => LOAD,
              set_sec_dig1 => incr_sec_dig1_i,
              set_sec_dig2 => incr_sec_dig2_i,
              set_min_dig1 => incr_min_dig1_i,
              set_min_dig2 => incr_min_dig2_i,
              stop_en  => stop_timer,
              sec_dig1   => cd_sec_dig1_i,  
              sec_dig2   => cd_sec_dig2_i, 
              min_dig1   => cd_min_dig1_i,  
              min_dig2   => cd_min_dig2_i
            );
            
    SW_DIVIDER: SW_clock_divider
            PORT MAP( clk => clk,
                      reset => reset,
                      enable => SW_START,
                      seconds   => sec_dig1_i,  
                      tens_seconds   => sec_dig2_i, 
                      minutes   => min_dig1_i,  
                      tens_minutes   => min_dig2_i
                    );
            
    DECODE: seven_segment_decoder
    PORT MAP(
              data => digit_to_display,
              dp_in => in_DP,
              CA => CA_i,
              CB => CB_i,
              CC => CC_i,
              CD => CD_i,
              CE => CE_i,
              CF => CF_i,
              CG => CG_i,
              DP => out_DP
             );
--============================================== 
   
   -- Connect internal signals to outputs here:
   DP <= out_dp;
   CA <= CA_i;
   CB <= CB_i;
   CC <= CC_i;
   CD <= CD_i;
   CE <= CE_i;
   CF <= CF_i;
   CG <= CG_i;
   
   in_dp <= an_i(2); -- have the decimal point light up in the third digit of the 7-segment display (i.e. minutes digit)
 
   AN1 <= an_i(0); -- seconds digit
   AN2 <= an_i(1); -- tens of seconds digit
   AN3 <= an_i(2); -- minutes digit
   AN4 <= an_i(3); -- tens of minutes digit

END Behavioral;
