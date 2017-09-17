----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:50:16 02/27/2017 
-- Design Name: 
-- Module Name:    trigger_generator - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity trigger_generator is
    Port ( clk : in  STD_LOGIC;
           trigger : out  STD_LOGIC);
end trigger_generator;

architecture Behavioral of trigger_generator is
COMPONENT counter is generic(n : positive := 10);
	PORT(
		clk : IN std_logic;
		enable : IN std_logic;
		reset : IN std_logic;          
		counter_output : OUT std_logic_vector(n-1 downto 0)
		);
	END COMPONENT;

signal reset_counter : std_logic;
signal output_counter : std_logic_vector(23 downto 0);
	
begin
trig : counter generic map(24) port map(clk,'1',reset_counter,output_counter);
	process(clk)
	constant ms250 : std_logic_vector(23 downto 0) := "101111101011110000100000";
	constant ms250And100us : std_logic_vector(23 downto 0) := "101111101100111110101000";
	
	begin
	if(output_counter > ms250 and output_counter < ms250And100us) then
		trigger <= '1';
		else
		trigger <= '0';
		end if;
		
		if(output_counter = ms250And100us or output_counter="XXXXXXXXXXXXXXXXXXXXXXXX") then
		reset_counter <= '0';
		else
		reset_counter <= '1';
		end if;
		end process;
end Behavioral;

