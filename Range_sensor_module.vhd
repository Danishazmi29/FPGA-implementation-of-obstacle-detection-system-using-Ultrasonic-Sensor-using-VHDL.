----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:51:19 02/27/2017 
-- Design Name: 
-- Module Name:    Range_sensor_module - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Range_sensor_module is
    Port ( fpga_clk : in  STD_LOGIC;
           pulse : in  STD_LOGIC;
			  led_out : out STD_LOGIC;
			  buzz1 : out STD_LOGIC;
           trigger_out : out  STD_LOGIC;
           meters : out  STD_LOGIC_VECTOR (3 downto 0);
           decimeters : out  STD_LOGIC_VECTOR (3 downto 0);
           centimeters : out  STD_LOGIC_VECTOR (3 downto 0));
end Range_sensor_module;

architecture Behavioral of Range_sensor_module is
COMPONENT distance_calculation
	PORT(
		clk : IN std_logic;
		calculation_reset : IN std_logic;
		pulse : IN std_logic;  
		led_output : OUT STD_LOGIC;
		buzz : OUT STD_LOGIC;
		distance : BUFFER std_logic_vector(8 downto 0)
		);
	END COMPONENT;
--	COMPONENT distance_comp
--	PORT(clk : IN STD_LOGIC;
--	dist : IN std_logic_vector(8 downto 0);          
--		led_output : OUT std_logic
--		);
--	END COMPONENT;

COMPONENT trigger_generator
	PORT(
		clk : IN std_logic;          
		trigger : OUT std_logic
		);
	END COMPONENT;
	
COMPONENT BCD_converter
	PORT(
		distance_input : IN std_logic_vector(8 downto 0);          
		hundreds : OUT std_logic_vector(3 downto 0);
		tens : OUT std_logic_vector(3 downto 0);
		unit : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
signal distance_out : std_logic_vector(8 downto 0);
signal trig_out : std_logic;

begin

trig_generator: trigger_generator PORT MAP(
		clk => fpga_clk,
		trigger => trig_out
	);
Pulse_width: distance_calculation PORT MAP(
		clk => fpga_clk,
		calculation_reset => trig_out,
		pulse => pulse,
		led_output => led_out,
		buzz => buzz1,
		distance => distance_out
	);
--	dist_comp: distance_comp PORT MAP(
--	 clk => fpga_clk,
--	 dist => distance_out,
--		led_output => led_out
--	);

BCD_conv: BCD_converter PORT MAP(
		distance_input => distance_out,
		hundreds => meters,
		tens => decimeters,
		unit => centimeters
	);

trigger_out <= trig_out;
end Behavioral;

