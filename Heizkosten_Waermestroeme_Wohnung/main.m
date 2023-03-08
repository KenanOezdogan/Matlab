clear all
close all
clc
%-------------------------
%% Author: Kenan Özdogan
%% Thema: Berechnung der Heizkosten und Wärmeströme einer Beispielwohnung im Vergleich mit einer zusätzlichen Wanddämmung
%% Wohnung: 7m*14m*3m, links: eine Tür, oben: 2 Fenster, 0.14 Euro pro Killowatt
%Flaechenberechnungen
%Waende
A_Wand_links = 7*3; %Rechteck 5m breit 2.5 m hoch
A_Wand_oben = 14 * 3;
A_Wand_rechts = 7*3;
A_Wand_unten = 14 *3; %natur, da keine Fenster
%Türen, Fenster
A_Tuer = 1*2; %Fläche, da Rechteck
A_Fenster_1_oben = 1.5^2;
A_Fenster_2_oben = 1.5^2;
%-------------------------
%Wärmedurchgangswiederstände
R_innen = 0.13; R1 = 0.017; R2 = 0.296; R3 = 0.017; R4 = 2.5;
R_aussen = 0.04;
%-------------------------
%U-Werte

U_Wand_allg = 1/(R_innen+R1+R2+R3+R_aussen);
U_Wand_allg_HS = 1/(R_innen+R1+R2+R3+R4+R_aussen); %mit Hartschaum
U_Tuer = 2;
U_Fenster = 1.4;
%-------------------------
%Wärmeströme (Verlust) ohne Hartschaum

delta_T = 20-8;

Q_Wand_links = U_Wand_allg*(A_Wand_links-A_Tuer)*delta_T;
Q_Tuer = U_Tuer*A_Tuer*delta_T;
Q_Wand_oben = U_Wand_allg*(A_Wand_oben-A_Fenster_1_oben-A_Fenster_2_oben)*delta_T;
Q_Fenster_1 = U_Fenster*A_Fenster_1_oben*delta_T;
Q_Fenster_2 = U_Fenster*A_Fenster_2_oben*delta_T;
Q_Wand_rechts = U_Wand_allg*A_Wand_rechts*delta_T;
Q_Wand_unten = U_Wand_allg*A_Wand_unten*delta_T;

Q_Summe_ohne = Q_Wand_links+Q_Tuer+Q_Wand_oben+Q_Fenster_1+Q_Fenster_2+Q_Wand_rechts+Q_Wand_unten;
%-------------------------
%Wärmeströme (Verlust) mit Hartschaum, nur Wände

Q_Wand_links_HS = U_Wand_allg_HS*(A_Wand_links-A_Tuer)*delta_T;
Q_Wand_oben_HS  = U_Wand_allg_HS*(A_Wand_oben-A_Fenster_1_oben-A_Fenster_2_oben)*delta_T;
Q_Wand_rechts_HS = U_Wand_allg_HS*A_Wand_rechts*delta_T;
Q_Wand_unten_HS = U_Wand_allg_HS*A_Wand_unten*delta_T;

Q_Summe_mitHS = Q_Wand_links_HS+Q_Tuer+Q_Wand_oben_HS+Q_Fenster_1+Q_Fenster_2+Q_Wand_rechts_HS+Q_Wand_unten_HS;
%--------------------------------------------------
%Werte in eine Matrix MW einfügen. W steht für Wärmestrom
MW(1,1) = Q_Wand_links;
MW(1,2) = Q_Wand_links_HS;
MW(2,1) = Q_Wand_oben;
MW(2,2) = Q_Wand_oben_HS;
MW(3,1) = Q_Wand_rechts;
MW(3,2) = Q_Wand_rechts_HS;
MW(4,1) = Q_Wand_unten;
MW(4,2) = Q_Wand_unten_HS;
MW(5,1) = Q_Tuer;
MW(5,2) = Q_Tuer;
MW(6,1) = Q_Fenster_1;
MW(6,2) = Q_Fenster_1;
MW(7,1) = Q_Fenster_2;
MW(7,2) = Q_Fenster_2;
%GEsamtwärmestrom in eine Matrix GW
GW(1,1) = Q_Summe_ohne;
GW(1,2) = Q_Summe_mitHS;

Bezeichnungen = ["linke Wand","obere Wand","rechte Wand","untere Wand","Tuer","Fenster Kueche","Fenster Bad"];
Bezeichnungen_g = ["Summe"];

X = categorical(Bezeichnungen);
X = reordercats(X,Bezeichnungen);

XG = categorical(Bezeichnungen_g);
XG = reordercats(XG,Bezeichnungen_g);
%--------------------------------------------------
%Heizkostenersparnis

Tage = 130;
Stunden = 155*24;

Q_Kosten_ohne = (Q_Summe_ohne/1000)*Stunden; %/1000 damit Q_summe in kWH ist
Q_Kosten_ohne = Q_Kosten_ohne*0.14;
fprintf('Kosten ohne Hartschaum: %f Euro \n',Q_Kosten_ohne)
Q_Kosten_HS = (Q_Summe_mitHS/1000)*Stunden; %/1000 damit Q_summe in kWH ist
Q_Kosten_HS = Q_Kosten_HS*0.12;
fprintf('Kosten mit Hartschaum: %f Euro',Q_Kosten_HS)

%Aufteilung in die einzelnen Wände

Q_Kosten_Wand_links = (Q_Wand_links/1000)*Stunden;
Q_Kosten_Wand_links = Q_Kosten_Wand_links*0.12;
Q_Kosten_Wand_links_HS = (Q_Wand_links_HS/1000)*Stunden;
Q_Kosten_Wand_links_HS= Q_Kosten_Wand_links_HS*0.12;

Q_Kosten_Wand_oben = (Q_Wand_oben/1000)*Stunden;
Q_Kosten_Wand_oben = Q_Kosten_Wand_oben*0.12;
Q_Kosten_Wand_oben_HS = (Q_Wand_oben_HS/1000)*Stunden;
Q_Kosten_Wand_oben_HS= Q_Kosten_Wand_oben_HS*0.12;

Q_Kosten_Wand_rechts = (Q_Wand_rechts/1000)*Stunden;
Q_Kosten_Wand_rechts = Q_Kosten_Wand_rechts*0.12;
Q_Kosten_Wand_rechts_HS = (Q_Wand_rechts_HS/1000)*Stunden;
Q_Kosten_Wand_rechts_HS= Q_Kosten_Wand_rechts_HS*0.12;

Q_Kosten_Wand_unten = (Q_Wand_unten/1000)*Stunden;
Q_Kosten_Wand_unten = Q_Kosten_Wand_unten*0.12;
Q_Kosten_Wand_unten_HS = (Q_Wand_unten_HS/1000)*Stunden;
Q_Kosten_Wand_unten_HS = Q_Kosten_Wand_unten_HS*0.12;

Q_Kosten_Fenster_1 = (Q_Fenster_1/1000)*Stunden;
Q_Kosten_Fenster_1 = Q_Kosten_Fenster_1*0.12;
Q_Kosten_Fenster_2 = (Q_Fenster_2/1000)*Stunden;
Q_Kosten_Fenster_2 = Q_Kosten_Fenster_2*0.12;
Q_Kosten_Tuer = (Q_Tuer/1000)*Stunden;
Q_Kosten_Tuer = Q_Kosten_Tuer*0.12;

%Kostenberechnungen in eien Matrix MK eintragen
MK(1,1) = Q_Kosten_Wand_links;
MK(1,2) = Q_Kosten_Wand_links_HS;
MK(2,1) = Q_Kosten_Wand_oben;
MK(2,2) = Q_Kosten_Wand_oben_HS;
MK(3,1) = Q_Kosten_Wand_rechts;
MK(3,2) = Q_Kosten_Wand_rechts_HS;
MK(4,1) = Q_Kosten_Wand_unten;
MK(4,2) = Q_Kosten_Wand_unten_HS;
MK(5,1) = Q_Kosten_Tuer;
MK(5,2) = Q_Kosten_Tuer;
MK(6,1) = Q_Kosten_Fenster_1;
MK(6,2) = Q_Kosten_Fenster_1;
MK(7,1) = Q_Kosten_Fenster_2;
MK(7,2) = Q_Kosten_Fenster_2;

GK(1,1) = Q_Kosten_ohne;
GK(1,2) = Q_Kosten_HS;

%Einmal plotten von MW da nachher Kostendiagramm erscheinen soll
figure(1)
subplot(1,2,1)
bar(X,MW);
hold on
title('Waermestroeme')
ylabel('Werte')
set(gca,'fontsize',10)
set(gca,'fontsize',10)
legend('ohne HS','mit HS')
grid minor
subplot(1,2,2)
bar(XG,GW);
hold on
title('Waermestroeme gesamt')
ylabel('Werte')
set(gca,'fontsize',10)
set(gca,'fontsize',10)
legend('ohne HS','mit HS')
grid minor
hold on

%nötige Globale Variable n
global n;
n = 1;
%Knopf 
uicontrol('Style', 'pushbutton', 'String', 'Wechseln', ...
          'Position', [400 5 100 22],'Callback',@(src,event)changePlot(src,event,n,MW,MK,GW,GK,X,XG));

function changePlot(src,event,n,MW,MK,GW,GK,X,XG)
global n; %nötig da sonst n nicht erkannt wird
if n == 2
    subplot(1,2,1)
    grid off
    legend([])
    title([])
    cla
    bar(X,MW);
    hold on
    title('Waermestroeme')
    ylabel('Werte')
    set(gca,'fontsize',10)
    set(gca,'fontsize',10)
    legend('ohne HS','mit HS')
    grid minor
    subplot(1,2,2)
    grid off
    legend([])
    cla
    bar(XG,GW);
    hold on
    title('Waermestroeme gesamt')
    ylabel('Werte')
    set(gca,'fontsize',10)
    set(gca,'fontsize',10)
    legend('ohne HS','mit HS')
    grid minor
    n = 1;
elseif n == 1
    subplot(1,2,1)
    grid off
    legend([])
    title([])
    cla
    bar(X,MK);
    hold on
    title('Kosten')
    ytxt =char(8364);
    ylabel(['Price ' num2str(ytxt)]);
    set(gca,'fontsize',10)
    set(gca,'fontsize',10)
    legend('ohne HS','mit HS')
    grid minor
    subplot(1,2,2)
    grid off
    legend([])
    cla
    bar(XG,GK);
    hold on
    title('Kosten gesamt')
    ytxt =char(8364);
    ylabel(['Price ' num2str(ytxt)]);
    set(gca,'fontsize',10)
    set(gca,'fontsize',10)
    legend('ohne HS','mit HS')
    grid minor
    n = 2;
end
end






