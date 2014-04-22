clear all;
clc;

plots = 0;

deg_0.data = csvread('0degree.csv');
deg_45.data = csvread('45degree.csv');
deg_90.data = csvread('90degree.csv');

deg_0.stress = deg_0.data(:,1); % ksi
deg_0.axial = deg_0.data(:,2);
deg_0.trans = deg_0.data(:,3);

deg_45.stress = deg_45.data(:,1); % ksi
deg_45.axial = deg_45.data(:,2);
deg_45.trans = deg_45.data(:,3);

deg_90.stress = deg_90.data(:,1); % ksi
deg_90.axial = deg_90.data(:,2);
deg_90.trans = deg_90.data(:,3);

temp = polyfit(deg_0.axial,deg_0.stress,1);
deg_0.E = temp(1);
temp = polyfit(deg_45.axial,deg_45.stress,1);
deg_45.E = temp(1);
temp = polyfit(deg_90.axial(3:end),deg_90.stress(3:end),1);
deg_90.E = temp(1);

if(plots)
  figure('Name', 'Zero degree stress vs. strain');
  scatter(deg_0.axial,deg_0.stress);
  title('Zero degree stress vs. strain');
  xlabel('Axial strain (%)')
  ylabel('Stress (ksi)')

  figure('Name', 'Forty-five degree stress vs. strain');  
  scatter(deg_45.axial,deg_45.stress);
  title('Forty-five degree stress vs. strain');  
  xlabel('Axial strain (%)')
  ylabel('Stress (ksi)')

  figure('Name', 'Ninety degree stress vs. strain');  
  scatter(deg_90.axial(3:end),deg_90.stress(3:end));
  title('Ninety degree stress vs. strain');  
  xlabel('Axial strain (%)')
  ylabel('Stress (ksi)')
end

temp = polyfit(deg_0.axial,deg_0.trans,1);
deg_0.v = abs(temp(1));
temp = polyfit(deg_45.axial,deg_45.trans,1);
deg_45.v = abs(temp(1));
temp = polyfit(deg_90.axial(3:end),deg_90.trans(3:end),1);
deg_90.v = abs(temp(1));

if(plots)
  figure('Name', 'Zero degree axial vs. transverse');
  scatter(deg_0.axial,deg_0.trans);
  title('Zero degree axial vs. transverse');
  xlabel('Axial strain (%)')
  ylabel('Transverse strain (%)')
  
  figure('Name', 'Forty-five degree axial vs. transverse');
  scatter(deg_45.axial,deg_45.trans);
  title('Forty-five degree axial vs. transverse');
  xlabel('Axial strain (%)')
  ylabel('Transverse strain (%)')

  figure('Name', 'Ninety degree axial vs. transverse');
  scatter(deg_90.axial(3:end),deg_90.trans(3:end));
  title('Ninety degree axial vs. transverse');
  xlabel('Axial strain (%)')
  ylabel('Transverse strain (%)')
end

% Compliance matrix

E1 = deg_0.E;
v21 = deg_0.v;
E2 = deg_90.E;
v12 = deg_90.v;
G12 = deg_45.E/(2*(1 + deg_45.v));

C = [1/E1 -v12/E2 0; -v21/E1 1/E2 0; 0 0 1/G12];

