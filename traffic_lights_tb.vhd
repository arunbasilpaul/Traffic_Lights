library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TRAFFIC_LIGHTS_tb is
end TRAFFIC_LIGHTS_tb;

architecture BEHAV of TRAFFIC_LIGHTS_tb is
	aclk	      : in  std_logic;  -- Clock signal for the process
	emergency     : in  std_logic;  -- Signal that needs to be turned on to control the traffic light in case of emergencies
	pedestrian    :	in  std_logic;  -- Signal when a pedestrian needs to cross the road
	current_state : out TRAFFIC_LIGHT -- type TRAFFIC_STATE is (RED. GREEN, YELLOW, PENDING);

	constant clk_period : time := 10 ns;

begin

UUT: entity TRAFFIC_LIGHTS
	port map(
		aclk => aclk;
		emergency => emergency,
		pedestrain => pedestrian,
		current_state => current_state
	);

clk: process
begin

	while True loop
		aclk <= '0';
		wait for clk_period/2;
		aclk <= '1';
		wait for clk_period/2;
	end loop;

end process clk;

stimuli: process
begin

	emergency <= '1';
	wait for 10*clk_period;
	assert(current_state = RED) report "EMERGENCY TEST FAILES !!!" severity error;
	
	emergency <= '0';
	wait for 5*clk_period;
	assert(current_state = RED) report "INITIAL STATE RED FAILED !!!" severity error;

	wait for 60*clk_period;
	assert(current_state = GREEN) report "GREEN STATE FAILED !!!" severity error;

	pedestrian <= '1';
	wait for 5*clk_period;
	assert(current_state = PENDING) report "PENDING STATE FAILED !!!" severity error;

	wait for 60*clk_period;
	assert(current_state = YELLOW) report "YELLOW STATE WITH PEDESTRIAN FAILED !!!" severity error;

	wait for 125*clk_period;
	assert(current_state = YELLOW) report "YELLOW STATE WITH NO PEDESTRIAN FAILED !!!" severity error;

	wait;

end process stimuli;

end BEHAV;