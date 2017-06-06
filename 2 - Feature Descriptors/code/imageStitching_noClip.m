function [panoImg] = imageStitching_noClip(img1, img2, H2to1)
%
% INPUT
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear
%         equation
%
% OUTPUT
% Blends img1 and warped img2 and outputs the panorama image

    corners = [0,size(img2, 2),0,size(img2, 2); 0,size(img2,1),size(img2, 1),0; 1,1,1,1];
    corners = H2to1 * corners;
    corners = corners ./ corners(3,:);
    corners = corners(1:2,:);
    corners(:,5:6) = [0,size(img1, 2); 0,size(img1,1)];
    
    corners = floor(corners);
    
    
    minX = min(corners(1,:));
    maxX = max(corners(1,:));
    minY = min(corners(2,:));
    maxY = max(corners(2,:));
    
    panoImg = zeros(maxY - minY + 20, maxX - minX + 20);
    M = [1 0 -minX+10; 0 1 -minY+10; 0 0 1];

    panoImg = warpH(img1, M, size(panoImg))/2 + warpH(img2, M * H2to1, size(panoImg))/2;

end