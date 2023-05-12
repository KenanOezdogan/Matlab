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
xlim([1.2*xm(1,1) 1.2*xm(1,end)])
ylim([1.2*ym(1,1) 1.2*ym(end,1)])

Fc = (zp*e_l)/(4*pi*e_0*M(1,1)^2);
a = Fc / me;

Nt = 10000;
tend = 1e-12; % pikoSekunden
deltaT = tend/Nt;
t = [0:deltaT:tend];

%% VZ von M Feld, Koordinatensystem
M(1:end,1:round(N/2)) = M(1:end,1:round(N/2)).*-1;
M(round(N/2)+1:end,round(N/2):end) = M(round(N/2)+1:end,round(N/2):end).*-1;

winkel_neu = 0;

for i = 1:5
    rneu = (0.5*a*(t(i)+deltaT)^2) + (v*(t(i)));
    if (abs(rneu) <= abs(M(1,1))) && (winkel_neu <=2*pi)
        phi_begin = 0;
        phi = [phi_begin:pi/100:2*pi];

        winkel_neu = (t(i)+deltaT)*v / rneu * (-1); % in radiant, (-1), da F Betrachtung anziehend, sonst +1
        %winkel_neu = winkel_neu *(360/2*pi)

        if (winkel_neu <= pi/2) && (winkel_neu >= 0)
            x_wert = rneu*cos(winkel_neu);
            x_stelle = find(xm(1,1:end) >= x_wert);
            x_stelle = x_stelle(1);
            x_wert = xm(1,x_stelle);

            y_wert = rneu*sin(winkel_neu);
            y_stelle = find(ym(1:end,1) >= y_wert);
            y_stelle = y_stelle(end);
            y_wert = ym(y_stelle,1);
        end
        if (winkel_neu > pi/2) && (winkel_neu <= pi)
            x_wert = rneu*cos(pi-winkel_neu);
            x_stelle = find(xm(1,1:end) >= x_wert);
            x_stelle = x_stelle(end);
            x_wert = xm(1,x_stelle);

            y_wert = rneu*sin(pi-winkel_neu);
            y_stelle = find(ym(1:end,1) >= y_wert);
            y_stelle = y_stelle(end);
            y_wert = ym(y_stelle,1);
        end
        if (winkel_neu > pi) && (winkel_neu <= (3*pi/2))
            x_wert = rneu*cos(winkel_neu-pi);
            x_stelle = find(xm(1,1:end) >= x_wert);
            x_stelle = x_stelle(end);
            x_wert = xm(1,x_stelle);

            y_wert = rneu*sin(winkel_neu-pi);
            y_stelle = find(ym(1:end,1) >= y_wert);
            y_stelle = y_stelle(1);
            y_wert = ym(y_stelle,1);
        end
        if (winkel_neu > 3*pi/2) && (winkel_neu <= 2*pi)
            x_wert = rneu*cos(winkel_neu-(3*pi/2));
            x_stelle = find(xm(1,1:end) >= x_wert);
            x_stelle = x_stelle(end);
            x_wert = xm(1,x_stelle);

            y_wert = rneu*sin(winkel_neu-(3*pi/2));
            y_stelle = find(ym(1:end,1) >= y_wert);
            y_stelle = y_stelle(end);
            y_wert = ym(y_stelle,1);
        end
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
    else
        break;
    end
    disp([x_wert y_wert])

    
end





