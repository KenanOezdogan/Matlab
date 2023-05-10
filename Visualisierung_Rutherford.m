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
winkel = pi/4;
b = ((zp*zwss*e_l^2)/(4*pi*e_0*mp*v^2)).*cot(winkel/2);

%% Male erst Punktladung in blau in Abstand 5 cm vom Koordinatenursprung

xp = 0.1;  % x-Koordinate des Punktes statisch
yp = 0;  % y-Koordinate des Punktes statisch
rp = 0.08;  % Radius des Punktes

figure(1)
fill(xp + rp*cos(linspace(0, 2*pi)), yp + rp*sin(linspace(0, 2*pi)), 'b')
xlim([0 10])
ylim([-30 100])
grid on
xlabel('x [cm]')
ylabel('y [cm]')

xpf = 0;
ypf = b;

r0 = sqrt(xpf^2+ypf^2);
winkelstart = pi/2; % in radiand phi
r_res = sqrt(xp^2 + yp^2) ; % xp const, rres const

for phi = [winkelstart:-pi/100:0]

    r0 = b*(1+cos(phi)/sin(phi)); %betrag
    xpf = r0*sin(phi);
    ypf = b;

    r1 = r0 - r_res;

    Fc = ((e_l^2)/(4*pi*e_0))*(1/r1^2);
    %probieren als richtung
    vy = v*sin(phi)
    grenze = sqrt(r1^2+vy^2);
    % beta = asin((r_res-xpf)/r1);
    % Fcx = Fc*cos(beta);
    % Fcy = Fc*sin(beta);

    if grenze > b
        figure(1)
        clf
        plot(xp,yp,'ob','MarkerFaceColor','b')
        hold on
        plot(xpf,grenze,'or','MarkerFaceColor','r')
        xlim([-2*xp 2*xp])
        ylim([-2*b 2*b])
        grid on
        xlabel('x [cm]')
        ylabel('y [cm]')
    else
        figure(1)
        clf
        plot(xp,yp,'ob','MarkerFaceColor','b')
        hold on
        plot(xpf,ypf,'or','MarkerFaceColor','r')
        xlim([-2*xp 2*xp])
        ylim([-2*b 2*b])
        grid on
        xlabel('x [cm]')
        ylabel('y [cm]')
    end
end