%this code checks that data is uniformly distributed distributed by
%by grouping data into equally spaced size bins. Data is uniformly
%distributed if number of data in each size bin is approximately the same.
clear
clc
%read dataset
data = readmatrix('data_final.xlsx','Sheet','Sheet1','Range','A1:I122622');

%name each column
%pressure (Pa), Temperature (K), initial particle size (m), density(kg/m3), geometric standard deviation (dimensionless)
P = data(:,1); T = data(:,2); rho_p = data(:,3); dp = data(:,4); sigma_g = data(:,5);

%obtain limits of dataset
T_min = 293; T_max = 2500; %Temperature in K
dp_min = 1e-9; dp_max = 1e-5; %particle size (m)
rho_p_min = 500; rho_p_max = 8000; %density in kg/m3
sigma_g_min = 1; sigma_g_max = 2.5; %geometric standard deviation

%create size bins for each parameter
num_bin = 100;
dp_bin = logspace(log10(dp_min),log10(dp_max),num_bin)';
%dp_bin = linspace(dp_min,dp_max,num_bin)';
T_bin = linspace(T_min,T_max,num_bin)';
rho_p_bin = linspace(rho_p_min,rho_p_max,num_bin)';
sigma_g_bin = linspace(sigma_g_min,sigma_g_max,num_bin)';
count_dp = zeros(num_bin,1); count_T = zeros(num_bin,1);
count_rho_p = zeros(num_bin,1); count_sigma_g = zeros(num_bin,1);

%bin each data
for i = 1:length(P)
    for j = 1:num_bin-1
        if T(i) > T_bin(j) && T(i) <= T_bin(j+1)
            count_T(j) = count_T(j) + 1;
        end
        if rho_p(i) > rho_p_bin(j) && rho_p(i) <= rho_p_bin(j+1)
            count_rho_p(j) = count_rho_p(j) + 1;
        end
        if sigma_g(i) >= sigma_g_bin(j) && sigma_g(i) < sigma_g_bin(j+1)
            count_sigma_g(j) = count_sigma_g(j) + 1;
        end
        if dp(i) > dp_bin(j) && dp(i) <= dp_bin(j+1)
            count_dp(j) = count_dp(j) + 1;
        end
    end
end
uniform_count = [T_bin, count_T, dp_bin, count_dp, rho_p_bin, count_rho_p, sigma_g_bin, count_sigma_g];
writematrix(uniform_count,'uniform_count.xlsx')

