function [panoImg] = imageStitching(img1, img2, H2to1)
%
% INPUT
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear
%         equation
%
% OUTPUT
% Blends img1 and warped img2 and outputs the panorama image

    panoImg = img1;
    panoImg(1, size(img1, 2)*2, 1) = 0;

    panoImg = panoImg + warpH(img2, H2to1, size(panoImg));

end