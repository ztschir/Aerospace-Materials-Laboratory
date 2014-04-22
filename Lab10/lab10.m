clear all;
clc;

rate = 0.06 / 60; % in/s

spec1.t = .509;
spec2.t = .2561;
spec3.t = .126;
spec4.t = .5;
spec5.t = .251;
spec6.t = .122;
spec7.t = .5;
spec8.t = .251;
spec9.t = .126;
spec10.t = .5;
spec11.t = .251;
spec12.t = .126;
spec13.t = .502;
spec14.t = .252;
spec15.t = .127;
spec16.t = .503;
spec17.t = .254;
spec18.t = .127;

spec1.w = 2.0345;
spec2.w = 2.1125;
spec3.w = 1.96;
spec4.w = 2.04;
spec5.w = 2.023;
spec6.w = 1.967;
spec7.w = 2.053;
spec8.w = 2.06;
spec9.w = 2.09;
spec10.w = 2.053;
spec11.w = 2.06;
spec12.w = 2.09;
spec13.w = 1.98;
spec14.w = 1.991;
spec15.w = 1.97;
spec16.w = 2.061;
spec17.w = 2.002;
spec18.w = 1.993;

spec1.a = 1.140;
spec2.a = .7975;
spec3.a = 1.321;
spec4.a = 1.127;
spec5.a = .759;
spec6.a = 1.098;
spec7.a = 1.310;
spec8.a = .946;
spec9.a = 1.138;
spec10.a = 1.310;
spec11.a = .946;
spec12.a = 1.138;
spec13.a = 1.204;
spec14.a = .822;
spec15.a = 1.112;
spec16.a = 1.473;
spec17.a = .890;
spec18.a = .850;

spec1.data = tdfread('spec1.dat');
spec2.data = tdfread('spec2.dat');
spec3.data = tdfread('spec3.dat');
spec4.data = tdfread('spec4.dat');
spec5.data = tdfread('spec5.dat');
spec6.data = tdfread('spec6.dat');
spec7.data = tdfread('spec7.dat');
spec8.data = tdfread('spec8.dat');
spec9.data = tdfread('spec9.dat');
spec10.data =tdfread('spec10.dat');
spec11.data =tdfread('spec11.dat');
spec12.data =tdfread('spec12.dat');
spec13.data =tdfread('spec13.dat');
spec14.data =tdfread('spec14.dat');
spec15.data =tdfread('spec15.dat');
spec16.data =tdfread('spec16.dat');
spec17.data =tdfread('spec17.dat');
spec18.data =tdfread('spec18.dat');

spec = [spec1 spec2 spec3 spec4 spec5 spec6 spec7 spec8 spec9 spec10 ...
       spec11 spec12 spec13 spec14 spec15 spec16 spec17 spec18];
spec_half = {};
spec_quart = {};
spec_eighth = {};
k = 1; j = 1; f = 1;

for i = 1:length(spec)
  x = spec(i).a / spec(i).w;
  spec(i).Kc = (max(spec(i).data.Load)/(spec(i).t*sqrt(spec(i).w)))*...
                                             (29.6*(x^(1/2)) -  ...
                                             185.5*(x^(3/2)) + ...
                                             655.7*(x^(5/2)) - ...
                                             1017* (x^(7/2)) +  ...
                                             639*  (x^(9/2)));
  spec(i).stress = spec(i).data.Load ./ ((spec(i).w - spec(i).a) * ...
                                          spec(i).t);
  spec(i).displacement = spec(i).data.Time .* rate; % assuming
                                                    % constant rate
  temp = find([spec(i).data.Load - spec(i).data.Load(1)] > 80);
  spec(i).begin_v = temp(1);
  
  [temp,ind] = max(spec(i).data.Load);
  spec(i).end_v = ind - 100;

  temp = polyfit(spec(i).displacement(spec(i).begin_v:spec(i).end_v), ...
                 spec(i).data.Load(spec(i).begin_v:spec(i).end_v),1);
  spec(i).compliance = temp(1);
end


%figure('Name', 'Crack Length vs. Kc');
%scatter([spec(1:3).a], [spec(1:3).Kc]./1000);
%title('Crack Length vs. Kc');
%xlabel('Crack length (in)');
%ylabel('Kc');

spec_half.avgKc = mean([spec([1 4 7 10 13 16]).Kc])
spec_quart.avgKc = mean([spec([2 5 8 11 14 17]).Kc])
spec_eighth.avgKc = mean([spec([3 6 9 12 15 18]).Kc])

spec_half.avga = mean([spec([1 4 7 10 13 16]).a]);
spec_quart.avga = mean([spec([2 5 8 11 14 17]).a]);
spec_eighth.avga = mean([spec([3 6 9 12 15 18]).a]);

spec_half.avgw = mean([spec([1 4 7 10 13 16]).w]);
spec_quart.avgw = mean([spec([2 5 8 11 14 17]).w]);
spec_eighth.avgw = mean([spec([3 6 9 12 15 18]).w]);

spec_half.avgt = mean([spec([1 4 7 10 13 16]).t]);
spec_quart.avgt = mean([spec([2 5 8 11 14 17]).t]);
spec_eighth.avgt = mean([spec([3 6 9 12 15 18]).t]);

spec_half.avgC = mean([spec([1 4 7 10 13 16]).compliance]);
spec_quart.avgC = mean([spec([2 5 8 11 14 17]).compliance]);
spec_eighth.avgC = mean([spec([3 6 9 12 15 18]).compliance]);

spec_avg = [spec_half spec_quart spec_eighth];

%figure('Name', 'Thickness vs. Kc');
%scatter([spec.t], [spec.Kc]);
%title('Thickness vs. Kc');
%xlabel('Thickness (in)');
%ylabel('Kc');

%figure('Name', 'Average Thickness vs. Kc');
%scatter([spec_avg.avgt], [spec_avg.avgKc]./1000);
%title('Average Thickness vs. Kc');
%xlabel('Thickness (in)');
%ylabel('Kc');

yield_stress = 57000;

temp = 2.5*(spec_half.avgKc/yield_stress)^2;
fprintf(['half inch w: %f a: %f thickness: %f frac tough: %f Kc: %f ' ...
         'compliance: %f \n'], spec_half.avgw, ...
        spec_half.avga, spec_half.avgt, temp, spec_half.avgKc, spec_half.avgC);

temp = 2.5*(spec_quart.avgKc/yield_stress)^2;
fprintf(['quart inch w: %f a: %f thickness: %f frac tough: %f Kc: ' ...
         '%f compliance: %f\n'], spec_quart.avgw, ...
        spec_quart.avga, spec_quart.avgt, temp, spec_quart.avgKc, spec_quart.avgC);
temp = 2.5*(spec_eighth.avgKc/yield_stress)^2;
fprintf(['eighth inch w: %f a: %f thickness: %f frac tough: %f Kc: ' ...
'%f compliance: %f \n'], spec_eighth.avgw, ...
        spec_eighth.avga, spec_eighth.avgt, temp, spec_eighth.avgKc, ...
        spec_eighth.avgC);

%figure('Name', 'Compliance vs. Crack length');
%scatter([spec.a], [spec.compliance]);
%title('Compliance vs. Crack length');
%xlabel('Crack length');
%ylabel('Compliance');

figure('Name', 'Average Compliance vs. Crack length');
hold on;
for i = 1:3
  scatter(spec_avg(i).avga, spec_avg(i).avgC);
end
legend('0.5 inch','0.25 inch', '0.125 inch');
title('Average Compliance vs. Crack length');
xlabel('Crack length');
ylabel('Compliance');
hold off;


%figure('Name', 'Crosshead Displacement vs. Load');
%hold on;
%for i = 1:length(spec)
%  scatter(spec(i).displacement, spec(i).data.Load);
%end
%title('Displacement vs. Load');
%xlabel('Crosshead Displacement (in)');
%ylabel('Load');
%hold off;

%figure('Name', 'Sample Crosshead Displacement vs. Load');
%hold on;
%for i = 4:6
%  scatter(spec(i).displacement, spec(i).data.Load);
%end
%title('Sample Displacement vs. Load');
%xlabel('Crosshead Displacement (in)');
%ylabel('Load');
%legend('0.5 inch','0.25 inch', '0.125 inch');
%hold off;


%figure('Name', 'Linear Portions of displacement vs. Load');
%hold on;
%for i = 1:length(spec)
%  scatter(spec(i).displacement(spec(i).begin_v:spec(i).end_v), ...
%          spec(i).data.Load(spec(i).begin_v:spec(i).end_v));
%end
%title('Linear Portions of displacement vs. Load');
%xlabel('Crosshead Displacement (in)');
%ylabel('Load');
%hold off;

