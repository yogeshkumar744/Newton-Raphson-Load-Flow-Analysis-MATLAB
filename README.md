\# Newton-Raphson Load Flow Analysis using MATLAB



A modular MATLAB implementation of the \*\*Newton-Raphson Load Flow Analysis algorithm\*\* for a 3-Bus Power System.



The project performs:

\- Y-Bus formation

\- Power mismatch calculation

\- Jacobian matrix construction

\- Line power flow analysis

\- Transmission loss calculation

\- Voltage profile visualization



\---



\# Overview



Load flow analysis is one of the most important studies in power system engineering.



This project implements the \*\*Newton-Raphson (NR) method\*\*, an efficient and widely used numerical technique for solving nonlinear power flow equations.



The program reads bus and transmission line data from CSV files, performs iterative load flow calculations until convergence, computes transmission line power flow and system losses, and visualizes bus voltage magnitude and angle profiles.



\---



\# Features



\- Reads bus and transmission line data from CSV files

\- Forms the Y-Bus admittance matrix

\- Implements the Newton-Raphson Load Flow algorithm

\- Calculates real and reactive power mismatches

\- Constructs the Jacobian matrix

\- Computes bus voltage magnitudes and phase angles

\- Calculates line currents and complex power flow

\- Calculates total real and reactive transmission line losses

\- Generates voltage magnitude and voltage angle profiles

\- Modular MATLAB implementation using reusable functions



\---



\# Project Structure



| File | Description |

|------|-------------|

| main.m | Main program that executes complete load flow analysis |

| formYbus.m | Forms the Y-Bus admittance matrix |

| calcPower.m | Calculates real and reactive power at each bus |

| buildJacobian.m | Constructs the Newton-Raphson Jacobian matrix |

| calcLineFlow.m | Calculates transmission line currents and complex power flow |

| calcLosses.m | Calculates total real and reactive transmission losses |

| plotVoltage.m | Generates voltage magnitude and voltage angle profiles |

| BusData.csv | Bus data for the test system |

| LineData.csv | Transmission line data |



\---



\# Algorithm Workflow



```

START



&#x20;  ↓



Read Bus \& Line Data



&#x20;  ↓



Form Y-Bus Matrix



&#x20;  ↓



Initialize Voltage Magnitude \& Angle



&#x20;  ↓



Calculate Real and Reactive Power



&#x20;  ↓



Compute Power Mismatch



&#x20;  ↓



Construct Jacobian Matrix



&#x20;  ↓



Solve J × ΔX = Mismatch



&#x20;  ↓



Update Voltage Magnitude \& Angle



&#x20;  ↓



Check Convergence



&#x20;  ↓



No → Repeat Iteration



Yes



&#x20;  ↓



Calculate Line Flow



&#x20;  ↓



Calculate Transmission Losses



&#x20;  ↓



Plot Voltage Profiles



&#x20;  ↓



END

```



\---



\# Requirements



\- MATLAB R2021a or later (or any compatible version)

\- Bus data stored in `BusData.csv`

\- Line data stored in `LineData.csv`



\---



\# How to Run



1\. Download or clone this repository.



2\. Open the project folder in MATLAB.



3\. Ensure all MATLAB files and CSV files are present in the same directory.



4\. Run the main program:



```matlab

main

```



5\. The load flow results will be displayed in the MATLAB Command Window.



6\. Voltage magnitude and voltage angle plots will be generated automatically.



\---



\# Sample Output



The solver successfully converges for the supplied 3-Bus test system.



\*\*Load Flow Converged in 4 iterations\*\*



| Bus | Voltage (p.u.) | Angle (degree) |

|-----|----------------|----------------|

| 1 | 1.0600 | 0.0000 |

| 2 | 1.0400 | 0.2130 |

| 3 | 0.9956 | -2.7029 |



\---



\# Results



\## MATLAB Command Window



!\[MATLAB Command Window](CommandWindow1.png)



\## Voltage Magnitude Profile



!\[Voltage Magnitude Profile](VoltageMagnitude.png)



\## Voltage Angle Profile



!\[Voltage Angle Profile](VoltageAngle.png)



\---



\# Technologies Used



\- MATLAB

\- Power System Analysis

\- Newton-Raphson Method

\- Numerical Methods

\- Matrix Computation



\---



\# Learning Outcomes



This project demonstrates practical implementation of:



\- Y-Bus Matrix Formation

\- Newton-Raphson Load Flow Algorithm

\- Jacobian Matrix Construction

\- Power Mismatch Calculation

\- Bus Voltage Computation

\- Line Current Analysis

\- Complex Power Flow Calculation

\- Transmission Loss Calculation

\- MATLAB Function Modularization



\---



\# Future Improvements



\- Generalize the solver for any number of buses

\- Support IEEE 14-Bus, 30-Bus, and 57-Bus systems

\- Include transformer tap-changing and shunt elements

\- Develop a MATLAB App Designer GUI

\- Compare Newton-Raphson and Gauss-Seidel methods

\- Export results to Excel or PDF



\---



\# Author



\*\*Yogesh Kumar\*\*  

B.Tech Electrical Engineering  

National Institute of Technology Srinagar

