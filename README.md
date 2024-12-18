# Discrete Time Sliding Mode Control with Time-Delay Estimation for Six-Phase Induction Motor
This project is inspired by [this paper](https://www.researchgate.net/publication/330202008_Discrete-Time_Sliding_Mode_with_Time_Delay_Estimation_of_a_Six-Phase_Induction_Motor_Drive) and implements a Simulink Simulation for the control of a Six-Phase Induction Motor.

## Model and Controller
The implemented controller is based on **Discrete Time Sliding Mode Control**. As the rotor current is supposed to be unmeasurable and the model is supposed to contain uncertainties, **Time-Delay Estimation** is also implemented so to guarantee a certain level of robustness. 

## Repository Structure
The current repository is organised as follows:
### simulation.slx
Main Simulink simulation file. Must be run to visualize all plots. Also loads "all_parameters.mat" into the WorkSpace automatically (in order to work properly).

### parameters.m
Matlab file that generates "all_parameters.mat". Can also be used to manually load all simulation parameters.

### all_parameters.mat
.mat file used to store system parameters easily. Called by "simulation.slx"

### animate_rotor.m (optional)
Simple Matlab animation to visualize 6-phase voltages of the motor. Loads data from "rotor_pos.mat" and "voltages.mat"

### rotor_pos.mat and voltages.mat (optional)
.mat file used to store rotor position and phase voltages. Exported by "simulation.slx". Called by "animate_rotor.m"

### Report.pdf
Short operational report done by me and my group.

### Presentation.pdf
Project presentation made in PowerPoint. Only available in .pdf due to GitHub file size limitations
