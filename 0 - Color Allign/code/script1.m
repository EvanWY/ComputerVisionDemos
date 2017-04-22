% Problem 1: Image Alignment

%% 1. Load images (all 3 channels)
red = [];  % Red channel
green = [];  % Green channel
blue = [];  % Blue channel
load('red.mat');
load('green.mat');
load('blue.mat');
%red = im2double(red);
%green = im2double(green);
%blue = im2double(blue);

%% 2. Find best alignment
% Hint: Lookup the 'circshift' function
rgbResult = alignChannels(red, green, blue);

%% 3. Save result to rgb_output.jpg (IN THE "results" folder)
imshow(rgbResult);

tt=zeros(810,943,3);
tt(:,:,1) = red;
tt(:,:,2) = green;
tt(:,:,3) = blue;
tt = tt / 255;

imwrite(tt,'rgb_origin.jpg');
imwrite(rgbResult,'rgb_ncc.jpg');