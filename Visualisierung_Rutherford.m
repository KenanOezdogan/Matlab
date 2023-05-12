clear all
close all
clc

%% Verlauf der Rutherfordschen Streuformel

%% Ladung z Proton
zp = 1.602*1e-19;
%% Wasserstoffkern 1 Proton
zwss = 1.602*1e-19;
%% elektrische Ladung
e_l = -1.602*1e-19;
%% Elektrische Feldkonstante
e_0 = 8.854*1e-12;
%% Masse Teilchen in kg
me = 9.11 *1e-31;
%% Geschwindigkeit v in ms
v = 300; % 300 m/s

%% Definiere meine Matrix, Fovx = 1 nm, Fovy = 1 nm
Fovx = 1*1e-9; % 1 nm
Fovy = 1*1e-9;
N = 1000;
dFx = Fovx/N;
dFy = Fovy/N;
FovxVektor = [-Fovx/2:dFx:Fovx/2];
FovyVektor = [-Fovy/2:dFy:Fovy/2];
[xm ym] = meshgrid(FovxVektor,FovyVektor);
M = sqrt(xm.^2+ym.^2);

figure(1)
plot(0,0,'or','MarkerFaceColor','r')
hold on
plot(xm(round(N/2),1),ym(end,1),'or','MarkerFaceColor','r')
grid on
xlabel('x [nm]')
ylabel('y [cm]')
xlim([3*xm(1,1) 3*xm(1,end)])
ylim([3*ym(1,1) 3*ym(end,1)])

Fc = (zp*e_l)/(4*pi*e_0*M(1,1)^2);
a = Fc / me;

rstart = sqrt(xm(round(N/2),1)^2+ym(end,1)^2);

Nt = 100;
tend = 1e-12; % pikoSekunden
deltaT = tend/Nt;
t = [0:deltaT:tend];

%% VZ von M Feld, Koordinatensystem
M(1:end,1:round(N/2)) = M(1:end,1:round(N/2)).*-1;
M(round(N/2)+1:end,round(N/2):end) = M(round(N/2)+1:end,round(N/2):end).*-1;

winkel_neu = 0;

for i = 1:length(t)
    delta_s = (0.5*a*(deltaT)^2) + (v*(deltaT)); %% Das ist der Weg den mein teilchen gelaufen ist
    rneu = sqrt(rstart^2 - delta_s^2); %% Länge des neuen Abstands
    v = a*t(i)+deltaT;
    Fc = (zp*e_l)/(4*pi*e_0*rneu^2);
    a = Fc / me;
    x_wert = xm(round(N/2),1)+delta_s;
    y_wert = rneu;

    figure(1)
    clf
    plot(0,0,'or','MarkerFaceColor','r')
    hold on
    plot(x_wert,y_wert,'or','MarkerFaceColor','r')
    grid on
    xlabel('x [m]')
    ylabel('y [m]')
    xlim([3*xm(1,1) 3*xm(1,end)])
    ylim([3*ym(1,1) 3*ym(end,1)])
end





