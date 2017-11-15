function res=preProcess(image)
im=image;
%% NOISE REMOVAL 
redBand = im(:,:, 1);
greenBand = im(:,:, 2);
blueBand = im(:,:, 3);
redm = medfilt2(redBand);
greenm = medfilt2(greenBand);
bluem = medfilt2(blueBand);
imf = uint8(zeros(size(im))); % Initialize
imf(:,:,1) = redm;
imf(:,:,2) = greenm;
imf(:,:,3) = bluem;

% figure
% imshow(imf);


%% IMAGE EROSION 
se1=[[1,1,1];[1,1,1];[1,1,1]];
ime=imerode(imf,se1);
% figure
% imshow(ime);


%% IMAGE DILATION 
se2=[[1,1,1];[1,1,1];[1,1,1]];
    % se = offsetstrel('ball',5,5);

imd=imdilate(ime,se2);
% figure
% imshow(imd);


res=imd;