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
v = 300; %m/s  

%% Definiere meine Matrix, Fovx = 10 nm, Fovy = 10 nm
Fovx = 10*1e-9; % 10 nm
Fovy = 10*1e-9;
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
xlim([10*xm(1,1) 10*xm(1,end)])
ylim([10*ym(1,1) 10*ym(end,1)])

Nt = 1000;
tend = 10e-12; % mS
deltaT = tend/Nt;
t = [0:deltaT:tend];

%% VZ von M Feld, Koordinatensystem
M(1:end,1:round(N/2)) = M(1:end,1:round(N/2)).*-1;
M(round(N/2)+1:end,round(N/2):end) = M(round(N/2)+1:end,round(N/2):end).*-1;

xk = xm(round(N/2),1);
yk = ym(end,1);

Fc = (zp*e_l)/(4*pi*e_0*M(1,1)^2);

Fcx = Fc.*cos(pi/4);
ax = Fcx / me*-1;
Fcy = Fc.*sin(pi/4)*-1;
ay = Fcy / me*-1;

for i = 1:length(t)
    vx = ax*t(i);
    vy = ay*t(i);
    pause(0.01)

    delta_sx = (0.5*ax*(t(i))^2) + (vx*(t(i)));
    delta_sy = (0.5*ay*(t(i))^2) + (vy*(t(i)));

    xk = xk +delta_sx;
    yk = yk +delta_sy;
    
    figure(1)
    clf
    plot(0,0,'or','MarkerFaceColor','r')
    hold on
    plot(xk,yk,'or','MarkerFaceColor','r')
    grid on
    xlabel('x [m]')
    ylabel('y [m]')
    xlim([10*xm(1,1) 10*xm(1,end)])
    ylim([10*ym(1,1) 10*ym(end,1)])

    Fc = (zp*e_l)/(4*pi*e_0*sqrt((xk^2)+(yk^2))^2);

end





