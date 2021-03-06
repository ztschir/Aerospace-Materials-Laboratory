clear all;
clc;


%+---------+-----+-----+-----+-----+
%|Materials|d0   |df   |L0   |Lf   |
%+---------+-----+-----+-----+-----+
%|Untreated|0.496|0.417|2    |2.417|
%+---------+-----+-----+-----+-----+
%|30 min   |0.498|0.436|2    |2.36 |
%+---------+-----+-----+-----+-----+
%|2 hours  |0.502|0.425|2    |2.447|
%+---------+-----+-----+-----+-----+
%|6 hours  |0.497|0.411|2    |2.379|
%+---------+-----+-----+-----+-----+
%|24 hours |0.503|0.437|2    |2.277|
%+---------+-----+-----+-----+-----+
%|Anealed  |0.503|0.435|2    |2.349|
%+---------+-----+-----+-----+-----+

untreated.d0 = 0.496;
untreated.df = 0.417;
untreated.L0 = 2;
untreated.Lf = 2.417;

thirtymin.d0 = 0.498;
thirtymin.df = 0.436;
thirtymin.L0 = 2;
thirtymin.Lf = 2.36;

twohour.d0 = 0.502;
twohour.df = 0.425;
twohour.L0 = 2;
twohour.Lf = 2.447;

sixhour.d0 = 0.497;
sixhour.df = 0.411;
sixhour.L0 = 2;
sixhour.Lf = 2.379;

twentyfourhour.d0 = 0.503;
twentyfourhour.df = 0.437;
twentyfourhour.L0 = 2;
twentyfourhour.Lf = 2.277;

anealed.d0 = 0.503;
anealed.df = 0.435;
anealed.L0 = 2;
anealed.Lf = 2.349;

%% Load csv files %%

%%% Column Format %%%
%%% Time,Extension,Load,Strain 1,Strain 2,Displacement (Strain 1),Displacement (Strain 2)
%%%%% (sec),(in),(lbf),(%),(%),(in),(in)

untreatedtemp       = csvread('1-untreated.csv');
untreated.time      = untreatedtemp(1:(end-5),1);
untreated.extension = untreatedtemp(1:(end-5),2);
untreated.load      = untreatedtemp(1:(end-5),3);
untreated.strain1   = untreatedtemp(1:(end-5),4);
untreated.strain2   = untreatedtemp(1:(end-5),5);
untreated.disp1     = untreatedtemp(1:(end-5),6);
untreated.disp2     = untreatedtemp(1:(end-5),7);
clear untreatedtemp;

thirtymintemp       = csvread('2-30min.csv');
thirtymin.time      = thirtymintemp(1:(end-5),1);
thirtymin.extension = thirtymintemp(1:(end-5),2);
thirtymin.load      = thirtymintemp(1:(end-5),3);
thirtymin.strain1   = thirtymintemp(1:(end-5),4);
thirtymin.strain2   = thirtymintemp(1:(end-5),5);
thirtymin.disp1     = thirtymintemp(1:(end-5),6);
thirtymin.disp2     = thirtymintemp(1:(end-5),7);
clear thirtymintemp;

twohourtemp       = csvread('3-2hr.csv');
twohour.time      = twohourtemp(1:(end-5),1);
twohour.extension = twohourtemp(1:(end-5),2);
twohour.load      = twohourtemp(1:(end-5),3);
twohour.strain1   = twohourtemp(1:(end-5),4);
twohour.strain2   = twohourtemp(1:(end-5),5);
twohour.disp1     = twohourtemp(1:(end-5),6);
twohour.disp2     = twohourtemp(1:(end-5),7);
clear twohourtemp;

sixhourtemp       = csvread('4-6hrs.csv');
sixhour.time      = sixhourtemp(1:(end-5),1);
sixhour.extension = sixhourtemp(1:(end-5),2);
sixhour.load      = sixhourtemp(1:(end-5),3);
sixhour.strain1   = sixhourtemp(1:(end-5),4);
sixhour.strain2   = sixhourtemp(1:(end-5),5);
sixhour.disp1     = sixhourtemp(1:(end-5),6);
sixhour.disp2     = sixhourtemp(1:(end-5),7);
clear sixhourtemp;

twentyfourhourtemp       = csvread('5-24hr.csv');
twentyfourhour.time      = twentyfourhourtemp(1:(end-5),1);
twentyfourhour.extension = twentyfourhourtemp(1:(end-5),2);
twentyfourhour.load      = twentyfourhourtemp(1:(end-5),3);
twentyfourhour.strain1   = twentyfourhourtemp(1:(end-5),4);
twentyfourhour.strain2   = twentyfourhourtemp(1:(end-5),5);
twentyfourhour.disp1     = twentyfourhourtemp(1:(end-5),6);
twentyfourhour.disp2     = twentyfourhourtemp(1:(end-5),7);
clear twentyfourhourtemp;

anealedtemp       = csvread('6-anealed.csv');
anealed.time      = anealedtemp(1:(end-5),1);
anealed.extension = anealedtemp(1:(end-5),2);
anealed.load      = anealedtemp(1:(end-5),3);
anealed.strain1   = anealedtemp(1:(end-5),4);
anealed.strain2   = anealedtemp(1:(end-5),5);
anealed.disp1     = anealedtemp(1:(end-5),6);
anealed.disp2     = anealedtemp(1:(end-5),7);
clear anealedtemp;


%%% Young's Modulus %%%
temp = polyfit(untreated.strain1(1:500),4.*untreated.load(1:500) ./ (pi*(untreated.d0^2)),1);
untreated.youngs = temp(1);

temp = polyfit(thirtymin.strain1(1:500),4.*thirtymin.load(1:500) ./ (pi*(thirtymin.d0^2)),1);
thirtymin.youngs = temp(1)

temp = polyfit(twohour.strain1(1:500),4.*twohour.load(1:500) ./ (pi*(twohour.d0^2)),1);
twohour.youngs = temp(1);

temp = polyfit(sixhour.strain1(1:500),4.*sixhour.load(1:500) ./ (pi*(sixhour.d0^2)),1);
sixhour.youngs = temp(1);

temp = polyfit(twentyfourhour.strain1(1:1100),4.*twentyfourhour.load(1:1100) ./ (pi*(twentyfourhour.d0^2)),1);
twentyfourhour.youngs = temp(1);

temp = polyfit(anealed.strain1(1:500),4.*anealed.load(1:500) ./ (pi*(anealed.d0^2)),1);
anealed.youngs = temp(1);

% Stress = 4*load / pi*d0^2

figure('Name','Untreated stress-strain')
untreatedplot = plot(untreated.strain1, 4.*untreated.load ./ (pi*(untreated.d0^2)),...
    100*untreated.extension./untreated.L0, ...
    4.*untreated.load./(pi*(untreated.d0^2)), ...
    untreated.strain1(1:2050), ...
    (untreated.youngs).*untreated.strain1(1:2050) - 0.2*(untreated.youngs));
xlabel('Engineering Strain (in/in)');
ylabel('Engineering Stress (psi)');
title('Engineering Stress-Strain diagram for Untreated aluminum');
legend('Extensometer Data', 'Crosshead displacement', '0.2% offset');

figure('Name','Thirtymin stress-strain')
plot(thirtymin.strain1, 4.*thirtymin.load ./ (pi*(thirtymin.d0^2)),...
    100*thirtymin.extension./thirtymin.L0, ...
    4.*thirtymin.load ./ (pi*(thirtymin.d0^2)), ...
    thirtymin.strain1(1:2500), ...
    (thirtymin.youngs).*thirtymin.strain1(1:2500) - 0.2*(thirtymin.youngs));
xlabel('Engineering Strain (in/in)');
ylabel('Engineering Stress (psi)');
title('Engineering Stress-Strain diagram for 0.5 hour treated aluminum');
legend('Extensometer Data', 'Crosshead displacement', '0.2% offset');

figure('Name','Twohour stress-strain')
plot(twohour.strain1, 4.*twohour.load ./ (pi*(twohour.d0^2)),...
    100*twohour.extension./twohour.L0, ...
    4.*twohour.load ./ (pi*(twohour.d0^2)), ...
    twohour.strain1(1:1550), ...
    (twohour.youngs).*twohour.strain1(1:1550) - 0.2*(twohour.youngs));
xlabel('Engineering Strain (in/in)');
ylabel('Engineering Stress (psi)');
title('Engineering Stress-Strain diagram for 2 hour treated aluminum');
legend('Extensometer Data', 'Crosshead displacement', '0.2% offset');


figure('Name','Sixhour stress-strain')
plot(sixhour.strain1, 4.*sixhour.load ./ (pi*(sixhour.d0^2)),...
    100*sixhour.extension./sixhour.L0, ...
    4.*sixhour.load ./ (pi*(sixhour.d0^2)), ...
    sixhour.strain1(1:2050), ...
    (sixhour.youngs).*sixhour.strain1(1:2050) - 0.2*(sixhour.youngs));
xlabel('Engineering Strain (in/in)');
ylabel('Engineering Stress (psi)');
title('Engineering Stress-Strain diagram for 6 hour treated aluminum');
legend('Extensometer Data', 'Crosshead displacement', '0.2% offset');


figure('Name','Twentyfourhour stress-strain')
plot(twentyfourhour.strain1, 4.*twentyfourhour.load ./ (pi*(twentyfourhour.d0^2)),...
    100*twentyfourhour.extension./twentyfourhour.L0, ...
    4.*twentyfourhour.load ./ (pi*(twentyfourhour.d0^2)), ...
    twentyfourhour.strain1(1:3000), ...
    (twentyfourhour.youngs).*twentyfourhour.strain1(1:3000) - ...
    0.2*(twentyfourhour.youngs));
xlabel('Engineering Strain (in/in)');
ylabel('Engineering Stress (psi)');
title('Engineering Stress-Strain diagram for 24 hour treated aluminum');
legend('Extensometer Data', 'Crosshead displacement', '0.2% offset');


figure('Name','Anealed stress-strain')
plot(anealed.strain1, 4.*anealed.load ./ (pi*(anealed.d0^2)),...
    100*anealed.extension./anealed.L0, ...
    4.*anealed.load ./ (pi*(anealed.d0^2)), ...
    anealed.strain1(1:700), ...
    (anealed.youngs).*anealed.strain1(1:700) - 0.2*(anealed.youngs));
xlabel('Engineering Strain (in/in)');
ylabel('Engineering Stress (psi)');
title('Engineering Stress-Strain diagram for Anealed aluminum');
legend('Extensometer Data', 'Crosshead displacement', '0.2% offset');


%figure('Name','All stress-strain diagrams');
%plot(untreated.strain1, 4.*untreated.load ./ (pi*(untreated.d0^2)),...
%    thirtymin.strain1, 4.*thirtymin.load ./ (pi*(thirtymin.d0^2)),...
%    twohour.strain1, 4.*twohour.load ./ (pi*(twohour.d0^2)),...
%    sixhour.strain1, 4.*sixhour.load ./ (pi*(sixhour.d0^2)),...
%    twentyfourhour.strain1, 4.*twentyfourhour.load ./ (pi*(twentyfourhour.d0^2)),...
%    anealed.strain1, 4.*anealed.load ./ (pi*(anealed.d0^2)))
%
%figure('Name', 'Untreated Poissons Ratio')
%hold on
%plot(-untreated.strain2(1:3892),untreated.strain1(1:3892),'.');
%lsline
%hold off
%
%figure('Name', 'Thirtymin Poissons Ratio')
%hold on
%plot(-thirtymin.strain2(1:3892),thirtymin.strain1(1:3892),'.');
%lsline
%hold off
%
%figure('Name', 'Twohour Poissons Ratio')
%hold on
%plot(-twohour.strain2(1:1947),twohour.strain1(1:1947),'.');
%lsline
%hold off
%
%figure('Name', 'Sixhour Poissons Ratio')
%hold on
%plot(-sixhour.strain2(1:2649),sixhour.strain1(1:2649),'.');
%lsline
%hold off
%
%figure('Name', 'Twentyfourhour Poissons Ratio')
%hold on
%plot(-twentyfourhour.strain2(1:3892),twentyfourhour.strain1(1:3892),'.');
%lsline
%hold off
%
%figure('Name', 'Anealed Poissons Ratio')
%hold on
%plot(-anealed.strain2(1:2400),anealed.strain1(1:2400),'.');
%lsline
%hold off
%
%%% Poisson's Ratio Calc %%%
temp = polyfit(-untreated.strain2(1:3892),untreated.strain1(1:3892),1);
untreated.poisson = -1/temp(1);

temp = polyfit(-thirtymin.strain2(1:3892),thirtymin.strain1(1:3892),1);
thirtymin.poisson = -1/temp(1);

temp = polyfit(-twohour.strain2(1:1947),twohour.strain1(1:1947),1);
twohour.poisson = -1/temp(1);

temp = polyfit(-sixhour.strain2(1:2649),sixhour.strain1(1:2649),1);
sixhour.poisson = -1/temp(1);

temp = polyfit(-twentyfourhour.strain2(1:3892),twentyfourhour.strain1(1:3892),1);
twentyfourhour.poisson = -1/temp(1);

temp = polyfit(-anealed.strain2(1:2400),anealed.strain1(1:2400),1);
anealed.poisson = -1/temp(1);

% Yield Stress
untreated.yieldstress      = 50610;
thirtymin.yieldstress      = 49310;
twohour.yieldstress        = 49720;
sixhour.yieldstress        = 51530;
twentyfourhour.yieldstress = 61630;
anealed.yieldstress        = 13430;

% Ultimate Tensile strength
untreated.ultimatetensile = max(4.*untreated.load ./ (pi* ...
                                                  (untreated.d0^2)));
thirtymin.ultimatetensile = max(4.*thirtymin.load ./ (pi* ...
                                                  (thirtymin.d0^2)));
twohour.ultimatetensile = max(4.*twohour.load ./ (pi* ...
                                                  (twohour.d0^2)));
sixhour.ultimatetensile = max(4.*sixhour.load ./ (pi* ...
                                                  (sixhour.d0^2)));
twentyfourhour.ultimatetensile = max(4.*twentyfourhour.load ./ (pi* ...
                                                  (twentyfourhour.d0^2)));
anealed.ultimatetensile = max(4.*anealed.load ./ (pi* ...
                                                  (anealed.d0^2)));

% Toughness

untreated.toughness = sum(4.*untreated.load(1:end-20) ./ (pi* ...
                               (untreated.d0^2)))*mean(diff(untreated.strain1))
thirtymin.toughness = sum(4.*thirtymin.load(1:end-20) ./ (pi* ...
                               (thirtymin.d0^2)))*mean(diff(thirtymin.strain1));
twohour.toughness = sum(4.*twohour.load(1:end-20) ./ (pi* ...
                               (twohour.d0^2)))*mean(diff(twohour.strain1));
sixhour.toughness = sum(4.*sixhour.load(1:end-20) ./ (pi* ...
                               (sixhour.d0^2)))*mean(diff(sixhour.strain1));
twentyfourhour.toughness = sum(4.*twentyfourhour.load(1:end-20) ./ (pi* ...
                               (twentyfourhour.d0^2)))*mean(diff(twentyfourhour.strain1));
anealed.toughness = sum(4.*anealed.load(1:end-20) ./ (pi* ...
                               (anealed.d0^2)))*mean(diff(anealed.strain1));

% Ductility

untreated.ductility      = untreated.strain1(end-10)
thirtymin.ductility      = thirtymin.strain1(end-10)
twohour.ductility        = twohour.strain1(end-10)
sixhour.ductility        = sixhour.strain1(end-10)
twentyfourhour.ductility = twentyfourhour.strain1(end-10)
anealed.ductility        = anealed.strain1(end-10)
