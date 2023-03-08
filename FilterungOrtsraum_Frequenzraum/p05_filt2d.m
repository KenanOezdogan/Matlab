function [image_filt] = filt2func(image,kernel)
%% Die Randwerte werden hier mit Zero Padding berücksichtigt.

[m,n] = size(image);
[a,b] = size(kernel);
image_filt = zeros(m+floor(a/2),n+floor(b/2)); %Zero Pad

for i = 1:m
    for j = 1:n
        if (i+a <= m) && (j+b <= n)
            f = image(i:i+a-1,j:j+b-1); %original
            h = fftshift(fft2(fftshift(f))).*fftshift(fft2(fftshift(kernel)));
            h = ifftshift(ifft2(h)); %%Originalausschnitt wieder zuweisen
            image_filt(i:i+a-1,j:j+b-1) = image_filt(i:i+a-1,j:j+b-1) + h;
        end
    end
end
end