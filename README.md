# Double Pipe Heat Exchanger: Simulation, Analysis, and Design

A comprehensive study, mathematical modeling, and numerical simulation of a double-pipe heat exchanger operating under different flow configurations (parallel vs. counter-flow) and special operating conditions (phase change). This project bridges the gap between theoretical transport phenomena principles and industrial heat exchanger design.

---

## 🚀 Features & Project Scope
* **Analytical Modeling:** Full derivation of the overall heat transfer coefficient ($U_o$) incorporating inner/outer convection, radial wall conduction, and fouling resistances.
* **Flow Configuration Analysis:** Computational evaluation comparing parallel-flow vs. counter-flow temperature profiles.
* **Special Case Simulations:** Dynamic profile modeling for phase-change equipment like reboilers and condensers.
* **Effectiveness-NTU Evaluation:** Mathematical proof of logarithmic mean temperature difference ($\Delta T_{LMTD}$) limits for balanced counter-flow and upper asymptotic bounds on exchanger effectiveness ($\varepsilon$).

---

## 📐 Mathematical Framework & Derivations

### 1. Overall Heat Transfer Coefficient ($U_o$)
Accounting for heat flowing radially from the hot internal fluid, through the cylindrical tube wall, through an outer scale layer, and into the cold fluid shell, the total thermal resistance ($R_{total}$) in series is defined as:

$$R_{total} = \frac{1}{U_o A_o} = R_{conv,i} + R_{cond,wall} + R_{foul,o} + R_{conv,o}$$

Expanding each resistance term relative to the outer heat transfer surface area ($A_o$) yields:
* **Inner Convection Resistance:** $R_{conv,i} = \frac{D_o}{h_i D_i}$
* **Wall Conduction Resistance (Cylindrical Geometry):** $R_{cond,wall} = \frac{D_o \ln(D_o/D_i)}{2k_{wall}}$
* **Outer Fouling Layer Resistance:** $R_{foul,o} = R_f$
* **Outer Convection Resistance:** $R_{conv,o} = \frac{1}{h_o}$

Combining these defines the core design equation:
$$\frac{1}{U_o} = \frac{D_o}{h_i D_i} + \frac{D_o \ln(D_o/D_i)}{2k_{wall}} + R_f + \frac{1}{h_o}$$

### 2. The Balanced Counter-Flow Limit ($\dot{C}_h = \dot{C}_c$)
When the heat capacity rates of the hot and cold fluids are perfectly equal ($\dot{C}_c = \dot{C}_h$), the differential temperature profile becomes linear rather than exponential ($d\theta = 0$). Consequently, the temperature differences at the two ends become identical ($\Delta T_1 = \Delta T_2$), creating an indeterminate form ($0/0$) in the standard LMTD equation. 

Applying L'Hôpital's Rule evaluates the limit:

$$\lim_{\Delta T_2 \to \Delta T_1} \Delta T_{LMTD} = \lim_{x \to c} \left( \frac{c - x}{\ln c - \ln x} \right) = c = \Delta T_1 = \Delta T_2 = \Delta T$$

> **Conclusion:** In a balanced counter-flow heat exchanger, the log-mean temperature difference is simply the constant temperature difference between the two fluids across the entire length of the exchanger.

---

## 💻 MATLAB Code & Simulation Framework

The project leverages numerical ordinary differential equation (ODE) suites and boundary-value problem (BVP) solvers to track fluid temperature evolution over spatial domains.

### Implementation Details
* **Parallel-Flow Setup:** Solved as an initial value problem using `ode45` since both fluid entry temperatures are fixed at $x=0$.
* **Counter-Flow Setup:** Solved as a two-point boundary value problem using `bvp4c` because the cold fluid's boundary state is specified at the opposing exit length ($x=L$).
* **Key Simulation Notebook Parameters:** Models a $5\text{ m}$ exchanger length with heat capacity rates $C_h = 1000\text{ W/K}$ and $C_c = 800\text{ W/K}$.

### Performance Insights
* **The Counter-Flow Advantage:** The counter-flow configuration yields a higher outlet cold-fluid temperature. In parallel flow, the cold fluid's exit temperature is physically limited by the hot fluid's exit temperature. In counter-flow, the cold fluid exits near where the hot fluid enters, maintaining a more uniform temperature driving force ($\Delta T$) across the entire length.
* **Phase-Change Exceptions:** For phase-change systems (reboilers and condensers), one fluid remains at a constant saturation temperature throughout the exchanger. In these scenarios, the flow arrangement (parallel vs. counter-flow) becomes irrelevant because the constant-temperature profile provides an identical driving force regardless of direction.

---

## 📊 Sensitivity Analysis & Performance Bottlenecks

Numerical investigations highlight how individual design variables dictate performance limits:

### Dominant Resistance Scenarios
1. **Inner Convection Dominance:** At low inner convection values (e.g., $h_i = 50\text{ W/m}^2\text{K}$, $h_o = 1000\text{ W/m}^2\
