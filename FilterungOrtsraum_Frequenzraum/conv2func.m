function [image_conv] = conv2func(image,kernel)
%% Die Randwerte werden hier mit Zero Padding berücksichtigt.

[m,n] = size(image);
[a,b] = size(kernel);
image_conv = zeros(m+floor(a/2),n+floor(b/2)); %Zero Pad

kernel = flip(kernel); %nach oben
kernel = flip(kernel,2); %entlang 2 Dim.

for i = 1:m
    for j = 1:n
        if (i+a <= m) && (j+b <= n)
            f = image(i:i+a-1,j:j+b-1); %original
            h = sum(sum(f.*kernel));
            %center
            center_y = i + floor(length(i:i+a-1)/2);
            center_x = j + floor(length(j:j+b-1)/2);
            image_conv(center_y,center_x) = h;
        end
    end
end

end