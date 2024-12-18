# Discrete Time Sliding Mode Control with Time-Delay Estimation for Six-Phase Induction Motor
This project is inspired by [this paper](https://www.researchgate.net/publication/330202008_Discrete-Time_Sliding_Mode_with_Time_Delay_Estimation_of_a_Six-Phase_Induction_Motor_Drive) and implements a Simulink Simulation for the control of a Six-Phase Induction Motor.

## Model and Controller
The implemented controller is based on **Discrete Time Sliding Mode Control**. As the rotor current is supposed to be unmeasurable and the model is supposed to contain uncertainties, **Time-Delay Estimation** is also implemented so to guarantee a certain level of robustness. 

## Repository Structure
The current repository is organised as follows:
