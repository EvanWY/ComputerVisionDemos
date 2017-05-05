function PrincipalCurvature = computePrincipalCurvature(DoGPyramid)
%%Edge Suppression
% Takes in DoGPyramid generated in createDoGPyramid and returns
% PrincipalCurvature,a matrix of the same size where each point contains the
% curvature ratio R for the corre-sponding point in the DoG pyramid
%
% INPUTS
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
%
% OUTPUTS
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix where each 
%                      point contains the curvature ratio R for the 
%                      corresponding point in the DoG pyramid

PrincipalCurvature = zeros(size(DoGPyramid));

for idx = 1 : size(DoGPyramid, 3)
    f = DoGPyramid(:,:,idx);
    [fx, fy] = gradient(f);
    [fxx, fxy] = gradient(fx);
    [~, fyy] = gradient(fy);
    
    for i = 1 : size(DoGPyramid, 1)
        for j = 1 : size(DoGPyramid, 2)
            H = [fxx(i,j) fxy(i,j);  fxy(i,j) fyy(i,j)];
            R = trace(H)^2 / det(H);
            PrincipalCurvature(i, j, idx) = R;
        end
    end
    
end