----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:32:10 02/27/2017 
-- Design Name: 
-- Module Name:    distance_calculation - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity distance_calculation is
    Port ( clk : in  STD_LOGIC;
           calculation_reset : in  STD_LOGIC;
           pulse : in  STD_LOGIC;
			  buzz : out STD_LOGIC; --changed
			  led_output : out STD_LOGIC;
           distance : out STD_LOGIC_VECTOR (8 downto 0));
end distance_calculation;

architecture Behavioral of distance_calculation is
COMPONENT counter is generic(n : positive := 10);
	PORT(
		clk : IN std_logic;
		enable : IN std_logic;
		reset : IN std_logic;          
		counter_output : OUT std_logic_vector(n-1 downto 0)
		);
	END COMPONENT;
	
	signal pulse_width : std_logic_vector(21 downto 0);
	signal dist_latch : std_logic_vector(8 downto 0) ;
	signal led_latch : std_logic;
	signal buzz_latch : std_logic;
begin
counter_pulse: counter generic map(22) port map(
		clk => clk,
		enable => pulse,
		reset => not calculation_reset,
		counter_output => pulse_width
	);
	
	Distance_calculation : process(pulse)
		variable Result : integer;
		variable multiplier : std_logic_vector(23 downto 0);
		
		begin
		if(pulse='0') then
			multiplier := pulse_width * "11";
			Result := to_integer(unsigned(multiplier(23 downto 13)));
			if(Result > 450) then
				dist_latch <= "111111111";
			else
				dist_latch <= std_logic_vector(to_unsigned(Result,9));
				 if dist_latch > "000000001" and dist_latch < "000001111" then
					led_latch <= '1';
					buzz_latch <= '1';
				else
					led_latch <= '0';
					buzz_latch <= '0';
				end if;
				
			end if;
			end if;
			distance <= dist_latch;
			led_output <= led_latch;
			buzz <= buzz_latch;
			end process Distance_calculation;
--		process(pulse)
--		begin
--			if pulse='1' then
--				led_latch <= led_latch;
--			else
--				if dist_latch <= "000001111" then
--					led_latch <= '1';
--				end if;
--				if dist_latch > "000001111" then
--					led_latch <= '0';
--				end if;
--				end if;
--				led_output <= led_latch;
--		end process;
end Behavioral;

