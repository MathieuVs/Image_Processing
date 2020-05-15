clear all; close all; clc; 

[aind,amap] = imread('corn.tif',2); 
% image = im2double(image); 
% iteration = 200; 
% k = 0.05;  
% image  = anisodiff(image,iteration,k);
% imshow(image);
J = rangefilt(image)

[n,m] =  size(image)
for i = 1 : m
    for j = 1:n
        if J(i,j) >=00
%             J(i,j) = 1; 
        else 
            J(i,j) = 0; 
        end
    end
end
figure; imshow(J)

edges = edge(image, 'sobel') ; 
% figure; imshow(edges)




[r c] = ginput(4); 
bw = roipoly(image, r,c);

figure; 
imshow(bw)
col = []; 
[R C] = size(bw);
out = zeros(R,C);
keep = []; 
for i = 1 : R 
    for j = 1 : C 
        if bw(i, j) == 1
            out(i,j) = J(i,j); 
            keep(end+1) = J(i,j); 
        end
    end
end
res = zeros(R,C); 
for i = 1 : R 
    for j = 1 : C 
        for k = 1 : length(keep)
            
        if J(i,j) == keep(k)
            res(i,j) = image(i,j); 
        end
        end
    end
end

figure; 
imshow(out, [])

% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
