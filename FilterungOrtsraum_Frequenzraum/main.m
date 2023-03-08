clear all
close all
clc

%% Aufgabe: Erstellung zweier Fkt für die Filterung im Orts und Freqzraum
%% Bild einlesen HAND
%% braucht etwas Zeit
Bild = double(im2gray(imread("hands2.jpg")));

%% Filterkerne, Sobel Kerne einmal für x und y Richtung
kernel = [-1 0 1; -2 0 2; -1 0 1];
kernel2 = [-1 -2 -1;0 0 0;1 2 1];
%% Filterkerne Mittelwertkerne mit 3x3, 7x7, 11x11
mitt1  = 1/(3^2).*ones(5,5);
mitt2  = 1/(7^2).*ones(8,8);
mitt3  = 1/(11^2).*ones(13,13);

%% a),b) für Fkt 1 Conv, Filterung durch CONV

img_conv = conv2func(Bild, kernel);
img_conv2 = conv2func(Bild, kernel2);
img_conv3 = conv2func(Bild, mitt1);
img_conv4 = conv2func(Bild, mitt2);
img_conv5 = conv2func(Bild, mitt3);


figure(1)
imagesc(Bild)
title('Natur')
colormap gray

figure(2)
subplot(1,2,1)
imagesc(img_conv)
title('Conv kernel y Richtung')
colormap gray
subplot(1,2,2)
imagesc(img_conv2)
title('Conv kernel x Richtung')
colormap gray

figure(3)
subplot(2,2,1)
imagesc(img_conv3)
title('Conv kernel 5x5')
colormap gray
subplot(2,2,2)
imagesc(img_conv4)
title('Conv kernel 8x8')
colormap gray
subplot(2,2,3)
imagesc(img_conv5)
title('Conv kernel 13x13')
colormap gray

%% a),b) für Fkt 2 Filt2, Filterung durch FFT
img_conv = filt2func(Bild, kernel);
img_conv2 = filt2func(Bild, kernel2);
img_conv3 = filt2func(Bild, mitt1);
img_conv4 = filt2func(Bild, mitt2);
img_conv5 = filt2func(Bild, mitt3);

figure(4)
subplot(1,2,1)
imagesc(abs(img_conv))
title('FFT kernel y Richtung')
colormap gray
subplot(1,2,2)
imagesc(abs(img_conv2))
title('FFT kernel x Richtung')
colormap gray

figure(5)
subplot(2,2,1)
imagesc(abs(img_conv3))
title('FFT kernel 5x5')
colormap gray
subplot(2,2,2)
imagesc(abs(img_conv4))
title('FFT kernel 8x8')
colormap gray
subplot(2,2,3)
imagesc(abs(img_conv5))
title('FFT kernel 13x13')
colormap gray
