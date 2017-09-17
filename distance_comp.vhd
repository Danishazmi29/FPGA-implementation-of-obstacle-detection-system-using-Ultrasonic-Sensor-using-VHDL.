----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:23:21 03/17/2017 
-- Design Name: 
-- Module Name:    distance_comp - Behavioral 
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity distance_comp is
    Port ( clk : in STD_LOGIC;
	 dist : in  STD_LOGIC_VECTOR (8 downto 0);
           led_output : out  STD_LOGIC);
end distance_comp;

architecture Behavioral of distance_comp is
COMPONENT trigger_generator
	PORT(
		clk : IN std_logic;          
		trigger : OUT std_logic
		);
	END COMPONENT;
signal control :  std_logic;
begin
dist_trigger_generator : trigger_generator PORT MAP(
		clk => clk,
		trigger => control
	);
process(control)
variable i : integer;
--variable led_latch : std_logic := '0';
begin
i := to_integer(unsigned(dist));
if(control = '0') then 
	if(i > 15) then
		led_output <= '0';
	end if;
	if(i <= 15) then
		led_output <= '1';
	end if;
else
	led_output <= '0';
end if;
end process;

end Behavioral;

