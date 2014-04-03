clear all;
clc;

%temp_21 = tdfread('21.dat');
%temp_51 = tdfread('51.dat');
%temp_63 = tdfread('63.dat');
%temp_82 = tdfread('82.dat');
%temp_93 = tdfread('93.dat');
%temp_103 = tdfread('103.dat');
%temp_121 = tdfread('121.dat');
%
disp = .1; % inches
cross_sec_area = .249 * .494;
%
%time_21 = find(temp_21.Time > 10);
%time_51 = find(temp_51.Time > 10);
%time_63 = find(temp_63.Time > 10);
%time_82 = find(temp_82.Time > 10);
%time_93 = find(temp_93.Time > 10);
%time_103 = find(temp_103.Time > 10);
%time_121 = find(temp_121.Time > 10);
%
%
%
%relax_21 = (temp_21.Time(time_21(1))/cross_sec_area)/disp;
%relax_51 = (temp_51.Time(time_51(1))/cross_sec_area)/disp;
%relax_63 = (temp_63.Time(time_63(1))/cross_sec_area)/disp;
%relax_82 = (temp_82.Time(time_82(1))/cross_sec_area)/disp;
%relax_93 = (temp_93.Time(time_93(1))/cross_sec_area)/disp;
%relax_103 = (temp_103.Time(time_103(1))/cross_sec_area)/disp;
%relax_121 = (temp_121.Time(time_121(1))/cross_sec_area)/disp;

temp_21 = csvread('21.csv');

T = [21 51 63 82 93 103 121];
%relax = [relax_21 relax_51 relax_63 relax_82 relax_93 relax_103 ...
%         relax_121];
%semilogy(T, relax);

plot(temp_21(300:end,1),(temp_21(300:end,2)./cross_sec_area)./(max(temp_21(:,2))/cross_sec_area));
