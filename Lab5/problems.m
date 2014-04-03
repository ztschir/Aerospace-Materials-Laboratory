function problems

clear all;
clc;

t1 = [0 50 200 400 600 800 1000];
ts3000 = [0 .020 .028 .030 .031 .033 .035];
ts5000 = [0 .045 .053 .055 .058 .062 .065];
ts8000 = [0 .099 .14  .149 .155 .164 .173];
ts11000 =[0 .135 .238 .305 .368 .433 .520];

%figure ('Name', 'Creep curve');
%plot(t1, ts3000, t1, ts5000, t1, ts8000, t1, ts11000);
%legend('3000 psi', '5000 psi', '8000 psi', '11000 psi');
%xlabel('Time (hr)');
%ylabel('Tensile Stress (psi)');

dt = mean(diff(t1(3:end)));
ds3000 = mean(diff(ts3000(3:end)));
ds5000 = mean(diff(ts5000(3:end)));
ds8000 = mean(diff(ts8000(3:end)));
ds11000 = mean(diff(ts11000(3:end)));

ep3000 = ds3000/dt;
ep5000 = ds5000/dt;
ep8000 = ds8000/dt;
ep11000 = ds11000/dt;

stress = log([3000 5000 8000 11000]/3000);
ep = log([ep3000 ep5000 ep8000 ep11000]);
%plot(stress,ep);
%xlabel('log(stress/stress_0)');
%ylabel('log(strain)');


Temp = [650 650 650 650 650 650 705 705 705 705 760 760 760 760 ...
       815 815 815 815 815 870 870 870 870 900 900 900];
Stress = [1000 950 895 840 820 790 815 695 635 590 600 515 440 415 ...
          460 395 345 260 220 260 215 180 145 170 140 105];
RuptureTime = [12 56 165 319 479 504 23 110 254 478 28 62 291 390 ...
               15 47 91 379 773 33 73 196 300 69 163 738];

%loglog(RuptureTime(1:6),Stress(1:6),...
%       RuptureTime(7:10),Stress(7:10),...
%       RuptureTime(11:14),Stress(11:14),...
%       RuptureTime(15:19),Stress(15:19),...
%       RuptureTime(20:23),Stress(20:23),...
%       RuptureTime(24:26),Stress(24:26));
%legend('650 degrees', '705 degrees', '760 degrees', '815 degrees', ...
%       '870 degrees', '900 degrees');
%ylabel('Stress (MPa)');
%xlabel('Rupture time (hr)');

K = Temp .* (20 + log(RuptureTime + 273));
Stress(end-8)
K(end-8)
%plot(K,Stress);

end