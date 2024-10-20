library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.TRAFFIC_TYPES.ALL;

entity TRAFFIC_LIGHTS is
    port(
	aclk	      : in  std_logic;    -- Clock signal for the process
	emergency     : in  std_logic;    -- Signal that needs to be turned on to control the traffic light in case of emergencies
	pedestrian    :	in  std_logic;    -- Signal when a pedestrian needs to cross the road
	current_state : out TRAFFIC_LIGHT -- type TRAFFIC_STATE is (RED, GREEN, YELLOW, PENDING);
    );
end TRAFFIC_LIGHTS;

architecture TRAFFIC_CONTROL of TRAFFIC_LIGHTS is

signal CURRENT_STATES : TRAFFIC_LIGHT := RED;
signal count 	     : integer := 0;

begin
	
process(aclk)
begin
	if(emergency = '1') then
		CURRENT_STATES <= RED;
		count <= 0;
	else
		case CURRENT_STATES is
			when RED =>
				if(count < 60) then
					count <= count + 1;
				else
					count <= 0;
					CURRENT_STATES <= GREEN;
				end if;
		
			when GREEN =>
				if((count < 60) and (pedestrian = '1')) then
					count <= count + 1;
					CURRENT_STATES <= PENDING;
				else
					count <= 0;
					CURRENT_STATES <= YELLOW;
				end if;

			when PENDING =>
				if(count < 60) then
					count <= count + 1;
				else
					count <= 0;
					CURRENT_STATES <= YELLOW;
				end if;

			when YELLOW => 
				if(count < 6) then
					count <= count + 1;
				else
					count <= 0;
					CURRENT_STATES <= RED;
				end if;
		end case;
	end if;
end process;

current_state <= CURRENT_STATES;

end TRAFFIC_CONTROL;