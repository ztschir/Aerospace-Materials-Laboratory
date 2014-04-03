clear all;
clc;

% Import files
mon_1(1).data = csvread('mon_1_1.csv');
mon_1(2).data = csvread('mon_1_2.csv');
mon_1(3).data = csvread('mon_1_3.csv');

mon_2(1).data = csvread('mon_2_1.csv');
mon_2(2).data = csvread('mon_2_2.csv');
mon_2(3).data = csvread('mon_2_3.csv');

tue_1(1).data = csvread('tue_1_1.csv');
tue_1(2).data = csvread('tue_1_2.csv');
tue_1(3).data = csvread('tue_1_3.csv');

wed_1(1).data = csvread('wed_1_1.csv');
wed_1(2).data = csvread('wed_1_2.csv');
wed_1(3).data = csvread('wed_1_3.csv');

wed_2(1).data = csvread('wed_2_1.csv');
wed_2(2).data = csvread('wed_2_2.csv');
wed_2(3).data = csvread('wed_2_3.csv');

thur_1(1).data = csvread('thur_1_1.csv');
thur_1(2).data = csvread('thur_1_2.csv');
thur_1(3).data = csvread('thur_1_3.csv');

% Width
mon_1(1).width = 0.471;
mon_1(2).width = 0.470;
mon_1(3).width = 0.480;

mon_2(1).width = 0.4745;
mon_2(2).width = 0.4740;
mon_2(3).width = 0.4715;

tue_1(1).width = 0.475;
tue_1(2).width = 0.476;
tue_1(3).width = 0.475;

wed_1(1).width = 0.475;
wed_1(2).width = 0.472;
wed_1(3).width = 0.472;

wed_2(1).width = 0.480;
wed_2(2).width = 0.482;
wed_2(3).width = 0.478;

thur_1(1).width = 0.471;
thur_1(2).width = 0.480;
thur_1(3).width = 0.474;

% Thickness
mon_1(1).thickness = 0.018;
mon_1(2).thickness = 0.0172;
mon_1(3).thickness = 0.0179;

mon_2(1).thickness = 0.021;
mon_2(2).thickness = 0.021;
mon_2(3).thickness = 0.021;

tue_1(1).thickness = 0.02;
tue_1(2).thickness = 0.02;
tue_1(3).thickness = 0.02;

wed_1(1).thickness = 0.018;
wed_1(2).thickness = 0.018;
wed_1(3).thickness = 0.018;

wed_2(1).thickness = 0.0198;
wed_2(2).thickness = 0.0205;
wed_2(3).thickness = 0.0210;

thur_1(1).thickness = 0.02;
thur_1(2).thickness = 0.0195;
thur_1(3).thickness = 0.018;

length = 2;
i = 1;
hold on; 
color = hsv(18);
for i = 1:3
  mon_1(i).stress = 0;
  mon_1(i).strain = 0;
  mon_1(i).polyfit = 0;
  mon_1(i).youngs_modulus = 0;
  mon_1(i).flexural_strength = 0;
  
  mon_2(i).stress = 0;
  mon_2(i).strain = 0;
  mon_2(i).polyfit = 0;
  mon_2(i).youngs_modulus = 0;
  mon_2(i).flexural_strength = 0;  

  tue_1(i).stress = 0;
  tue_1(i).strain = 0;
  tue_1(i).polyfit = 0;
  tue_1(i).youngs_modulus = 0;
  tue_1(i).flexural_strength = 0;  

  wed_1(i).stress = 0;
  wed_1(i).strain = 0;
  wed_1(i).polyfit = 0;
  wed_1(i).youngs_modulus = 0;
  wed_1(i).flexural_strength = 0;  
  
  wed_2(i).stress = 0;
  wed_2(i).strain = 0;
  wed_2(i).polyfit = 0;
  wed_2(i).youngs_modulus = 0;
  wed_2(i).flexural_strength = 0;  

  thur_1(i).stress = 0;
  thur_1(i).strain = 0;
  thur_1(i).polyfit = 0;
  thur_1(i).youngs_modulus = 0;
  thur_1(i).flexural_strength = 0;  
end

spec = [mon_1, mon_2, tue_1, wed_1, wed_2, thur_1];

for i = 1:18
  % Clean up data
  bad_values_ind = find(spec(i).data(:,1) > 0.2);
  new_begin = bad_values_ind(1);
  new_end = bad_values_ind(end-40);
  spec(i).data = spec(i).data(new_begin:new_end,:);
  
  c = spec(i).thickness / 2;
  I = (spec(i).width*spec(i).thickness^3) / 12;
    
  original_dis = spec(i).data(1,2);
  dis = spec(i).data(:,2) - original_dis;
  force = spec(i).data(:,1);
    
  bending_moment = (force .* length) ./ 4;
  spec(i).stress = (bending_moment .* c) ./ I;
  spec(i).strain = ((12*c).*dis) ./ (length^2);
  spec(i).polyfit = polyfit(spec(i).strain,spec(i).stress, 1);
  spec(i).youngs_modulus = spec(i).polyfit(1);
  spec(i).flexural_strength = spec(i).stress(end);
  
  plot(spec(i).strain,spec(i).stress, 'color', color(i,:));
  i = i + 1;
end

legend('First Monday spec. 1', 'First Monday spec. 2',...
       'First Monday spec. 3', 'Second Monday spec. 1',...
       'Second Monday spec. 2', 'Second Monday spec. 3',...
       'Tuesday spec. 1', 'Tuesday spec. 2', 'Tuesday spec. 3',...
       'First Wednesday spec. 1', 'First Wednesday spec. 2',...
       'First Wednesday spec. 3', 'Second Wednesday spec. 1',...
       'Second Wednesday spec 2', 'Second Wednesday spec. 3',...
       'Thursday spec. 1', 'Thursday spec. 2', 'Thursday spec. 3');

avg_youngs = mean([spec(:).youngs_modulus])
avg_flex_strength = mean([spec(:).flexural_strength])

% Problem 3

flex_strength = 300e6;
radius = .005;
length = .015;
req_force = (flex_strength*pi*radius^3) / length;

% Problem 4

P = 0:.001:.999;
E_0 = 390000000000;
sigma_0 = 300000000;
rho_0 = 3900;
E = E_0.*(1 - 1.9.*P + .9.*(P.^2));
sigma_fs = sigma_0.*exp(-5.*P);
rho = rho_0.*(1-P);

hold off;
%figure('Name', 'Specific modulus');
%plot(P, E./rho);

%figure('Name', 'Specific Strength');
%plot(P, sigma_fs./rho);

max_spec_modulus = max(E./rho);
max_spec_strength = max(sigma_fs./rho);

% Problem 5
sigma_0 = 300;
sigma = 1:2*sigma_0;
P_s = @(m) exp(-(sigma./sigma_0).^m);

%figure('Name', 'Weibull distributions of Ceramic Strength')
%plot(sigma, P_s(5),sigma, P_s(10),sigma, P_s(20));
%legend('m = 5', 'm = 10', 'm = 20');
