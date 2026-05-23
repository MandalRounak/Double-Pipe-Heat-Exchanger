% Define Ranges
hi = linspace(200, 2000, 50);   % Range for hi
ho = linspace(100, 1500, 50);   % Range for ho
Rf_val = linspace(0,5e-4,21);   % range for Rf

Do=0.040; % in m
Di=0.020; % in m
k_wall=385; % in W/m-K
% Create Grid
[Hi, Ho, Rf_grid] = meshgrid(hi, ho, Rf_val);

% Calculate Uo (Element-wise)
% Constants: Do, Di, k_wall
term_inner = Do ./ (Di .* Hi); 
term_wall = (Do * log(Do/Di)) / (2 * k_wall);
term_outer = 1 ./ Ho;
term_foul = Rf_grid;

Uo_3D = 1 ./ (term_inner + term_wall + term_foul + term_outer);
%% Surface Plot for Fixed Rf (Mid-value)
% Find the index for the middle value of Rf
mid_idx = round(length(Rf_val) / 2);
Rf_fixed = Rf_val(mid_idx);

% Extract the 2D slice of Uo corresponding to this fixed Rf
Uo_surface = Uo_3D(:, :, mid_idx);
Hi_surface = Hi(:, :, mid_idx);
Ho_surface = Ho(:, :, mid_idx);

figure('Name', 'Surface Plot of Uo');
surf(Hi_surface, Ho_surface, Uo_surface);


% Labels and Title
xlabel('Inner h_i (W/m^2\cdotK)');
ylabel('Outer h_o (W/m^2\cdotK)');
zlabel('Overall U_o (W/m^2\cdotK)');
title(['Overall Heat Transfer Coefficient U_o vs h_i and h_o', ...
       newline, '(Fixed R_f = ' num2str(Rf_fixed, '%.1e') ' m^2\cdotK/W)']);
grid on;

%% Average Uo vs Rf
% Preallocate array for average values
avg_Uo = zeros(size(Rf_val));

% Loop through each Rf layer to calculate the mean Uo
for k = 1:length(Rf_val)
    % Extract the 2D slice for the current Rf
    current_slice = Uo_3D(:, :, k);
    % Compute mean of all (hi, ho) combinations
    avg_Uo(k) = mean(current_slice(:));
end

figure('Name', 'Effect of Fouling on Average Uo');
plot(Rf_val, avg_Uo, '-o', 'LineWidth', 2);

% Labels and Title
xlabel('Fouling Resistance R_f (m^2\cdotK/W)');
ylabel('Average Overall U_o (W/m^2\cdotK)');
title('Impact of Fouling Resistance on Average Performance');
grid on;