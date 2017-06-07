function [locs, desc] = briefLite(im)
% INPUTS
% im - gray image with values between 0 and 1
%
% OUTPUTS
% locs - an m x 3 vector, where the first two columns are the image coordinates 
% 		 of keypoints and the third column is the pyramid level of the keypoints
% desc - an m x n bits matrix of stacked BRIEF descriptors. 
%		 m is the number of valid descriptors in the image and will vary
% 		 n is the number of bits for the BRIEF descriptor

    load('testPattern.mat');

    [locsDoG, GaussianPyramid] = DoGdetector(im, 1, sqrt(2), [-1,0,1,2,3,4], 0.03, 12);
    [locs,desc] = computeBrief(im, GaussianPyramid, locsDoG, sqrt(2), [-1,0,1,2,3,4], compareA, compareB);

end