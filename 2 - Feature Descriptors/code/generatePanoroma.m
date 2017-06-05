function [ im3 ] = generatePanoroma( im1, im2 )
%UNTITLED Summary of this function goes here
%   Detailed explanation 

    %[locs1, desc1] = briefLite(rgb2gray(im1));
    %[locs2, desc2] = briefLite(rgb2gray(im2));

    %[matches] = briefMatch(desc1, desc2, 0.97);

    %plotMatches(im1, im2, matches, locs1, locs2);

    H = ransacH(matches, locs1, locs2, 1000, 20);
    
    im3 = imageStitching(im1, im2, H);
    
    imshow(im3);

end

