clear all
close all
clc

%% Verlauf der Rutherfordschen Streuformel

%% Ladung z Proton
zp = 1.602*1e-19;
%% Wasserstoffkern 1 Proton
zwss = 1.602*1e-19;

%% elektrische Ladung
e_l = 1.602*1e-19;
%% Elektrische Feldkonstante
e_0 = 8.854*1e-12;
%% Masse Teilchen in kg
mp = 1.672*1e-27;

%% Geschwindigkeit v in ms
v = 3e8; %Lichtgeschwindigkeit
%% Winkel der Abweichung von 90 Grad bis -90 Grad
phi = [pi/2:-pi/100:-pi/2];
b = ((zp*zwss*e_l^2)/(4*pi*e_0*mp*v^2)).*cot(phi/2);

%% Male erst Punktladung in blau in Abstand 5 cm vom Koordinatenursprung

xp = 5;  % x-Koordinate des Punktes
yp = 0;  % y-Koordinate des Punktes
rp = 0.08;  % Radius des Punktes

figure(1)
fill(xp + rp*cos(linspace(0, 2*pi)), yp + rp*sin(linspace(0, 2*pi)), 'b')
xlim([0 10])
ylim([-30 100])
grid on
xlabel('x [cm]')
ylabel('y [cm]')

x = [-100:100];
y = [-100:100];

phi_r = [pi:-pi/100:0];

rx = x*cosd(phi(0));
ry = 

for i = 1:length(b)
    
end