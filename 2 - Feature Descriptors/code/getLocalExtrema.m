function locsDoG = getLocalExtrema(DoGPyramid, DoGLevels, ...
                        PrincipalCurvature, th_contrast, th_r)
%%Detecting Extrema
% INPUTS
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
% DoG Levels  - The levels of the pyramid where the blur at each level is
%               outputs
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix contains the
%                      curvature ratio R
% th_contrast - remove any point that is a local extremum but does not have a
%               DoG response magnitude above this threshold
% th_r        - remove any edge-like points that have too large a principal
%               curvature ratio
%
% OUTPUTS
% locsDoG - N x 3 matrix where the DoG pyramid achieves a local extrema in both
%           scale and space, and also satisfies the two thresholds.

l = circshift(DoGPyramid, [1, 0, 0]);
r = circshift(DoGPyramid, [-1, 0, 0]);
f = circshift(DoGPyramid, [0, 1, 0]);
b = circshift(DoGPyramid, [0, -1, 0]);
lf = circshift(DoGPyramid, [1, 1, 0]);
rf = circshift(DoGPyramid, [-1, 1, 0]);
lb = circshift(DoGPyramid, [1, -1, 0]);
rb = circshift(DoGPyramid, [-1, -1, 0]);
down = circshift(DoGPyramid, [0, 0, 1]);
up = circshift(DoGPyramid, [0, 0, -1]);


[locsDoG(1,:,:)] = find(DoGPyramid > th_contrast & PrincipalCurvature < th_r ...
& DoGPyramid > l & DoGPyramid > r & DoGPyramid > f & DoGPyramid > b ...
& DoGPyramid > lf & DoGPyramid > rf & DoGPyramid > lb & DoGPyramid > rb ...
& DoGPyramid > down & DoGPyramid > up);

