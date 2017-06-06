function [ im3 ] = generatePanoroma( im1, im2 )
%UNTITLED Summary of this function goes here
%   Detailed explanation 

    [locs1, desc1] = briefLite(rgb2gray(im1));
    [locs2, desc2] = briefLite(rgb2gray(im2));

    [matches] = briefMatch(desc1, desc2, 0.8);

    plotMatches(im1, im2, matches, locs1, locs2);

    H = ransacH(matches, locs1, locs2, 10000, 20);
    
    im3 = imageStitching(im2, im1, H);
    
    imshow(im3);

end

