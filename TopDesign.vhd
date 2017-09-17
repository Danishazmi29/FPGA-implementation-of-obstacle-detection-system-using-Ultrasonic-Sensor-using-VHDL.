----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:09:47 02/27/2017 
-- Design Name: 
-- Module Name:    TopDesign - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TopDesign is
    Port ( pulse_pin : in  STD_LOGIC;
				led_out1 : out STD_LOGIC;
				buzz_out : out STD_LOGIC;		--changed
           trigger_pin : out  STD_LOGIC;
           clk : in  STD_LOGIC;
           topselDispA : out  STD_LOGIC;
           topselDispB : out  STD_LOGIC;
           topselDispC : out  STD_LOGIC;
           topselDispD : out  STD_LOGIC;
           topsegA : out  STD_LOGIC;
           topsegB : out  STD_LOGIC;
           topsegC : out  STD_LOGIC;
           topsegD : out  STD_LOGIC;
           topsegE : out  STD_LOGIC;
           topsegF : out  STD_LOGIC;
           topsegG : out  STD_LOGIC);
end TopDesign;

architecture Behavioral of TopDesign is

COMPONENT Range_sensor_module
	PORT(
		fpga_clk : IN std_logic;
		pulse : IN std_logic; 
		led_out : out STD_LOGIC;
		buzz1 : out STD_LOGIC;
		trigger_out : OUT std_logic;
		meters : OUT std_logic_vector(3 downto 0);
		decimeters : OUT std_logic_vector(3 downto 0);
		centimeters : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

COMPONENT segment_driver
	PORT(
		display_A : IN std_logic_vector(3 downto 0);
		display_B : IN std_logic_vector(3 downto 0);
		display_C : IN std_logic_vector(3 downto 0);
		display_D : IN std_logic_vector(3 downto 0);
		clk : IN std_logic;          
		segA : OUT std_logic;
		segB : OUT std_logic;
		segC : OUT std_logic;
		segD : OUT std_logic;
		segE : OUT std_logic;
		segF : OUT std_logic;
		segG : OUT std_logic;
		select_displayA : OUT std_logic;
		select_displayB : OUT std_logic;
		select_displayC : OUT std_logic;
		select_displayD : OUT std_logic
		);
	END COMPONENT;
	
signal Ai : std_logic_vector(3 downto 0);
signal Bi : std_logic_vector(3 downto 0);
signal Ci : std_logic_vector(3 downto 0);
signal Di : std_logic_vector(3 downto 0);

signal sensor_meters : std_logic_vector(3 downto 0);
signal sensor_decimeters : std_logic_vector(3 downto 0);
signal sensor_centimeters : std_logic_vector(3 downto 0);

begin

uut3: segment_driver PORT MAP(
		display_A => Ai,
		display_B => Bi,
		display_C => Ci,
		display_D => Di,
		segA => topsegA,
		segB => topsegB,
		segC => topsegC,
		segD => topsegD,
		segE => topsegE,
		segF => topsegF,
		segG => topsegG,
		select_displayA => topselDispA,
		select_displayB => topselDispB,
		select_displayC => topselDispC,
		select_displayD => topselDispD,
		clk => clk 
	);

uut4: Range_sensor_module PORT MAP(
		fpga_clk => clk,
		pulse => pulse_pin,
		led_out => led_out1,
		buzz1 => buzz_out,
		trigger_out => trigger_pin,
		meters => sensor_meters,
		decimeters => sensor_decimeters ,
		centimeters => sensor_centimeters 
	);
	
	Ai <= sensor_centimeters;
	Bi <= sensor_decimeters;
	Ci <= sensor_meters;
	Di <= "0000";
	
end Behavioral;

