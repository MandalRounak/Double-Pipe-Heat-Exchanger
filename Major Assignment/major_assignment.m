% MATLAB Script for Heat Exchanger Area Simulation (Task 4)
clear; clc;

%% 1. Define Constants
Th_in = 120;        % Hot fluid inlet temp [C]
Tc_in = 30;         % Cold fluid inlet temp [C]
Ch = 4.5 * 1000;    % Hot-side heat capacity rate [W/K]
Cc = 3.0 * 1000;    % Cold-side heat capacity rate [W/K]
U = 300;            % Overall heat transfer coeff [W/m^2-K]

% Derived parameters
Cmin = min(Ch, Cc);
Cmax = max(Ch, Cc);
Cr = Cmin / Cmax;

%% 2. Define Area Range for Simulation
A_range = linspace(2, 10, 100); % Vary A from 2 to 10 m^2

% Pre-allocate arrays for efficiency
eps_parallel = zeros(size(A_range));
eps_counter = zeros(size(A_range));

%% 3. Perform Simulation
for i = 1:length(A_range)
    A = A_range(i);
    NTU = (U * A) / Cmin;
    
    % Parallel Flow Equation
    eps_parallel(i) = (1 - exp(-NTU * (1 + Cr))) / (1 + Cr);
    
    % Counter Flow Equation
    % Note: Formula handles Cr < 1. 
    % For Cr = 1, use eps = NTU/(1+NTU)
    exp_term = exp(-NTU * (1 - Cr));
    eps_counter(i) = (1 - exp_term) / (1 - Cr * exp_term);
end

%% 4. Plotting Results
figure('Color', 'w');
plot(A_range, eps_parallel, 'r--', 'LineWidth', 2); hold on;
plot(A_range, eps_counter, 'b-', 'LineWidth', 2);
grid on;

% Labeling
xlabel('Heat Transfer Area A (m^2)', 'FontSize', 12);
ylabel('Effectiveness \epsilon', 'FontSize', 12);
title('Effect of Area on Heat Exchanger Effectiveness', 'FontSize', 14);
legend('Parallel-Flow', 'Counter-Flow', 'Location', 'Best');

% Optional: Set Y-axis to 0-1 for clarity
ylim([0 1]);