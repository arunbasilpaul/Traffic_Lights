# Overview
This project implements a simple Traffic Light Controller in VHDL with support for pedestrian crossings and emergency mode. The controller manages the traffic light's states (RED, GREEN, YELLOW, and PENDING) based on the clock signal and external inputs such as pedestrian and emergency signals. The main  objective of this project were:
- To create an emergency signal mode that I believe is a simple but essential fix during emergencies such as an ambulance passing through that would halt normal operations to enable emergency situations
- To research if creating new enumberated data types would require packages or not
- To use as a simple project for a future scripting project

<div>
  <img align="left" width="50%" src="https://github.com/user-attachments/assets/61e8960a-212d-4184-9cae-742d0c9b89b2">
</div>

# Features
Traffic light states: The system cycles through standard traffic light states:
- RED: Stop traffic.
- GREEN: Allow traffic to proceed.
- YELLOW: Warn that the light is about to turn red.
- PENDING: Allows pedestrians to cross during a green light if requested.
- Pedestrian crossing: The pedestrian signal allows the system to handle crossing requests during the green light phase, moving to the PENDING state.
- Emergency mode: The traffic light is set to red during emergencies.
