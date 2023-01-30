%This code checks to ensure generated data is not repeated in dataset

%read dataset
data = readmatrix('data_validate_final.xlsx','Sheet','Sheet1','Range','A1:I125000');

%name each column
%pressure (Pa), Temperature (K), initial particle size (m), density(kg/m3), geometric standard deviation (dimensionless)
P = data(:,1); T = data(:,2); rho_p = data(:,3); dpg = data(:,4); sigma_g = data(:,5);

%Check for repeated set
count = 0;
for i = 1:length(P)
    j = i+1;
    for k = j:length(P)
        if T(i) >= T(k)-55 && T(i) < T(k)+55 && rho_p(i) > rho_p(k)-180 &&...
                rho_p(i) < rho_p(k)+180 && dpg(i) > 0.90*dpg(k) && dpg(i) < 1.10*dpg(k) &&...
                sigma_g(i) > sigma_g(k)-0.04 && sigma_g(i) < sigma_g(k)+0.04
            count = count+1;
            removerow(count) = i;
            break
        end
    end
end

dataset = data;
dataset([removerow],:)=[];

% Interestingly i noticed that when I checked the data +/- 10%, I noticed
% significant repetition (>46000 datapoints). However, at +/- 9% no repeat 
% is observed. I don't why this is the case, but +/- 9% is ok.
