function res=process(ima)
%% HSV Conversion and Separating Red part
% Converts the pre-proccessed RGB frame to HSV 
    
im2=ima;
imh=rgb2hsv(im2);

hband=imh(:,:,1);
sband=imh(:,:,2);
vband=imh(:,:,3);
% Mask to seperate red part with threshold values of 0.75 for S and V
mask=(sband>.75)&(vband>.75);
%imshow(mask);

%figure
fim(:,:,1)=hband.*mask;
fim(:,:,2)=sband.*mask;
fim(:,:,3)=vband.*mask;
figure
imshow(fim);
%% Find centers of red lights 
%Hence the maximum Red light height in frame is returned to main

[centers, radii] = imfindcircles(fim,[3 20])
h = viscircles(centers,radii);
size(radii);
maxRedL=0;
if isempty(radii)==0
    maxRedL = max(centers(:,2));
end

res = maxRedL;




